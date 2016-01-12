/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import static com.onehippo.gogreen.utils.Constants.PROP_DESCRIPTION;

import javax.jcr.RepositoryException;

import org.hippoecm.hst.content.beans.ContentNodeBindingException;
import org.hippoecm.hst.content.beans.Node;


/**
 * [hippogogreen:product] > hippogogreen:document, relateddocs:relatabledocs
 * - hippogogreen:price (double)
 * - hippogogreen:rating (double)
 * - hippogogreen:votes (long)
 * - hippogogreen:categories (string) multiple
 * + hippogogreen:images (hippogallerypicker:imagelink) multiple
 */
@Node(jcrType = "hippogogreen:product")
public class Product extends Document {

    private Double price;

    public void setPrice(Double price) {
        this.price = price;
    }
    
    public Double getPrice() {
        if (price == null) {
            price = getProperty("hippogogreen:price");
        }
        return price;
    }
    
    public Double getResellerPrice() {
        return getPrice() * 0.9;
    }

    public Double getRating() {
        return getProperty("hippogogreen:rating");
    }

    public Long getVotes() {
        return getProperty("hippogogreen:votes");
    }

    public String[] getCategories() {
        return getProperty("hippogogreen:categories");
    }

    @Override
    public boolean bind(Object content, javax.jcr.Node node) throws ContentNodeBindingException {
        super.bind(content, node);

        Product bean = (Product) content;

        try {
            node.setProperty("hippogogreen:title", bean.getTitle());
            node.setProperty("hippogogreen:summary", bean.getSummary());
            node.setProperty("hippogogreen:price", bean.getPrice());

            if (getDescriptionContent() != null) {
                if (node.hasNode(PROP_DESCRIPTION)) {
                    javax.jcr.Node htmlNode = node.getNode(PROP_DESCRIPTION);
                    if (!htmlNode.isNodeType("hippostd:html")) {
                        throw new ContentNodeBindingException("Expected html node of type 'hippostd:html' but was '" + htmlNode.getPrimaryNodeType().getName() + "'");
                    }
                    htmlNode.setProperty("hippostd:content", getDescriptionContent());
                } else {
                    javax.jcr.Node html = node.addNode(PROP_DESCRIPTION, "hippostd:html");
                    html.setProperty("hippostd:content", html);
                }
            }
        } catch (RepositoryException e) {
            throw new ContentNodeBindingException(e);
        }

        return true;
    }

}
