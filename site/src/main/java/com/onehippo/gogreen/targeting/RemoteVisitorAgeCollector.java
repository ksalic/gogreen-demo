/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import java.io.IOException;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.hippoecm.repository.util.JcrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * AbstractContentVisitCollector
 */
public class RemoteVisitorAgeCollector extends AbstractVisitorAgeCollector {

    private static Logger log = LoggerFactory.getLogger(RemoteVisitorAgeCollector.class);

    private static final String DEFAULT_REST_API_URI = "http://localhost:8080/site/restapi/age/default/";

    private static final String REST_URI_PROP_NAME = "rest.uri";

    private String restApiUri = DEFAULT_REST_API_URI;

    private CloseableHttpClient httpClient;

    public RemoteVisitorAgeCollector(String id, Node node) throws RepositoryException {
        super(id, node);

        if (node.hasProperty(REST_URI_PROP_NAME)) {
            restApiUri = JcrUtils.getStringProperty(node, REST_URI_PROP_NAME, restApiUri);
        }

        httpClient = HttpClients.createDefault();
    }

    @Override
    public void dispose() {
        super.dispose();

        try {
            httpClient.close();
        } catch (IOException e) {
            log.error("Error ocurred while closing http client.", e);
        }
    }

    @Override
    protected Integer extractAge(HttpServletRequest request) {
        int age = -1;

        CloseableHttpResponse httpResponse = null;
        HttpEntity httpEntity = null;

        try {
            HttpGet httpGet = new HttpGet(restApiUri);
            httpResponse = httpClient.execute(httpGet);

            if (httpResponse.getStatusLine().getStatusCode() == HttpServletResponse.SC_OK) {
                httpEntity = httpResponse.getEntity();
                age = NumberUtils.toInt(StringUtils.trim(EntityUtils.toString(httpEntity)), -1);
            }
        } catch (Exception e) {
            log.error("Failed to invoke rest service to get age.", e);
        } finally {
            try {
                EntityUtils.consume(httpEntity);
            } catch (IOException ignore) {
            }

            if (httpResponse != null) {
                try {
                    httpResponse.close();
                } catch (IOException ignore) {
                }
            }
        }

        return age;
    }
}
