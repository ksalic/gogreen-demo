/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.onehippo.cms7.targeting.TargetingJcrConstants;
import com.onehippo.cms7.targeting.data.RequestLogEntry;
import com.onehippo.cms7.targeting.data.Visit;
import com.onehippo.cms7.targeting.data.VisitorData;
import com.onehippo.cms7.targeting.json.TargetingObjectMapper;
import com.onehippo.cms7.targeting.storage.elastic.ElasticRequestLogStore;
import com.onehippo.cms7.targeting.storage.elastic.ElasticStoreConstants;
import com.onehippo.cms7.targeting.storage.elastic.ElasticStoreFactory;
import com.onehippo.cms7.targeting.storage.elastic.ElasticVisitStore;
import com.onehippo.cms7.targeting.storage.elastic.ElasticVisitorStore;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.compress.compressors.bzip2.BZip2CompressorInputStream;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.hippoecm.hst.configuration.HstNodeTypes;
import org.hippoecm.repository.HippoRepository;
import org.hippoecm.repository.HippoRepositoryFactory;
import org.hippoecm.repository.util.NodeIterable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.searchbox.action.GenericResultAbstractAction;
import io.searchbox.client.JestClient;
import io.searchbox.client.JestClientFactory;
import io.searchbox.client.JestResult;
import io.searchbox.client.config.HttpClientConfig;
import static org.hippoecm.hst.configuration.HstNodeTypes.COMPONENT_PROPERTY_REFERECENCECOMPONENT;
import static org.hippoecm.hst.configuration.HstNodeTypes.GENERAL_PROPERTY_LOCKED_BY;
import static org.hippoecm.hst.configuration.HstNodeTypes.GENERAL_PROPERTY_LOCKED_ON;
import static org.hippoecm.hst.configuration.HstNodeTypes.MOUNT_PROPERTY_MOUNTPOINT;
import static org.hippoecm.hst.configuration.HstNodeTypes.NODENAME_HST_CHANNELS;
import static org.hippoecm.hst.configuration.HstNodeTypes.NODENAME_HST_CONFIGURATIONS;
import static org.hippoecm.hst.configuration.HstNodeTypes.NODENAME_HST_CONTAINERS;
import static org.hippoecm.hst.configuration.HstNodeTypes.NODENAME_HST_WORKSPACE;
import static org.hippoecm.repository.util.JcrUtils.copy;
import static org.hippoecm.repository.util.JcrUtils.getStringProperty;

public class DataLoader {

    public static final String REQUESTS = "requests";
    public static final String VISITS = "visits";
    public static final String TARGETING_DATA = "targeting-data";

    public static final Logger log = LoggerFactory.getLogger(DataLoader.class);

    @SuppressWarnings("static-access")
    public static void main(String[] args) throws ParseException, IOException {
        Options options = new Options()
                .addOption(OptionBuilder
                        .isRequired(false)
                        .withArgName("help")
                        .withDescription("show help")
                        .create("h"))
                .addOption(OptionBuilder
                        .isRequired(false)
                        .withArgName("mount")
                        .hasArg()
                        .withDescription("The mount UUID or JCR path - defaults to /hst:hst/hst:hosts/dev-localhost/localhost/hst:root")
                        .create("m"))
                .addOption(OptionBuilder
                        .isRequired(false)
                        .withArgName("elastic")
                        .hasArg()
                        .withDescription("Elasticsearch location - defaults to http://localhost:9200")
                        .create("e"))
                .addOption(OptionBuilder
                        .isRequired(false)
                        .withArgName("relevance")
                        .hasArg()
                        .withDescription("Relevance flow endpoint - defaults to http://localhost:8080/relevance/api/flow")
                        .create("r"))
                .addOption(OptionBuilder
                        .isRequired(false)
                        .withValueSeparator(',')
                        .withArgName("indices")
                        .hasArg()
                        .create("i"));

        CommandLine cli = new GnuParser().parse(options, args);
        if (cli.hasOption('h')) {
            System.out.println(getHelp(options));
            System.exit(0);
        }

        DataLoader loader = new DataLoader();
        if (cli.hasOption("m")) {
            loader.setMount(cli.getOptionValue("m"));
        }
        if (cli.hasOption("e")) {
            loader.setEsLocation(cli.getOptionValue("e"));
        }
        if (cli.hasOption("r")) {
            loader.setRelevance(cli.getOptionValue("r"));
        }

        Set<String> indices = new TreeSet<>();
        if (cli.hasOption("i")) {
            Collections.addAll(indices, cli.getOptionValues("i"));
        } else {
            indices.add(REQUESTS);
            indices.add(VISITS);
            indices.add(TARGETING_DATA);
        }
        loader.loadData(indices);
    }

