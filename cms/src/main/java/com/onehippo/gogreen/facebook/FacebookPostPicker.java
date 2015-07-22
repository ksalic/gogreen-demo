/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.onehippo.gogreen.facebook;

import facebook4j.Facebook;
import facebook4j.Post;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Value;

import facebook4j.Reading;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.wicket.MarkupContainer;
import org.hippoecm.frontend.editor.editor.EditorForm;
import org.onehippo.forge.exdocpicker.api.ExternalDocumentCollection;
import org.onehippo.forge.exdocpicker.api.ExternalDocumentServiceContext;
import org.onehippo.forge.exdocpicker.api.ExternalDocumentServiceFacade;
import org.onehippo.forge.exdocpicker.impl.SimpleExternalDocumentCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FacebookPostPicker implements ExternalDocumentServiceFacade<JSONObject> {

    /**
     * Plugin parameter name for physical document field name (JCR property
     * name).
     */
    public static final String PARAM_EXTERNAL_DOCS_FIELD_NAME = "example.external.docs.field.name";

    private static final long serialVersionUID = 1L;

    private static Logger log = LoggerFactory.getLogger(FacebookPostPicker.class);

    private JSONArray docArray;
    private static String FB_PARAMETER_PROVIDER_NODE_NAME = "cluster.options";
    private static String FB_APP_ID_PROPERTY = "fb_app_id";
    private static String FB_APP_SECRET_PROPERTY = "fb_app_secret";
    private static String FB_ACCESS_TOKEN_PROPERTY = "fb_access_token";

    private String FB_APP_ID = "";
    private String FB_APP_SECRET = "";
    private String FB_ACCESS_TOKEN = "";
    private ExternalDocumentServiceContext context;

    public FacebookPostPicker() {

    }

    /**
     * Initialize facebook object, posts
     *
     * @throws Exception
     */
    private void init(ExternalDocumentServiceContext context) throws Exception {

        // get fb_app_id, fb_app_secret, fb_access_token from cluster.options
        FB_APP_ID = context.getPluginConfig().getPluginConfig(FB_PARAMETER_PROVIDER_NODE_NAME).getString(FB_APP_ID_PROPERTY);
        FB_APP_SECRET = context.getPluginConfig().getPluginConfig(FB_PARAMETER_PROVIDER_NODE_NAME).getString(FB_APP_SECRET_PROPERTY);
        FB_ACCESS_TOKEN = context.getPluginConfig().getPluginConfig(FB_PARAMETER_PROVIDER_NODE_NAME).getString(FB_ACCESS_TOKEN_PROPERTY);

        Facebook facebook = FacebookConnector.getFacebook(FB_APP_ID.trim(), FB_APP_SECRET.trim(), FB_ACCESS_TOKEN.trim());

        Iterator<Post> posts = facebook.getPosts(new Reading().fields("from,message,id,icon,created_time,link")).iterator();

        docArray = new JSONArray();

        while (posts.hasNext()) {
            try {

                Post p = posts.next();
                if (p.getMessage() == null || p.getMessage().trim().equals("")) {
                    continue;
                }
                JSONObject obj = new JSONObject();

                obj.put("id", p.getId());
                obj.put("icon", p.getIcon());

                if (p.getActions() != null && p.getActions().size() > 0) {
                    obj.put("link", p.getActions().get(0).getLink());
                }

                obj.put("title", p.getMessage());
                // obj.put("description", p.getMessage());
                obj.put("from", p.getFrom().getName());
                obj.put("date", p.getCreatedTime().getTime());
                docArray.add(obj);
            } catch (Exception e) {
                //continue anyway
            }

        }
    }

    @Override
    public ExternalDocumentCollection<JSONObject> searchExternalDocuments(ExternalDocumentServiceContext context, String queryString) {
        ExternalDocumentCollection<JSONObject> docCollection = new SimpleExternalDocumentCollection<JSONObject>();
        int size = docArray.size();

        if (StringUtils.isBlank(queryString)) {
            for (int i = 0; i < size; i++) {
                docCollection.add(docArray.getJSONObject(i));
            }
        } else {
            for (int i = 0; i < size; i++) {
                JSONObject doc = docArray.getJSONObject(i);

                if (StringUtils.contains(doc.toString(), queryString)) {
                    docCollection.add(doc);
                }
            }
        }

        return docCollection;
    }

    private boolean initialized = false;

    @Override
    public ExternalDocumentCollection<JSONObject> getFieldExternalDocuments(ExternalDocumentServiceContext context) {
        final String fieldName = context.getPluginConfig().getString(PARAM_EXTERNAL_DOCS_FIELD_NAME);
        if (!initialized) {
            try {

                init(context);
                initialized = true;

            } catch (Exception e) {
                log.warn("Something went wrong ...", e);
            }

        }

        if (StringUtils.isBlank(fieldName)) {
            throw new IllegalArgumentException("Invalid plugin configuration parameter for '" + PARAM_EXTERNAL_DOCS_FIELD_NAME + "': " + fieldName);
        }

        ExternalDocumentCollection<JSONObject> docCollection = new SimpleExternalDocumentCollection<JSONObject>();

        try {
            final Node contextNode = context.getContextModel().getNode();

            if (contextNode.hasProperty(fieldName)) {
                Value[] values = contextNode.getProperty(fieldName).getValues();

                for (Value value : values) {
                    String id = value.getString();
                    JSONObject doc = findDocumentById(id);

                    if (doc != null) {
                        docCollection.add(doc);
                    }
                }
            }
        } catch (RepositoryException e) {
            log.error("Failed to retrieve related exdoc array field.", e);
        }

        return docCollection;
    }

    @Override
    public void setFieldExternalDocuments(ExternalDocumentServiceContext context, ExternalDocumentCollection<JSONObject> exdocs) {

        final String fieldName = context.getPluginConfig().getString(PARAM_EXTERNAL_DOCS_FIELD_NAME);

        if (StringUtils.isBlank(fieldName)) {
            throw new IllegalArgumentException("Invalid plugin configuration parameter for '" + PARAM_EXTERNAL_DOCS_FIELD_NAME + "': " + fieldName);
        }

        try {
            final Node contextNode = context.getContextModel().getNode();
            final List<String> docIds = new ArrayList<String>();

            for (Iterator<? extends JSONObject> it = exdocs.iterator(); it.hasNext();) {
                JSONObject doc = it.next();

                docIds.add(doc.getString("id"));
            }

            contextNode.setProperty(fieldName, docIds.toArray(new String[docIds.size()]));
            //Add relative content such as post description, posted by user name, and date/time creation etc into
            // corresponding repository properties
            JSONObject doc = this.findDocumentById(docIds.get(0));
            if (doc.has("title")) {
                contextNode.setProperty("hippogogreen:post", doc.getString("title"));
            }
            if (doc.has("from")){
                contextNode.setProperty("hippogogreen:from", doc.getString("from"));
            }
            if (doc.has("date")){
                Calendar cal = Calendar.getInstance();
                cal.setTime(new Date(doc.getLong("date")));
                contextNode.setProperty("hippogogreen:date", cal);
            }
            if (doc.has("link")){
                contextNode.setProperty("hippogogreen:link", doc.getString("link"));
            }

            // contextNode.setProperty("exdocpickerbasedemo:post3437874", doc.getString("description"));
            //  contextNode.setProperty("exdocpickerbasedemo:metatags", "this is a test");
            MarkupContainer container = ((MarkupContainer) context.getPlugin()).getParent();
            for (; container != null; container = container.getParent()) {
                if (container instanceof EditorForm) {
                    ((EditorForm) container).onModelChanged();
                    break;
                }
            }

        } catch (Exception e) {
            log.error("Failed to set related exdoc array field.", e);
        }
    }

    @Override
    public String getDocumentTitle(ExternalDocumentServiceContext context, JSONObject doc, Locale preferredLocale) {
        if (doc != null && doc.has("title")) {
            return doc.getString("title");

        }

        return "";
    }

    @Override
    public String getDocumentDescription(ExternalDocumentServiceContext context, JSONObject doc, Locale preferredLocale) {
        if (doc != null && doc.has("description")) {
            return doc.getString("description");
        }

        return "";
    }

    @Override
    public String getDocumentIconLink(ExternalDocumentServiceContext context, JSONObject doc, Locale preferredLocale) {
        if (doc != null && doc.has("icon")) {
            return doc.getString("icon");
        }

        return "";
    }

    private JSONObject findDocumentById(final String id) {
        for (int i = 0; i < docArray.size(); i++) {
            JSONObject doc = docArray.getJSONObject(i);

            if (StringUtils.equals(id, doc.getString("id"))) {
                return doc;
            }
        }

        return null;
    }

}
