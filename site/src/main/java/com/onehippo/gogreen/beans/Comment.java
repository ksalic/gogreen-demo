/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.ContentNodeBinder;
import org.hippoecm.hst.content.beans.ContentNodeBindingException;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoMirror;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * [hippogogreen:comment] > hippogogreen:basedocument
 * - hippogogreen:name (string)
 * - hippogogreen:email (string)
 * - hippogogreen:body (string)
 */

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = Constants.NT_COMMENT)
public class Comment extends BaseDocument implements ContentNodeBinder {

    private static final Logger log = LoggerFactory.getLogger(Comment.class);

    private String name;
    private String email;
    private String body;
    private String documentUuid;

    public String getName() {
        return (name == null) ? (String) getSingleProperty(Constants.PROP_NAME) : name;
    }

    public String getEmail() {
        return (email == null) ? (String) getSingleProperty(Constants.PROP_EMAIL) : email;
    }

    public String getBody() {
        return (body == null) ? (String) getSingleProperty(Constants.PROP_BODY) : body;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getDocumentUuid() {
        return documentUuid;
    }

    public void setDocumentUuid(String uuid) {
        this.documentUuid = uuid;
    }
    
    public Document getDocument() {
        HippoBean bean = getBean(Constants.NT_DOCUMENTLINK);
        
        if (!(bean instanceof HippoMirror)) {
            return null;
        }

        HippoMirror mirror = (HippoMirror) bean;
        Document document = (Document) mirror.getReferencedBean();

        if (document == null) {
            return null;
        }
        return document;
    }
    
    @Override
    public boolean bind(Object content, javax.jcr.Node node) throws ContentNodeBindingException {
        if (content instanceof Comment) {
            try {
                Comment comment = (Comment) content;
                node.setProperty(Constants.PROP_NAME, comment.getName());
                node.setProperty(Constants.PROP_EMAIL, comment.getEmail());
                node.setProperty(Constants.PROP_BODY, comment.getBody());
                
                javax.jcr.Node documentLinkNode;

                if (node.hasNode(Constants.NT_DOCUMENTLINK)) {
                    documentLinkNode = node.getNode(Constants.NT_DOCUMENTLINK);
                } else {
                    documentLinkNode = node.addNode(Constants.NT_DOCUMENTLINK, Constants.NT_HIPPO_MIRROR);
                }
                documentLinkNode.setProperty(Constants.PROP_HIPPO_DOCBASE, comment.getDocumentUuid());

            } catch (Exception e) {
                log.error("Unable to bind the content to JCR node", e);
                throw new ContentNodeBindingException(e);
            }
        }
        return true;
    }
}