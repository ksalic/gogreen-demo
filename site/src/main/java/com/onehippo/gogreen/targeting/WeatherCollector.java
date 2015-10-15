/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

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

    private static final String DEFAULT_WWO_SERVICE_URL = "http://api.worldweatheronline.com/free/v2/weather.ashx";
    public static final int INVALID_WEATHER_CODE = -1;

    private static int[] SIMULATION_CODES = {
        389, // Moderate or heavy rain in area with thunder
        365, // Moderate or heavy sleet showers
        359, // Torrential rain shower
        356, // Moderate or heavy rain shower
        353, // Light rain shower
        314, // Moderate or Heavy freezing rain
        308, // Heavy rain
        302, // Moderate rain
        296, // Light rain
        248, // Fog
        230, // Blizzard
        143, // Mist
        122, // Overcast
        119, // Cloudy
        116, // Partly Cloudy
        113 // Clear/Sunny
    };

    private final String wwoApiKey;
    private final String wwoServiceUrl;

    private final LoadingCache<String, Integer> cache = CacheBuilder.newBuilder()
            .maximumSize(1000)
            .expireAfterWrite(6, TimeUnit.HOURS)
            .build(new CacheLoader<String, Integer>() {
                @Override
                public Integer load(final String ip) {
                    int result = INVALID_WEATHER_CODE;
                    try {
                        InetAddress address = InetAddress.getByName(ip);
                        boolean isGlobal = !address.isSiteLocalAddress()
                                && !address.isLinkLocalAddress()
                                && !address.isLoopbackAddress();

                        if (isGlobal) {
                            log.debug("Retrieving weather data for '{}'", ip);
                            final String weatherData = getWeatherData(ip);
                            result = parseWeatherCode(ip, weatherData);
                        } else {
                            log.debug("Not retrieving weather data for '{}' because it's not a global address", ip);
                        }

                    } catch (UnknownHostException e) {
                        final String message = "Unable to parse ip address '" + ip + "'";
                        if (log.isDebugEnabled()) {
                            log.warn(message, e);
                        } else {
                            log.warn(message + ": " + e.getMessage());
                        }
                    } catch (IOException e) {
                        final String message = "Failed to get weather data for '" + ip + "' from wwo service";
                        if (log.isDebugEnabled()) {
                            log.warn(message, e);
                        } else {
                            log.warn(message + ": " + e.getMessage());
                        }
                    }
                    log.debug("Using weather code {} for ip '{}'", result, ip);
                    return result;
                }
            });

    private final boolean enabled;

    public WeatherCollector(String id, Node node) throws IllegalArgumentException, RepositoryException {
        super(id);
        wwoServiceUrl = JcrUtils.getStringProperty(node, "wwoServiceUrl", DEFAULT_WWO_SERVICE_URL);
        wwoApiKey = JcrUtils.getStringProperty(node, "wwoApiKey", null);
        enabled = JcrUtils.getBooleanProperty(node, "enabled", true);
        if (wwoApiKey == null) {
            final String nodePath = JcrUtils.getNodePathQuietly(node);
            throw new IllegalArgumentException("WeatherCollector should be configured with property 'wwoApiKey'."
                    + ((nodePath == null) ? "" : "Set the value of this property at '"
                    + nodePath + "/@wwoApiKey'"));

        }
    }

    @Override
    public Integer getTargetingRequestData(final HttpServletRequest request,
                                           final boolean newVisitor,
                                           final boolean newVisit,
                                           final WeatherData targetingData) {
        if (!newVisit) {
            if (targetingData != null) {
                return targetingData.getWeatherCode();
            }
            log.warn("Unexpected empty WeatherData for non new visit. Create new WeatherData");
        }

        String ip = HstRequestUtils.getFarthestRemoteAddr(request);

        if (enabled) {
            return cache.getUnchecked(ip);
        } else {
            int code = ip.hashCode() % SIMULATION_CODES.length;
            if (code < 0) {
                code += SIMULATION_CODES.length;
            }
            return SIMULATION_CODES[code];
        }
    }

    @Override
    public WeatherData updateTargetingData(WeatherData weatherData, final Integer weatherCode) throws IllegalArgumentException {
        if (weatherData == null) {
            weatherData = new WeatherData(getId(), weatherCode);
        } else if (weatherCode != INVALID_WEATHER_CODE) {
            weatherData.setWeatherCode(weatherCode);
        }
        return weatherData;
    }

    static Integer parseWeatherCode(final String context, String weatherData) {
        try {
            final JSONObject json = (JSONObject) JSONSerializer.toJSON(weatherData);
            final JSONObject data = json.getJSONObject("data");
            if (data.has("error")) {
                final String errorMsg = data.getJSONArray("error").getJSONObject(0).getString("msg");
                log.warn("Wwo service responded with error for '" + context + "': " + errorMsg);
            } else {
                JSONObject current = data.getJSONArray("current_condition").getJSONObject(0);
                int weatherCode = current.getInt("weatherCode");
                String weatherDescription;
                try {
                    weatherDescription = current.getJSONArray("weatherDesc").getJSONObject(0).getString("value");
                } catch (JSONException e) {
                    weatherDescription = "(no description)";
                }
                log.debug("Wwo service returned {}/{} for '{}'", weatherCode, weatherDescription, context);
                return weatherCode;
            }
        } catch (JSONException e) {
            log.error("Failed to parse response from wwo service", e);
        }
        return INVALID_WEATHER_CODE;
    }

    private String getWeatherData(String ip) throws IOException {
        final URL wwoUrl = getWwoUrl(ip);
        long start = System.currentTimeMillis();
        try {
            final URLConnection urlConnection = wwoUrl.openConnection();
            urlConnection.setReadTimeout(1000);
            return IOUtils.toString(urlConnection.getInputStream());
        } finally {
            log.debug("Getting weather data for '{}' took {} ms", ip, String.valueOf(System.currentTimeMillis() - start));
        }
    }

    private URL getWwoUrl(String ip) throws MalformedURLException {
        final StringBuilder sb = new StringBuilder(wwoServiceUrl);
        sb.append("?format=json");
        sb.append("&key=").append(wwoApiKey);
        sb.append("&date=today");
        sb.append("&fx=no");     // omit forecast to reduce response size.
        sb.append("&q=").append(ip);
        log.debug("Weather data URL for '{}' is {}", ip, sb.toString());
        return new URL(sb.toString());
    }
}
