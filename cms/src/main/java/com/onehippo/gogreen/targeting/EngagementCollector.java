/*
 * Copyright 2012-2018 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.fasterxml.jackson.jaxrs.json.JacksonJaxbJsonProvider;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.onehippo.cms7.targeting.collectors.AbstractCollector;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.apache.commons.io.IOUtils;
import org.hippoecm.hst.util.HstRequestUtils;
import org.hippoecm.repository.util.JcrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.io.InputStream;
import java.net.*;
import java.nio.charset.Charset;
import java.util.*;
import java.util.concurrent.TimeUnit;

@SuppressWarnings("unused")
public class EngagementCollector extends AbstractCollector<EngagementData, List<String>> {

    private static final Logger log = LoggerFactory.getLogger(EngagementCollector.class);

    private static final String PROJECT_ID = "project.id";

    private final String projectid;

    private final boolean enabled;

    @SuppressWarnings("unused")
    public EngagementCollector(String id, Node node) throws IllegalArgumentException, RepositoryException {
        super(id);
        projectid = JcrUtils.getStringProperty(node, PROJECT_ID, null);
        enabled = JcrUtils.getBooleanProperty(node, "enabled", true);
        if (projectid == null) {
            final String nodePath = JcrUtils.getNodePathQuietly(node);
            throw new IllegalArgumentException("Engagement should be configured with property 'projectid'."
                    + ((nodePath == null) ? "" : "Set the value of this property at '"
                    + nodePath + "/@project.id'"));

        }
    }

    private final LoadingCache<String, List<String>> cache = CacheBuilder.newBuilder()
            .maximumSize(1000)
            .expireAfterWrite(1, TimeUnit.MINUTES)
            .build(new CacheLoader<String, List<String>>() {
                @Override
                public List<String> load(final String id) {
                    //todo
                    Client client = ClientBuilder.newBuilder().newClient();
                    List collection = client.target("https://api-demoapp.exponea.com").path(String.format("/data/v2/projects/%s/customers/%s/exposed-segmentations", projectid, id)).request().get(List.class);
                    return collection;
                }
            });

    @Override
    public List<String> getTargetingRequestData(final HttpServletRequest request,
                                                final boolean newVisitor,
                                                final boolean newVisit,
                                                final EngagementData targetingData) {
        if (!newVisit) {
            if (targetingData != null) {
                return targetingData.getSegments();
            }
            log.warn("Unexpected empty ...");
        }
        Optional<Cookie> engagementId = Arrays.stream(request.getCookies())
                .filter(cookie -> cookie.getName().equals("__exponea_etc__"))
                .findFirst();

        if (enabled && engagementId.isPresent()) {
            return cache.getUnchecked(engagementId.get().getValue());
        }
        return Collections.emptyList();
    }

    @Override
    public EngagementData updateTargetingData(EngagementData data, final List<String> segments) throws IllegalArgumentException {
        if (data == null) {
            data = new EngagementData(getId(), segments);
        } else {
            data.setSegments(segments);
        }
        return data;
    }


}
