/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.hgge.targeting;

import java.io.IOException;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.util.concurrent.TimeUnit;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.onehippo.cms7.targeting.collectors.AbstractCollector;

import org.apache.commons.io.IOUtils;
import org.hippoecm.hst.util.HstRequestUtils;
import org.hippoecm.repository.util.JcrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

public class WeatherCollector extends AbstractCollector<WeatherData, Integer> {

    private static final Logger log = LoggerFactory.getLogger(WeatherCollector.class);

    private static final String DEFAULT_WWO_SERVICE_URL = "http://free.worldweatheronline.com/feed/weather.ashx";

    private final String wwoApiKey;
    private final String wwoServiceUrl;

    private final LoadingCache<String, Integer> cache = CacheBuilder.newBuilder()
            .maximumSize(1000).expireAfterWrite(6, TimeUnit.HOURS)
            .build(new CacheLoader<String, Integer>() {
                @Override
                public Integer load(final String ip) {
                    try {
                        if (!InetAddress.getByName(ip).isSiteLocalAddress()) {
                            return parseWeatherCode(getWeatherData(ip));
                        }
                    } catch(UnknownHostException e) {
                        final String message = "Unable to parse ip address";
                        if (log.isDebugEnabled()) {
                            log.warn(message, e);
                        } else {
                            log.warn(message + ": " + e.getMessage());
                        }
                    } catch (IOException e) {
                        final String message = "Failed to get weather data from wwo service";
                        if (log.isDebugEnabled()) {
                            log.warn(message, e);
                        } else {
                            log.warn(message + ": " + e.getMessage());
                        }
                    }
                    return -1;
                }
            });

    public WeatherCollector(String id, Node node) throws IllegalArgumentException, RepositoryException {
        super(id);
        wwoServiceUrl = JcrUtils.getStringProperty(node, "wwoServiceUrl", DEFAULT_WWO_SERVICE_URL);
        wwoApiKey = JcrUtils.getStringProperty(node, "wwoApiKey", null);
        if (wwoApiKey == null) {
            final String nodePath = JcrUtils.getNodePathQuietly(node) ;
            throw new IllegalArgumentException("WeatherCollector should be configured with property 'wwoApiKey'."
                    + ((nodePath == null) ? "" :  "Set the value of this property at '"
                                                  + nodePath + "/@wwoApiKey'"));

        }
    }

    @Override
    public Integer getTargetingRequestData(final HttpServletRequest request) {
        String ip = HstRequestUtils.getFarthestRemoteAddr(request);
        return cache.getUnchecked(ip);
    }

    @Override
    public WeatherData updateTargetingData(WeatherData weatherData, final Integer weatherCode) throws IllegalArgumentException {
        if (weatherData == null) {
            weatherData = new WeatherData(getId(), weatherCode);
        } else if (weatherCode != -1) {
            weatherData.setWeatherCode(weatherCode);
        }
        return weatherData;
    }

    @Override
    public boolean shouldUpdate(final boolean newVisitor, final boolean newVisit, final WeatherData targetingData) {
        return newVisit;
    }

    @Override
    public WeatherData convertJsonToTargetingData(final ObjectNode objectNode, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    @Override
    public JsonNode convertTargetingDataToJson(final WeatherData weatherData, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    @Override
    public Integer convertJsonToRequestData(final JsonNode jsonNode, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    @Override
    public JsonNode convertRequestDataToJson(final Integer integer, final ObjectMapper objectMapper) throws IOException {
        return null;
    }

    static Integer parseWeatherCode(String weatherData) {
        try {
            final JSONObject json = (JSONObject) JSONSerializer.toJSON(weatherData);
            final JSONObject data = json.getJSONObject("data");
            if (data.has("error")) {
                final String errorMsg = data.getJSONArray("error").getJSONObject(0).getString("msg");
                log.warn("Wwo service responded with error: " + errorMsg);
            } else {
                return data.getJSONArray("current_condition").getJSONObject(0).getInt("weatherCode");
            }
        } catch (JSONException e) {
            log.error("Failed to parse response from wwo service", e);
        }
        return -1;
    }

    private String getWeatherData(String ip) throws IOException {
        final URL wwoUrl = getWwoUrl(ip);
        long start = System.currentTimeMillis();
        try {
            final URLConnection urlConnection = wwoUrl.openConnection();
            urlConnection.setReadTimeout(1000);
            return IOUtils.toString(urlConnection.getInputStream());
        } finally {
            log.info("Getting weather data for '{}' took {} ms", ip, String.valueOf(System.currentTimeMillis() - start));
        }
    }

    private URL getWwoUrl(String ip) throws MalformedURLException {
        final StringBuilder sb = new StringBuilder(wwoServiceUrl);
        sb.append("?q=").append(ip);
        sb.append("&format=json");
        sb.append("&key=").append(wwoApiKey);
        sb.append("&date=today");
        log.info("Weather data URL is '{}'", sb.toString());
        return new URL(sb.toString());
    }
}
