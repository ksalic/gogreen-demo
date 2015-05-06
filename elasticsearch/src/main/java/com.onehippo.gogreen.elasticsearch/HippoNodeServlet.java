/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;

import org.elasticsearch.common.logging.ESLogger;
import org.elasticsearch.common.logging.ESLoggerFactory;
import org.elasticsearch.common.logging.slf4j.Slf4jESLogger;
import org.elasticsearch.common.logging.slf4j.Slf4jESLoggerFactory;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.node.NodeBuilder;
import org.elasticsearch.node.internal.InternalNode;
import org.elasticsearch.rest.RestController;
import org.elasticsearch.wares.NodeServlet;
import org.hippoecm.repository.util.RepoUtils;
import org.slf4j.LoggerFactory;

public class HippoNodeServlet extends NodeServlet {

    @Override
    public void init() throws ServletException {
        final Object nodeAttribute = getServletContext().getAttribute(NODE_KEY);
        if (nodeAttribute == null || !(nodeAttribute instanceof InternalNode)) {
            if (nodeAttribute != null) {
                getServletContext().log(
                        "Warning: overwriting attribute with key \"" + NODE_KEY + "\" and type \""
                                + nodeAttribute.getClass().getName() + "\".");
            }
            getServletContext().log("Initializing elasticsearch Node '" + getServletName() + "'");

            ESLoggerFactory.setDefaultFactory(new Slf4jESLoggerFactory() {
                @Override
                protected ESLogger rootLogger() {
                    return new Slf4jESLogger("ES", LoggerFactory.getLogger("org.elasticsearch"));
                }
            });

            ImmutableSettings.Builder settings = ImmutableSettings.settingsBuilder();
            try (InputStream resourceAsStream = getServletContext().getResourceAsStream("/WEB-INF/elasticsearch.yml")) {
                settings.loadFromStream("/WEB-INF/elasticsearch.yml", resourceAsStream);
            } catch (IOException e) {
                // ignore
            }

            String esPath = getStoragePath();
            if (esPath == null) {
                esPath = getServletContext().getInitParameter("es.path");
            }
            if (esPath != null) {
                settings.put("path.home", esPath);
            }

            if (settings.get("http.enabled") == null) {
                settings.put("http.enabled", false);
            }

            node = NodeBuilder.nodeBuilder().settings(settings).node();
            getServletContext().setAttribute(NODE_KEY, node);
        } else {
            getServletContext().log("Using pre-initialized elasticsearch Node '" + getServletName() + "'");
            this.node = (InternalNode) nodeAttribute;
        }
        restController = ((InternalNode) node).injector().getInstance(RestController.class);
    }

    protected String getStoragePath() {
        String path = System.getProperty("es.path");
        if (path != null) {
            if (path.isEmpty()) {
                path = null;
            } else {
                path = RepoUtils.stripFileProtocol(path);
                if (path.startsWith("~" + File.separator)) {
                    path = System.getProperty("user.home") + path.substring(1);
                }
            }
        }

        String basePath = path != null ? System.getProperty("repo.base.path") : null;
        if (basePath != null) {
            if (basePath.isEmpty()) {
                basePath = null;
            } else {
                basePath = RepoUtils.stripFileProtocol(basePath);
            }
        }

        if (path == null) {
            return null;
        } else if (!(new File(path)).isAbsolute() && basePath != null) {
            return basePath + System.getProperty("file.separator") + path;
        } else {
            return path;
        }
    }

}
