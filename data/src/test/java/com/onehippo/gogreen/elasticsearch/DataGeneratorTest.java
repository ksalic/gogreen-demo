/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import com.google.gson.*;
import com.onehippo.cms7.targeting.experiments.repository.JcrExperiment;
import com.onehippo.cms7.targeting.experiments.repository.JcrExperimentsRepository;
import com.onehippo.cms7.targeting.experiments.repository.JcrPageExperiments;
import com.onehippo.cms7.targeting.geo.GeoIPService;
import com.onehippo.cms7.targeting.geo.GeoIPServiceImpl;
import com.onehippo.cms7.targeting.geo.Location;
import io.searchbox.client.JestClient;
import io.searchbox.client.JestClientFactory;
import io.searchbox.client.JestResult;
import io.searchbox.client.config.HttpClientConfig;
import io.searchbox.core.DeleteByQuery;
import io.searchbox.core.Search;
import io.searchbox.core.SearchResult;
import io.searchbox.core.SearchScroll;
import io.searchbox.indices.Refresh;
import io.searchbox.params.SearchType;
import org.apache.commons.compress.compressors.bzip2.BZip2CompressorOutputStream;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.math3.linear.Array2DRowRealMatrix;
import org.apache.commons.math3.linear.ArrayRealVector;
import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.RealVector;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.StatusLine;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.*;
import org.apache.http.cookie.Cookie;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.hippoecm.repository.HippoRepository;
import org.hippoecm.repository.HippoRepositoryFactory;
import org.junit.Ignore;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import javax.jcr.Session;
import java.io.*;
import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class DataGeneratorTest {

    private static Logger log = LoggerFactory.getLogger(DataGeneratorTest.class);

    // timeout = 3: simulate 10 minutes in 1 second
    //              a month can thus be simulated in 75 minutes
    // timeout = 1: simulate 30 minutes in 1 second
    //              a month can thus be simulated in 25 minutes
    public static final int SESSION_TIMEOUT = 3;
    public static final int D_HOUR_IN_MILLIS = 2 * SESSION_TIMEOUT * 1000;
    public static final int DILATION = 1800 / SESSION_TIMEOUT;
    public static final int RATE_TO_COUNT = 1200;
    public static final int WEEKS = 4;

    GeoIPService geoIPService = new GeoIPServiceImpl();
    List<String> randomIps = new ArrayList<>(10_000);
    Gson gson = new Gson();

    {
        Random rand = new Random();
        for (int n = 0; n < 10_000; n++) {
            randomIps.add(getRandomIPAdress(rand));
        }
    }

    @Test
    @Ignore
    public void visitSite() throws Exception {
        DataFlowStatus oldStatus = emptyIndicesAndStopSpark();

        generateRequests();

        long currentTime = completeProcessing();

        dumpIndices(currentTime);

        restoreSpark(oldStatus);
    }

    private DataFlowStatus emptyIndicesAndStopSpark() throws Exception {
        DataFlowStatus oldStatus;
        try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            try (CloseableHttpResponse response = httpClient.execute(new HttpGet("http://localhost:8080/relevance/api/flow"))) {
                ByteArrayOutputStream outstream = new ByteArrayOutputStream();
                response.getEntity().writeTo(outstream);
                oldStatus = gson.fromJson(outstream.toString("utf-8"), DataFlowStatus.class);
            }

            httpClient.execute(new HttpDelete("http://localhost:8080/relevance/api/flow")).close();

            System.out.println("Waiting for spark shutdown");
            Thread.sleep(10000);

            System.out.println("Configuring repository");
            Session session = null;
            try {
                session = getSession();

                updateExperiments(session);
                disableWeather(session);
                enablePageCache(session);

                session.save();
            } catch (RepositoryException re) {
                System.err.println(re.getMessage());
            } finally {
                if (session != null) {
                    session.logout();
                }
            }

            System.out.println("Clearing indices");
            try (JestWrapper wrapper = new JestWrapper()) {
                wrapper.getClient().execute(new DeleteByQuery
                    .Builder("{ \"query\": { \"match_all\": {} } }")
                    .addIndex("requests")
                    .addIndex("visits")
                    .addIndex("targeting-data")
                    .build());
            }

            DataFlowStatus newStatus = new DataFlowStatus();
            newStatus.setInterval(SESSION_TIMEOUT);
            newStatus.setSessionTimeout(SESSION_TIMEOUT);
            newStatus.setRunning(true);
            newStatus.setTime(0);

            HttpEntity entity = new StringEntity(gson.toJson(newStatus), ContentType.APPLICATION_JSON);
            HttpPut request = new HttpPut("http://localhost:8080/relevance/api/flow/");
            request.setEntity(entity);
            httpClient.execute(request).close();
        }
        return oldStatus;
    }

    private void updateExperiments(Session session) throws RepositoryException {
        JcrExperimentsRepository jer = new JcrExperimentsRepository(session.getNode("/targeting:targeting/targeting:experiments"));
        for (JcrPageExperiments experiments : jer.getAllPageExperiments().values()) {
            for (JcrExperiment experiment : experiments) {
                experiment.setStartTime(System.currentTimeMillis());
                RealVector mu = experiment.getMu();
                mu = new ArrayRealVector(mu.getDimension());
                experiment.setMu(mu);

                RealMatrix sigma = experiment.getSigma();
                sigma = new Array2DRowRealMatrix(sigma.getRowDimension(), sigma.getColumnDimension());
                for (int i = 0; i < sigma.getRowDimension(); i++) {
                    sigma.setEntry(i, i, 0.5);
                }
                experiment.setSigma(sigma);
                experiment.setLastUpdateTime(-1);
            }
        }
    }

    private void disableWeather(Session session) throws RepositoryException {
        session.getNode("/targeting:targeting/targeting:collectors/weather").setProperty("enabled", false);
    }

    private void enablePageCache(Session session) throws RepositoryException {
        session.getNode("/hst:hst/hst:hosts").setProperty("hst:cacheable", true);
        session.save();
    }

    private Session getSession() throws RepositoryException {
        HippoRepository repository = HippoRepositoryFactory.getHippoRepository("rmi://127.0.0.1:1099/hipporepository");
        return repository.login("admin", "admin".toCharArray());
    }

    private void generateRequests() throws IOException, InterruptedException {
        InputStream profileStream = DataGeneratorTest.class.getResourceAsStream("/visitor-profiles.json");
        InputStreamReader profileReader = new InputStreamReader(profileStream);
        JsonParser parser = new JsonParser();

        ScheduledExecutorService executorService = Executors.newScheduledThreadPool(128);
        JsonObject profilesJson = parser.parse(profileReader).getAsJsonObject();
        try (CloseableHttpClient client = HttpClientBuilder.create()
            .setUserAgent("Gecko")
            .setDefaultCookieStore(new MultiThreadedCookieStore())
            .setMaxConnPerRoute(20)
            .build()) {

            System.out.println("Generating visits");
            Semaphore semaphore = new Semaphore(0);
            int numVisits = 0;
            List<Profile> profiles = profilesJson.entrySet().stream()
                .map(e -> gson.fromJson(e.getValue(), Profile.class))
                .collect(Collectors.toList());
            for (int m = 0; m < RATE_TO_COUNT; m++) {
                for (Profile profile : profiles) {
                    for (int i = 0; i < profile.getRate(); i++) {
                        Visit visit = new Visit(client, profile);
                        visit.schedule(executorService, semaphore);
                        numVisits++;
                    }
                }
            }

            System.out.println("Waiting for visits to complete");
            int timeUnits = 0;
            int timeStep = 1;
            final TimeUnit stepUnit = TimeUnit.MINUTES;
            do {
                System.out.println("Completed " + semaphore.availablePermits() + "/" + numVisits
                        + " visits in " + timeUnits + " " + stepUnit.name());
                timeUnits += timeStep;
            } while (!semaphore.tryAcquire(numVisits, timeStep, stepUnit));
        }
        executorService.shutdown();
    }

    private long completeProcessing() throws Exception {
        try (JestWrapper wrapper = new JestWrapper()) {
            wrapper.getClient().execute(new Refresh
                .Builder()
                .addIndex("requests")
                .addIndex("visits")
                .addIndex("targeting-data")
                .build());
        }

        long currentTime = System.currentTimeMillis();

        // give elasticsearch and spark some time to index and process
        Thread.sleep(TimeUnit.MINUTES.toMillis(2));
        return currentTime;
    }

    private void restoreSpark(DataFlowStatus oldStatus) throws IOException {
        try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            httpClient.execute(new HttpDelete("http://localhost:8080/relevance/api/flow")).close();

            HttpEntity entity = new StringEntity(gson.toJson(oldStatus), ContentType.APPLICATION_JSON);
            HttpPut request = new HttpPut("http://localhost:8080/relevance/api/flow/");
            request.setEntity(entity);
            httpClient.execute(request).close();
        }
    }

    private void dumpIndices(long currentTime) throws Exception {
        dumpIndex("requests", "request-data.bz2", jsonHit -> {
            JsonObject source = jsonHit.getAsJsonObject("_source");
            rescaleTimeForRequest(source, currentTime);
            return source.getAsJsonPrimitive("visitorId").getAsString() + ":" + source.toString();
        });
        dumpIndex("visits", "visit-data.bz2", jsonHit -> {
            JsonObject source = jsonHit.getAsJsonObject("_source");
            for (String special : new String[]{"entry", "exit"}) {
                rescaleTimeForRequest(source.getAsJsonObject(special), currentTime);
            }
            for (JsonElement request : source.getAsJsonArray("requests")) {
                rescaleTimeForRequest(request.getAsJsonObject(), currentTime);
            }
            return source.getAsJsonPrimitive("visitorId").getAsString() + ":" + source.toString();
        });
        dumpIndex("targeting-data", "targeting-data.bz2", jsonHit -> {
            JsonObject source = jsonHit.getAsJsonObject("_source");
            long time = source.getAsJsonPrimitive("lastAccessTime").getAsLong();
            long newTime = (time - currentTime) * DILATION + currentTime;
            source.add("lastAccessTime", new JsonPrimitive(newTime));
            return jsonHit.getAsJsonPrimitive("_id").getAsString() + ":" + source.toString();
        });
    }

    private void rescaleTimeForRequest(JsonObject source, long currentTime) {
        long time = source.getAsJsonPrimitive("timestamp").getAsLong();
        long newTime = (time - currentTime) * DILATION + currentTime;
        source.add("timestamp", new JsonPrimitive(newTime));
    }

    private void dumpIndex(String indexName, String outputFile, Function<JsonObject, String> converter) throws Exception {
        OutputStream out = new BZip2CompressorOutputStream(new FileOutputStream(new File(outputFile)), 9);
        try (JestWrapper wrapper = new JestWrapper(); Writer writer = new OutputStreamWriter(out)) {
            SearchResult scrollResp = wrapper.getClient().execute(new Search
                .Builder("{ \"query\": { \"match_all\": {} } }")
                .setSearchType(SearchType.SCAN)
                .addIndex(indexName)
                .setParameter("size", 100)
                .setParameter("scroll", "15m")
                .build());
            if (!scrollResp.isSucceeded()) {
                throw new RuntimeException("Unable to obtain scroll ID: " + scrollResp.getErrorMessage());
            }

            String scrollId = scrollResp.getJsonObject().get("_scroll_id").getAsString();
            while (true) {
                // Use (global) scroll API, it's not available under the index API
                JestResult result = wrapper.getClient().execute(new SearchScroll.Builder(scrollId, "15m").build());
                if (!result.isSucceeded()) {
                    throw new RuntimeException("Unable to obtain scroll results: " + result.getErrorMessage());
                }

                scrollId = result.getJsonObject().get("_scroll_id").getAsString();
                JsonArray hits = result.getJsonObject().getAsJsonObject("hits").getAsJsonArray("hits");
                if (hits.size() == 0) {
                    break;
                }

                for (JsonElement object : hits) {
                    JsonObject hit = object.getAsJsonObject();
                    String output = converter.apply(hit);
                    if (output != null) {
                        writer.write(output);
                        writer.write('\n');
                    }
                }
            }
        }
    }

    private Pattern createFormPattern(String name) {
        return Pattern.compile(".*<form\\s.*action=\"([^\"]*)\"\\s.*name=\"" + name + "\".*");
    }

    static class JestWrapper implements Closeable {
        private final JestClient client;

        JestWrapper() {
            final HttpClientConfig httpClientConfig = new HttpClientConfig
                .Builder("http://localhost:8080/elasticsearch")
                .multiThreaded(true)
                .discoveryEnabled(false)
                .defaultMaxTotalConnectionPerRoute(20)
                .maxTotalConnection(20)
                .readTimeout(10000)
                .build();

            final JestClientFactory factory = new JestClientFactory();
            factory.setHttpClientConfig(httpClientConfig);
            client = factory.getObject();
        }

        JestClient getClient() {
            return client;
        }

        @Override
        public void close() throws IOException {
            client.shutdownClient();
        }
    }

    static ThreadLocal<CookieStore> THE_STORE = new ThreadLocal<>();

    static class MultiThreadedCookieStore implements CookieStore {

        private CookieStore getCookieStore() {
            return THE_STORE.get();
        }

        @Override
        public void addCookie(Cookie cookie) {
            getCookieStore().addCookie(cookie);
        }

        @Override
        public List<Cookie> getCookies() {
            return getCookieStore().getCookies();
        }

        @Override
        public boolean clearExpired(Date date) {
            return getCookieStore().clearExpired(date);
        }

        @Override
        public void clear() {
            getCookieStore().clear();
        }
    }

    class Visit {

        private final CloseableHttpClient client;
        private final Profile profile;

        private final Random rand = new Random();
        private final CookieStore cookieStore = new BasicCookieStore();
        private final Header[] headers;
        private final Map<String, Conversion> conversions;
        private volatile String pendingConversion;
        private Map<String, HttpEntity> forms = Collections.synchronizedMap(new HashMap<>());
        private final long startTime = System.currentTimeMillis();

        Visit(CloseableHttpClient client, Profile profile) {
            this.client = client;
            this.profile = profile;

            headers = new Header[1];
            List<String> ips = profile.getIps();
            if (ips.size() == 0) {
                ips = randomIps;
            }
            String ipAddress = ips.get(rand.nextInt(ips.size()));
            headers[0] = new BasicHeader("X-Forwarded-For", ipAddress);

            conversions = Optional.ofNullable(profile.getConversions())
                .map(l -> l.stream().collect(Collectors.toMap(Conversion::getFrom, c -> c)))
                .orElse(Collections.emptyMap());
        }

        private int sample(List<Integer> weekly) {
            int sum = weekly.stream().reduce(0, (s, v) -> s + v);
            int dayOfWeek = rand.nextInt(sum);
            int day = 0;
            for (int numOnDay : weekly) {
                if (dayOfWeek >= numOnDay) {
                    dayOfWeek -= numOnDay;
                } else {
                    break;
                }
                day++;
            }
            return day;
        }

        Request getFirstRequest() {
            int weekOfMonth = rand.nextInt(WEEKS);
            int dayOfWeek = sample(profile.getFrequency().getWeekly());
            int timeOfDay = sample(profile.getFrequency().getDaily());
            int hourSinceNow = ((7 * weekOfMonth + dayOfWeek) * 4 + timeOfDay) * 6;
            long timestamp = hourSinceNow * D_HOUR_IN_MILLIS + rand.nextInt(6 * D_HOUR_IN_MILLIS);

            return new Request(timestamp);
        }

        Request getNextRequest() {
            if (rand.nextInt(5) > 0) {
                return new Request(rand.nextInt(D_HOUR_IN_MILLIS / 12));
            } else {
                return null;
            }
        }

        void run(Request request) {
            try {
                THE_STORE.set(cookieStore);
                request.execute();
            } finally {
                THE_STORE.remove();
            }
        }

        synchronized String samplePage() {
            String conversion = this.pendingConversion;
            this.pendingConversion = null;
            if (conversion != null) {
                return conversion;
            }
            Iterator<Map.Entry<String, HttpEntity>> iterator = forms.entrySet().iterator();
            if (iterator.hasNext()) {
                Map.Entry<String, HttpEntity> entry = iterator.next();
                if (entry != null) {
                    return entry.getKey();
                }
            }
            List<String> pages = profile.getPages();
            return pages.get(rand.nextInt(pages.size()));
        }

        synchronized void processPage(String page, InputStream content) throws IOException {
            Conversion conversion = conversions.get(page);
            if (conversion != null) {
                for (String line : IOUtils.readLines(content)) {
                    if (line.contains(conversion.getText())) {
                        if (rand.nextDouble() < conversion.getRateMatch()) {
                            this.pendingConversion = conversion.getTo();
                        }
                        return;
                    }
                }
                if (rand.nextDouble() < conversion.getRateNoMatch()) {
                    this.pendingConversion = conversion.getTo();
                }
            }
            if (profile.getForms().containsKey(page)) {
                Form formDefinition = profile.getForms().get(page);
                prepareFormSubmit(formDefinition, content);
            }
        }

        private void prepareFormSubmit(Form formDefinition, InputStream content) throws IOException {
            String actionUrl = getActionUrl(formDefinition, content);
            if (actionUrl == null) {
                System.err.println("Form " + formDefinition.getFormName() + " was not found on page");
                return;
            }

            UrlEncodedFormEntity entity = buildFormEntity(formDefinition);
            forms.put(actionUrl, entity);
        }

        private String getActionUrl(Form formDefinition, InputStream content) throws IOException {
            Pattern pattern = createFormPattern(formDefinition.getFormName());
            for (String line : IOUtils.readLines(content)) {
                Matcher matcher = pattern.matcher(line);
                if (matcher.matches()) {
                    return matcher.group(1);
                }
            }
            return null;
        }

        private UrlEncodedFormEntity buildFormEntity(Form formDefinition) throws UnsupportedEncodingException {
            List<NameValuePair> entries = new LinkedList<>();
            for (Map.Entry<String, Object> entry : formDefinition.getData().entrySet()) {
                Object value = entry.getValue();
                if (value instanceof List) {
                    for (String listEntry : (List<String>) value) {
                        entries.add(new BasicNameValuePair(entry.getKey(), listEntry));
                    }
                } else {
                    entries.add(new BasicNameValuePair(entry.getKey(), value.toString()));
                }
            }
            return new UrlEncodedFormEntity(entries);
        }

        public void schedule(ScheduledExecutorService executor, Semaphore semaphore) {
            Request request = getFirstRequest();
            scheduleRequest(executor, semaphore, request);
        }

        void scheduleRequest(ScheduledExecutorService executor, Semaphore semaphore, Request request) {
            executor.schedule(() -> {
                Request nextRequest = getNextRequest();
                if (nextRequest != null) {
                    scheduleRequest(executor, semaphore, nextRequest);
                }
                try {
                    run(request);
                } catch (Throwable t) {
                    t.printStackTrace();
                } finally {
                    if (nextRequest == null) {
                        semaphore.release();
                    }
                }
            }, request.delay, TimeUnit.MILLISECONDS);
        }

        private void prepareRequest(HttpRequestBase request) {
            request.setHeaders(headers);
            long now = System.currentTimeMillis();
            long rescaled = startTime + (now - startTime) * DILATION;
            request.setHeader("Hippo-Date", Long.toString(rescaled));
        }

        class Request {

            final long delay;

            Request(long delay) {
                this.delay = delay;
            }

            void execute() {
                String page = samplePage();
                try {
                    long now = System.currentTimeMillis();
                    if (forms.containsKey(page)) {
                        HttpEntity entity = forms.remove(page);
                        HttpPost request = new HttpPost("http://localhost:8080" + page);
                        prepareRequest(request);
                        request.setEntity(entity);
                        try (CloseableHttpResponse response = client.execute(request)) {
                            StatusLine statusLine = response.getStatusLine();
                            if (statusLine.getStatusCode() != 302) {
                                System.err.println(page + " : " + statusLine.getReasonPhrase());
                            }
                        }
                    } else {
                        HttpGet request = new HttpGet("http://localhost:8080/site" + page);
                        prepareRequest(request);
                        try (CloseableHttpResponse response = client.execute(request)) {
                            StatusLine statusLine = response.getStatusLine();
                            if (statusLine.getStatusCode() != 200) {
                                System.err.println(page + " : " + statusLine.getReasonPhrase());
                            } else {
                                processPage(page, response.getEntity().getContent());
                            }
                        }
                    }
                    long end = System.currentTimeMillis();
                    if (end - now > 1000) {
                        System.err.println("Executing request took " + (end - now) + " ms");
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

    }

    private String getRandomIPAdress(Random rand) {
        Integer[] parts = new Integer[4];
        while (true) {
            for (int i = 0; i < 4; i++) {
                parts[i] = rand.nextInt(256);
            }
            String ip = StringUtils.join(parts, '.');
            Location location = geoIPService.getLocation(ip);
            if (location != null && location.getCity() != null && location.getCountry() != null) {
                return ip;
            }
        }
    }

    @Test
    public void testPattern() {
        String toMatch = "  <form class=\"form\" action=\"/site/contact?_hn:type=action&_hn:ref=r34_r1_r1_r1\" method=\"post\" name=\"contact\" >";
        Pattern pattern = createFormPattern("contact");
        Matcher matcher = pattern.matcher(toMatch);
        assertTrue(matcher.matches());

        String action = matcher.group(1);
        assertEquals("/site/contact?_hn:type=action&_hn:ref=r34_r1_r1_r1", action);
    }

}
