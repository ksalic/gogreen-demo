/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.jaxrs.services;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.hippoecm.hst.jaxrs.services.AbstractResource;
import org.hippoecm.hst.site.HstServices;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/age/")
public class SimpleAgeServiceResource extends AbstractResource {

    private static Logger log = LoggerFactory.getLogger(SimpleAgeServiceResource.class);

    private String dataResourcePath;

    @GET
    @Path("/{user}/")
    public String getProductResources(@Context HttpServletRequest servletRequest, 
            @Context HttpServletResponse servletResponse, @Context UriInfo uriInfo,
            @PathParam("user") String userId) {

        int age = -1;

        Properties data = getAgeDataProperties();

        if (data != null) {
            age = NumberUtils.toInt(data.getProperty(userId), -1);
        }

        return Integer.toString(age);
    }

    public String getDataResourcePath() {
        return dataResourcePath;
    }

    public void setDataResourcePath(String dataResourcePath) {
        this.dataResourcePath = dataResourcePath;
    }

    private Properties getAgeDataProperties() {
        Properties data = new Properties();

        if (getDataResourcePath() != null) {
            InputStream is = null;
            BufferedInputStream bis = null;

            try {
                ServletContext servletContext = HstServices.getComponentManager().getServletContext();
                is = servletContext.getResourceAsStream(getDataResourcePath());
                bis = new BufferedInputStream(is);
                data.load(bis);
            } catch (IOException e) {
                log.error("Failed to load age data.", e);
            } finally {
                IOUtils.closeQuietly(bis);
                IOUtils.closeQuietly(is);
            }
        }

        return data;
    }
}