/*
 *  Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.jaxrs.model;

import javax.jcr.RepositoryException;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.hippoecm.hst.content.beans.standard.HippoResource;
import org.hippoecm.hst.core.container.ContainerConstants;
import org.hippoecm.hst.core.request.HstRequestContext;

import com.onehippo.gogreen.beans.Product;
import com.onehippo.gogreen.beans.compound.ImageSet;

/**
 * @version $Id: ProductLinkRepresentation.java 37846 2013-01-10 16:29:38Z mdenburger $
 */
@XmlRootElement(name = "product")
public class ProductLinkRepresentation extends BaseDocumentRepresentation {

    private String productLink;
    private double price;
    private double rating;
    private String smallThumbnail;

    protected HstRequestContext requestContext;

    public ProductLinkRepresentation() {}
    
    public ProductLinkRepresentation(HstRequestContext requestContext) {
        this.requestContext = requestContext;
    }

    public ProductLinkRepresentation represent(Product bean) throws RepositoryException {
        super.represent(bean);

        this.productLink = this.requestContext.getHstLinkCreator().create(bean.getNode(), this.requestContext,
                "restapi").toUrlForm(this.requestContext, true);

        this.price = bean.getPrice();
        this.rating = bean.getRating();
        this.smallThumbnail = buildImageLinkUrl(bean, "hippogogreengallery:smallthumbnail");

        return this;
    }

    @XmlElement(name = "productLink")
    public String getProductLink() {
        return productLink;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getSmallThumbnail() {
        return smallThumbnail;
    }

    private String buildImageLinkUrl(Product product, String relPath) {
        ImageSet imageSet = product.getFirstImage();

        if (imageSet == null) {
            return null;
        }

        HippoResource imageResource = imageSet.getBean(relPath);

        if (imageResource == null) {
            return null;
        }

        return requestContext.getHstLinkCreator().create(imageResource.getNode(), this.requestContext,
                ContainerConstants.MOUNT_ALIAS_SITE).toUrlForm(this.requestContext, true);
    }

}
