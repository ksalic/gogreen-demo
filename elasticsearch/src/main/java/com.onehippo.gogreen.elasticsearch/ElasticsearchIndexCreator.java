/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;

import org.elasticsearch.action.admin.indices.create.CreateIndexRequest;
import org.elasticsearch.action.admin.indices.create.CreateIndexResponse;
import org.elasticsearch.action.admin.indices.mapping.get.GetMappingsRequestBuilder;
import org.elasticsearch.action.admin.indices.refresh.RefreshRequest;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.IndicesAdminClient;
import org.elasticsearch.indices.IndexMissingException;
import org.elasticsearch.node.Node;
import org.elasticsearch.wares.NodeServlet;
import org.onehippo.cms7.services.HippoServiceRegistry;
import org.onehippo.repository.RepositoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ElasticsearchIndexCreator implements ServletContextAttributeListener {

    static final Logger log = LoggerFactory.getLogger(ElasticsearchIndexCreator.class);

    @Override
    public void attributeAdded(ServletContextAttributeEvent event) {
        if (NodeServlet.NODE_KEY.equals(event.getName())) {
            if (event.getValue() == null) {
                log.warn("No elasticsearch Node found under attribute '" + NodeServlet.NODE_KEY + "'");
            } else {
                init((Node) event.getValue());
            }
        }
    }

    private void init(Node node) {
        final Set<String> created = new HashSet<>();
        try (Client client = node.client()) {
            IndicesAdminClient indices = client.admin().indices();
            for (String indexName : new String[]{"targeting-data", "requests", "visits"}) {

                // It turns out that indices.exists(...) is unreliable.
                // Instead, we ask for the mapping and look out for an exception.
                try {
                    final GetMappingsRequestBuilder getMappingsRequestBuilder = indices.prepareGetMappings(indexName);
                    getMappingsRequestBuilder.execute().actionGet();
                    log.debug("Index '{}' already exists", indexName);
                    continue;
                } catch (IndexMissingException e) {
                    // fine, we'll create it below
                }

                log.debug("Trying to create index '{}'", indexName);
                try {
                    CreateIndexResponse response = indices.create(new CreateIndexRequest(indexName)).actionGet();
                    if (response.isAcknowledged()) {
                        log.info("Created Elasticsearch index '{}'", indexName);
                        created.add(indexName);
                    }
                } catch (Exception e) {
                 log.warn("Unable to create Elasticsearch index '{}'", indexName, e);
                }
            }
            indices.refresh(new RefreshRequest()).actionGet();
        } catch (Exception e) {
            log.warn("Error while initializing Elasticsearch indices", e);
        }

        if (created.size() == 0) {
            log.debug("No need to bootstrap any indices");
            return;
        }
        String skipBootstrap = System.getProperty("es.bootstrap");
        if ("false".equalsIgnoreCase(skipBootstrap)) {
            log.info("Bootstrapping suppressed");
            return;
        }

        new Thread() {

            @Override
            public void run() {
                try {
                    RepositoryService service = null;
                    while (service == null) {
                        Thread.sleep(1000);
                        service = HippoServiceRegistry.getService(RepositoryService.class);
                    }

                    DataLoader loader = new DataLoader();
                    loader.setEsLocation("http://localhost:8080/elasticsearch");
                    loader.loadData(created);
                } catch (InterruptedException | IOException e) {
                    throw new RuntimeException(e);
                }

            }
        }.start();

    }

    @Override
    public void attributeRemoved(ServletContextAttributeEvent event) {
    }

    @Override
    public void attributeReplaced(ServletContextAttributeEvent event) {
    }

}
