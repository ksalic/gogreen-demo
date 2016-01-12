/*
 *  Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.jaxrs.services;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

import org.hippoecm.hst.content.rewriter.ContentRewriter;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.jaxrs.services.content.AbstractContentResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.onehippo.gogreen.beans.Product;
import com.onehippo.gogreen.jaxrs.model.ProductRepresentation;


/**
 * @version $Id$
 */
@Path("/hippogogreen:product/")
public class ProductContentResource extends AbstractContentResource {
    
    private static Logger log = LoggerFactory.getLogger(ProductContentResource.class);
    
    @GET
    @Path("/")
    public ProductRepresentation getProductResource(@Context HttpServletRequest servletRequest, @Context HttpServletResponse servletResponse, @Context UriInfo uriInfo) {
        try {
            HstRequestContext requestContext = getRequestContext(servletRequest);     
            ContentRewriter<String> contentRewriter = getContentRewriter();
            Product productBean = (Product) getRequestContentBean(requestContext);
            ProductRepresentation productRep = new ProductRepresentation(requestContext, contentRewriter).represent(productBean);
            productRep.addLink(getNodeLink(requestContext, productBean));
            productRep.addLink(getSiteLink(requestContext, productBean));
            return productRep;
        } catch (Exception e) {
            if (log.isDebugEnabled()) {
                log.warn("Failed to retrieve content bean.", e);
            } else {
                log.warn("Failed to retrieve content bean. {}", e.toString());
            }
            
            throw new WebApplicationException(e);
        }
    }    
}