    private static String getHelp(Options options) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PrintWriter pw = new PrintWriter(baos);
        new HelpFormatter().printHelp(pw, 80, "data-loader", null, options, 1, 3, null, true);
        pw.flush();
        return new String(baos.toByteArray());
    }

    private final Interval interval;
    private final long delta;
    private String relevance;
    private String esLocation;
    private String mount;

    public DataLoader() throws IOException {
        this.esLocation = "http://localhost:9200";
        this.relevance = "http://localhost:8080/relevance/api/flow/";
        this.interval = loadInterval();
        this.delta = System.currentTimeMillis() - interval.getEnd();
    }

    public void setEsLocation(String esLocation) {
        this.esLocation = esLocation;
    }

    public void setMount(String mount) {
        this.mount = mount;
    }

    public void setRelevance(String relevance) {
        this.relevance = relevance;
    }

    public long getDelta() {
        return delta;
    }

    public long getStartTime() {
        return interval.getStart() + delta;
    }

    private Interval loadInterval() throws IOException {
        long startTime = -1;
        long endTime = -1;
        try (RequestLogReader reader = getRequestLogReader()) {
            for (RequestLogEntry entry : reader) {
                long time = entry.getTimestamp().getTime();
                if (startTime == -1) {
                    startTime = endTime = time;
                } else if (startTime > time) {
                    startTime = time;
                } else if (endTime < time) {
                    endTime = time;
                }
            }
        }
        return new Interval(startTime, endTime);
    }

    public void loadData(Set<String> indices) throws IOException {
        try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            Gson gson = new Gson();
            DataFlowStatus dataFlowStatus;
            try (CloseableHttpResponse response = httpClient.execute(new HttpGet(this.relevance))) {
                HttpEntity status = response.getEntity();
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                status.writeTo(baos);
                dataFlowStatus = gson.fromJson(baos.toString("utf-8"), DataFlowStatus.class);
            }
            httpClient.execute(new HttpDelete(this.relevance)).close();

            String mountId = getMount();
            if (mountId != null) {
                updateExperiments(mountId);
            }

            if (indices.contains(REQUESTS)) {
                log.info("Populating '{}'", REQUESTS);
                clearIndex(REQUESTS, ElasticStoreConstants.REQUESTLOG_ENTRY_TYPE);

                Map<String, Object> properties = new HashMap<>();
                properties.put("locations", Arrays.asList(esLocation));
                properties.put("indexName", REQUESTS);
                ElasticStoreFactory factory = new ElasticStoreFactory();
                factory.initialize(properties);

                int count = populateRequests(factory, delta, mountId);
                dataFlowStatus.setTime(0);
                log.info("populated '{}' with {} requests", REQUESTS, count);
            }
            if (indices.contains(VISITS)) {
                log.info("Populating '{}'", VISITS);
                clearIndex(VISITS, ElasticStoreConstants.VISIT_TYPE);
                int count = populateVisits(delta, mountId);
                log.info("Populated '{}' with {} visits", VISITS, count);
            }
            if (indices.contains(TARGETING_DATA)) {
                log.info("Populating '{}'", TARGETING_DATA);
                clearIndex(TARGETING_DATA, ElasticStoreConstants.VISITOR_DATA_TYPE);

                Map<String, Object> properties = new HashMap<>();
                properties.put("locations", Arrays.asList(esLocation));
                properties.put("indexName", TARGETING_DATA);
                ElasticStoreFactory factory = new ElasticStoreFactory();
                factory.initialize(properties);
                int count = populateTargetingData(factory, delta);
                log.info("Populated '{}' with {} visitors", TARGETING_DATA, count);
            }
            log.info("All indices have been initialized.");

            HttpEntity newStatus = new StringEntity(gson.toJson(dataFlowStatus), ContentType.APPLICATION_JSON);
            HttpPut request = new HttpPut(this.relevance);
            request.setEntity(newStatus);
            httpClient.execute(request).close();
        } catch (Exception tsce) {
            throw new IOException(tsce);
        }
    }

    private String getMount() throws IOException {
        if (mount != null) {
            try {
                UUID.fromString(this.mount);
                return mount;
            } catch (IllegalArgumentException iae) {
                // ignore - interpret mount argument as path
            }
        }
        Session session = null;
        try {
            session = getSession();
            String path = "/hst:hst/hst:hosts/dev-localhost/localhost/hst:root";
            if (mount != null) {
                path = mount;
            }
            return session.getNode(path).getIdentifier();
        } catch (RepositoryException re) {
            throw new IOException(re);
        } finally {
            if (session != null) {
                session.logout();
            }
        }
    }

    private Session getSession() throws RepositoryException {
        HippoRepository repository = HippoRepositoryFactory.getHippoRepository("rmi://127.0.0.1:1099/hipporepository");
        return repository.login("admin", "admin".toCharArray());
    }

    private void updateExperiments(String mountId) throws IOException {
        Session session = null;
        try {
            session = getSession();
            final Node previewNode = getPreviewConfigNode(mountId, session);

            NodeIterator nodes = session.getNode("/targeting:targeting/targeting:experiments").getNodes();
            final ObjectMapper mapper = new ObjectMapper();
            while (nodes.hasNext()) {
                Node experimentRoot = nodes.nextNode();
                if ("targeting:events".equals(experimentRoot.getName())) {
                    continue;
                }
                session.move(experimentRoot.getPath(), experimentRoot.getParent().getPath() + "/" + mountId);
                for (Node conversionNode : new NodeIterable(experimentRoot.getNode("targeting:conversions").getNodes())) {
                    Calendar instance = Calendar.getInstance();
                    instance.setTimeInMillis(getStartTime());
                    conversionNode.setProperty("startTime", instance);
                    final String variants = getStringProperty(conversionNode, "variants", "");
                    final Iterator<String> fieldNames = mapper.readTree(variants).fieldNames();
                    while (fieldNames.hasNext()) {
                        final String containerItemPath = fieldNames.next();
                        final String pagePath = containerItemPath.substring(0, containerItemPath.lastIndexOf('/'));
                        final Node pageNode = session.getNode(previewNode.getPath() + "/" + pagePath);
                        final String referenceComponent = getStringProperty(pageNode, COMPONENT_PROPERTY_REFERECENCECOMPONENT, "");
                        final String containerPath = previewNode.getPath() + "/" + NODENAME_HST_WORKSPACE + "/" + NODENAME_HST_CONTAINERS + "/"  + referenceComponent;
                        final Node containerNode = session.getNode(containerPath);
                        containerNode.setProperty(GENERAL_PROPERTY_LOCKED_BY, TargetingJcrConstants.RELEVANCE_USER);
                        containerNode.setProperty(GENERAL_PROPERTY_LOCKED_ON, instance);
                    }
                }
                break;
            }
            session.save();
        } catch (RepositoryException re) {
            System.err.println(re.getMessage());
        } finally {
            if (session != null) {
                session.logout();
            }
        }
    }

    private Node getPreviewConfigNode(String mountId, Session session) throws RepositoryException {
        final String mountpoint = getStringProperty(session.getNodeByIdentifier(mountId), MOUNT_PROPERTY_MOUNTPOINT, "");
        final String mountName = mountpoint.substring(mountpoint.lastIndexOf('/') + 1);
        final String liveChannel = "/hst:hst/" + NODENAME_HST_CHANNELS + "/" + mountName;
        final String previewChannel = liveChannel + "-preview";
        if (!session.nodeExists(previewChannel)) {
            copy(session, liveChannel, previewChannel);
        }
        final String liveConfig = "/hst:hst/" + NODENAME_HST_CONFIGURATIONS + "/" + mountName;
        final String previewConfig = liveConfig + "-preview";
        if (session.nodeExists(previewConfig)) {
            return session.getNode(previewConfig);
        } else {
            return copy(session, liveConfig, previewConfig);
        }
    }

    private void clearIndex(String index, String type) throws Exception {
        JestClientFactory factory = new JestClientFactory();
        factory.setHttpClientConfig(new HttpClientConfig
                .Builder(esLocation)
                .discoveryEnabled(false)
                .build());
        JestClient client = factory.getObject();
        try {
            log.debug("Clearing Elasticsearch index '{}' type '{}'", index, type);
            JestResult result = client.execute(new DeleteMapping
                    .Builder(index, type)
                    .build());
            if (!result.isSucceeded()) {
                final int status = result.getJsonObject().getAsJsonPrimitive("status").getAsInt();
                if (status == HttpStatus.SC_NOT_FOUND /* 404 */) {
                    log.debug("Unnecessary, the mapping didn't exist yet");
                } else {
                    log.error("Unable to clear index '{}': {} ", index, result.getErrorMessage());
                }
            }
        } finally {
            client.shutdownClient();
        }
    }

    private int populateRequests(ElasticStoreFactory factory, long delta, String mountId) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        int count = 0;

        ElasticRequestLogStore store = null;
        try {
            store = (ElasticRequestLogStore) factory.createRequestLogStore(mapper);
            try (RequestLogReader reader = getRequestLogReader()) {
                for (RequestLogEntry entry : reader) {
                    RequestLogEntry newEntry = travelInTime(entry, delta, mountId);
                    store.storeLogEntry(newEntry);
                    count++;
                }
            }

            store.sync();
        } catch (Exception e) {
            throw new IOException(e);
        } finally {
            if (store != null) {
                store.destroy();
            }
        }
        return count;
    }

    private RequestLogEntry travelInTime(RequestLogEntry entry, long delta, String mountId) {
        long time = entry.getTimestamp().getTime();
        RequestLogEntry newEntry = new RequestLogEntry(
                entry.getVisitorId(),
                entry.getSessionId(),
                entry.isNewVisit(),
                mountId != null ? mountId : entry.getMountId(),
                entry.getPageId(),
                entry.getPageUrl(),
                entry.getPathInfo(),
                entry.getRemoteAddress(),
                entry.getReferer(),
                entry.getUserAgent(),
                new Date(time + delta),
                entry.getCollectorData(),
                entry.getData()
        );
        newEntry.setGlobalPersonaIdScores(entry.getGlobalPersonaIdScores());
        newEntry.setPersonaIdScores(entry.getPersonaIdScores());
        newEntry.setSelectedVariants(entry.getSelectedVariants());
        return newEntry;
    }

    private int populateVisits(long delta, String mountId) throws IOException {
        JestClientFactory factory = new JestClientFactory();
        factory.setHttpClientConfig(new HttpClientConfig.Builder(esLocation)
                .discoveryEnabled(false)
                .build());
        JestClient jestClient = factory.getObject();
        int count = 0;

        ElasticVisitStore store = new ElasticVisitStore(new ObjectMapper(), jestClient, Collections.emptyMap(), VISITS);
        try {
            ObjectMapper mapper = new ObjectMapper();
            InputStream stream = DataLoader.class.getResourceAsStream("/visit-data.bz2");
            if (stream == null) {
                stream = new ByteArrayInputStream(new byte[0]);
            }
            BZip2CompressorInputStream decompressedStream = new BZip2CompressorInputStream(stream);
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(decompressedStream))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.indexOf(':') < 0) {
                        continue;
                    }
                    String data = line.substring(line.indexOf(':') + 1);
                    Visit visitorData = mapper.readValue(data, Visit.class);
                    Visit newVisitorData = new Visit(
                            visitorData.getVisitorId(),
                            visitorData.getVisitId(),
                            travelInTime(visitorData.getEntry(), delta, mountId),
                            travelInTime(visitorData.getEntry(), delta, mountId),
                            visitorData.getRequests()
                                    .stream()
                                    .map((RequestLogEntry entry) -> travelInTime(entry, delta, mountId))
                                    .collect(Collectors.toList()));
                    store.storeVisit(newVisitorData);
                    count++;
                }
            }
            store.sync();
        } catch (Exception e) {
            throw new IOException(e);
        } finally {
            store.destroy();
        }

        return count;
    }

    private int populateTargetingData(ElasticStoreFactory factory, long delta) throws IOException {
        ObjectMapper mapper = new TargetingObjectMapper();
        int count = 0;

        ElasticVisitorStore store = null;
        try {
            store = (ElasticVisitorStore) factory.createVisitorStore(mapper);
            InputStream stream = DataLoader.class.getResourceAsStream("/targeting-data.bz2");
            if (stream == null) {
                stream = new ByteArrayInputStream(new byte[0]);
            }
            BZip2CompressorInputStream decompressedStream = new BZip2CompressorInputStream(stream);
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(decompressedStream))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.indexOf(':') < 0) {
                        continue;
                    }
                    String visitorId = line.substring(0, line.indexOf(':'));
                    String data = line.substring(line.indexOf(':') + 1);
                    VisitorData visitorData = mapper.readValue(data, VisitorData.class);
                    long time = visitorData.getLastAccessTime();
                    visitorData.setLastAccessTime(time + delta);
                    store.storeVisitorData(visitorId, visitorData);
                    count++;
                }
            }
            store.sync();
        } catch (Exception e) {
            throw new IOException(e);
        } finally {
            if (store != null) {
                store.destroy();
            }
        }

        return count;
    }

    private RequestLogReader getRequestLogReader() throws IOException {
        InputStream stream = DataLoader.class.getResourceAsStream("/request-data.bz2");
        if (stream == null) {
            stream = new ByteArrayInputStream(new byte[0]);
        }
        return new RequestLogReader(new BZip2CompressorInputStream(stream));
    }

    static class Interval {
        final long start;
        final long end;

        Interval(long start, long end) {
            this.start = start;
            this.end = end;
        }

        public long getStart() {
            return start;
        }

        public long getEnd() {
            return end;
        }
    }

    static class DeleteMapping extends GenericResultAbstractAction {

        DeleteMapping(Builder builder) {
            super(builder);

            this.indexName = builder.index;
            this.typeName = builder.type;
            setURI(buildURI());
        }

        @Override
        protected String buildURI() {
            return super.buildURI() + "/_mapping";
        }

        @Override
        public String getRestMethodName() {
            return "DELETE";
        }

        static class Builder extends GenericResultAbstractAction.Builder<DeleteMapping, Builder> {
            private String index;
            private String type;

            public Builder(String index, String type) {
                this.index = index;
                this.type = type;
            }

            @Override
            public DeleteMapping build() {
                return new DeleteMapping(this);
            }
        }
    }

}
