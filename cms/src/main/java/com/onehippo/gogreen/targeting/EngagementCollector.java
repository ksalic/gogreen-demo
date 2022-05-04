/*
 * Copyright 2012-2018 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.google.common.collect.ImmutableMap;
import com.onehippo.cms7.targeting.collectors.AbstractCollector;
import org.hippoecm.repository.util.JcrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import java.util.*;
import java.util.concurrent.TimeUnit;

@SuppressWarnings("unused")
public class EngagementCollector extends AbstractCollector<EngagementData, EngagementCollector.EngagementRequestData> {

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
            throw new IllegalArgumentException("Engagement should be configured with property 'project.id'."
                    + ((nodePath == null) ? "" : "Set the value of this property at '"
                    + nodePath + "/@project.id'"));

        }
    }

    private final LoadingCache<String, List<String>> cache = CacheBuilder.newBuilder()
            .maximumSize(1000)
            .expireAfterWrite(1, TimeUnit.SECONDS)
            .build(new CacheLoader<String, List<String>>() {
                @Override
                public List<String> load(final String id) {
                    //todo
                    RestTemplate restTemplate = new RestTemplate();
                    Map<String, String> uriVariables = ImmutableMap.of("projectid", EngagementCollector.this.projectid, "customerid", id);
                    ResponseEntity<String[]> forEntity = restTemplate.getForEntity("https://api-demoapp.exponea.com/data/v2/projects/{projectid}/customers/{customerid}/exposed-segmentations", String[].class, uriVariables);
                    return Arrays.asList(forEntity.getBody());
                }
            });

    @Override
    public EngagementRequestData getTargetingRequestData(final HttpServletRequest request,
                                                         final boolean newVisitor,
                                                         final boolean newVisit,
                                                         final EngagementData targetingData) {
//        if (!newVisit) {
//            if (targetingData != null) {
//                return new EngagementRequestData(targetingData.getSegments());
//            }
//            log.warn("Unexpected empty ...");
//        }
        if (request.getCookies() != null) {
            Optional<Cookie> engagementId = Arrays.stream(request.getCookies())
                    .filter(cookie -> cookie.getName().equals("__exponea_etc__"))
                    .findFirst();
            if (enabled && engagementId.isPresent()) {
                return new EngagementRequestData(cache.getUnchecked(engagementId.get().getValue()));
            }
        }
        return new EngagementRequestData(new ArrayList<>());
    }

    @Override
    public EngagementData updateTargetingData(EngagementData data, final EngagementRequestData segments) throws IllegalArgumentException {
        if (data == null) {
            data = new EngagementData(getId(), segments.getSegments());
        } else {
            data.setSegments(segments.getSegments());
        }
        return data;
    }

    public static class EngagementRequestData {

        List<String> segments;

        public List<String> getSegments() {
            return segments;
        }

        public EngagementRequestData(List<String> segments) {
            this.segments = segments;
        }

        public EngagementRequestData() {
        }

        public void setSegments(List<String> segments) {
            this.segments = segments;
        }

        public boolean add(String s) {
            if (segments == null) {
                segments = new ArrayList<>();
            }
            return segments.add(s);
        }
    }


}
