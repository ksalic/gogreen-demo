/*
 *  Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;


import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.jcr.Node;
import javax.jcr.Property;
import javax.jcr.PropertyType;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.onehippo.cms7.targeting.TargetingJcrConstants;
import com.onehippo.cms7.targeting.collectors.AbstractTermsCollector;
import com.onehippo.cms7.targeting.data.TermsTargetingData;


public class TagsQuerystringCollector extends AbstractTermsCollector {

    private static final String QUERY_PARAMETER_PROPERTY_NAME = TargetingJcrConstants.TARGETING_COLLECTOR_QUERY_PARAMETER_PROPERTY;
    private static final String DEFAULT_QUERY_PARAMETER = "query";
    
    private String queryParameter = DEFAULT_QUERY_PARAMETER;

    public TagsQuerystringCollector(String id, Node node) throws RepositoryException {
        super(id, node);
        if (node != null && node.hasProperty(QUERY_PARAMETER_PROPERTY_NAME)) {
            Property prop = node.getProperty(QUERY_PARAMETER_PROPERTY_NAME);
            if(prop.getType() == PropertyType.STRING) {
                queryParameter = prop.getString();
            }
        }
    }

    @Override
    protected List<String> extractTerms(HttpServletRequest request) {
        final String[] values = request.getParameterValues(queryParameter);
        
        if(values == null || values.length == 0) {
            return null;
        }
        return Arrays.asList(values);
    }

    @Override
    public TermsTargetingData convertJsonToTargetingData(final ObjectNode objectNode, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    @Override
    public JsonNode convertTargetingDataToJson(final TermsTargetingData termsTargetingData, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    @Override
    public TermsTargetingRequestData convertJsonToRequestData(final JsonNode jsonNode, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    @Override
    public JsonNode convertRequestDataToJson(final TermsTargetingRequestData termsTargetingRequestData, final ObjectMapper objectMapper) throws IOException {
        return null;
    }
}
