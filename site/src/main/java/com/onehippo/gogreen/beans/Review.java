/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import java.util.Calendar;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.ContentNodeBinder;
import org.hippoecm.hst.content.beans.ContentNodeBindingException;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoMirror;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static com.onehippo.gogreen.utils.Constants.NT_PRODUCTLINK;
import static com.onehippo.gogreen.utils.Constants.PROP_COMMENT;
import static com.onehippo.gogreen.utils.Constants.PROP_DATE;
import static com.onehippo.gogreen.utils.Constants.PROP_EMAIL;
import static com.onehippo.gogreen.utils.Constants.PROP_NAME;
import static com.onehippo.gogreen.utils.Constants.PROP_RATING;


/**
 * [hippogogreen:review] > hippogogreen:basedocument
 * - hippogogreen:name (string)
 * - hippogogreen:email (string)
 * - hippogogreen:rating (long)
 * - hippogogreen:comment (string)
 * + hippogogreen:productlink (hippo:mirror)
 */

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = Constants.NT_REVIEW)
public class Review extends BaseDocument implements ContentNodeBinder {

    private static final Logger log = LoggerFactory.getLogger(Review.class);

    private String name;
    private String email;
    private Long rating;
    private String comment;
    private String productUuid;
    private Calendar date;

    public Calendar getDate() {
        return (date == null) ? (Calendar) getSingleProperty(PROP_DATE) : date;
    }

    public String getName() {
        return (name == null) ? (String) getSingleProperty(PROP_NAME) : name;
    }

    public String getEmail() {
        return (email == null) ? (String) getSingleProperty(PROP_EMAIL) : email;
    }

    public Long getRating() {
        return (rating == null) ? (Long) getSingleProperty(PROP_RATING) : rating;
    }

    public String getComment() {
        return (comment == null) ? (String) getSingleProperty(PROP_COMMENT) : comment;
    }

    public String getProductUuid() {
        return productUuid;
    }

    public void setProductUuid(String uuid) {
        this.productUuid = uuid;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setRating(Long rating) {
        this.rating = rating;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Product getProduct() {
        HippoBean bean = getBean(NT_PRODUCTLINK);
        if (!(bean instanceof HippoMirror)) {
            return null;
        }

        Product prdBean = (Product) ((HippoMirror) bean).getReferencedBean();

        if (prdBean == null) {
            return null;
        }
        return prdBean;
    }

    @Override
    public boolean bind(Object content, javax.jcr.Node node) throws ContentNodeBindingException {
        if (content instanceof Review) {
            try {
                Review review = (Review) content;
                node.setProperty(PROP_NAME, review.getName());
                node.setProperty(PROP_EMAIL, review.getEmail());
                node.setProperty(PROP_COMMENT, review.getComment());
                node.setProperty(PROP_RATING, review.getRating());
                node.setProperty(PROP_DATE, Calendar.getInstance());

                javax.jcr.Node prdLinkNode;

                if (node.hasNode(NT_PRODUCTLINK)) {
                    prdLinkNode = node.getNode(NT_PRODUCTLINK);
                } else {
                    prdLinkNode = node.addNode(NT_PRODUCTLINK, "hippo:mirror");
                }
                prdLinkNode.setProperty("hippo:docbase", review.getProductUuid());

            } catch (Exception e) {
                log.error("Unable to bind the content to the JCR Node" + e.getMessage(), e);
                throw new ContentNodeBindingException(e);
            }

        }
        return true;
    }
}
