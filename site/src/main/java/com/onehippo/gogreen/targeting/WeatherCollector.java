/**
 * Copyright 2012-2018 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import java.io.IOException;
import java.io.InputStream;
import java.net.*;
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

    private static final String DEFAULT_APIXU_API_URL = "http://api.apixu.com/v1";
    public static final int INVALID_WEATHER_CODE = -1;
    public static final String APIXU_SERVICE_URL_PROPERTY = "apixuServiceUrl";
    public static final String APIXU_API_KEY_PROPERTY = "apixuApiKey";

    private static int[] SIMULATION_CODES = {
            1000, //Sunny
            1003, //Partly cloudy
            1006, //Cloudy
            1009, //Overcast
            1030, //Mist
            1063, //Patchy rain possible
            1066, //Patchy snow possible
            1069, //Patchy sleet possible
            1072, //Patchy freezing drizzle possible
            1087, //Thundery outbreaks possible
            1114, //Blowing snow
            1117, //Blizzard
            1135, //Fog
            1147, //Freezing fog
            1150, //Patchy light drizzle
            1153, //Light drizzle
            1168, //Freezing drizzle
            1171, //Heavy freezing drizzle
            1180, //Patchy light rain
            1183, //Light rain
            1186, //Moderate rain at times
            1189, //Moderate rain
            1192, //Heavy rain at times
            1195, //Heavy rain
            1198, //Light freezing rain
            1201, //Moderate or heavy freezing rain
            1204, //Light sleet
            1207, //Moderate or heavy sleet
            1210, //Patchy light snow
            1213, //Light snow
            1216, //Patchy moderate snow
            1219, //Moderate snow
            1222, //Patchy heavy snow
            1225, //Heavy snow
            1237, //Ice pellets
            1240, //Light rain shower
            1243, //Moderate or heavy rain shower
            1246, //Torrential rain shower
            1249, //Light sleet showers
            1252, //Moderate or heavy sleet showers
            1255, //Light snow showers
            1258, //Moderate or heavy snow showers
            1261, //Light showers of ice pellets
            1264, //Moderate or heavy showers of ice pellets
            1273, //Patchy light rain with thunder
            1276, //Moderate or heavy rain with thunder
            1279, //Patchy light snow with thunder
            1282 //Moderate or heavy snow with thunder
    };

    private final String apixuApiKey;
    private final String apixuServiceUrl;

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
                        final String message = "Failed to get weather data for '" + ip + "' from Apixu service";
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
        apixuServiceUrl = JcrUtils.getStringProperty(node, APIXU_SERVICE_URL_PROPERTY, DEFAULT_APIXU_API_URL);
        apixuApiKey = JcrUtils.getStringProperty(node, APIXU_API_KEY_PROPERTY, null);
        enabled = JcrUtils.getBooleanProperty(node, "enabled", true);
        if (apixuApiKey == null) {
            final String nodePath = JcrUtils.getNodePathQuietly(node);
            throw new IllegalArgumentException("WeatherCollector should be configured with property 'apixuApiKey'."
                    + ((nodePath == null) ? "" : "Set the value of this property at '"
                    + nodePath + "/@apixuApiKey'"));

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
            JSONObject json = (JSONObject) JSONSerializer.toJSON(weatherData);
            if (json.has("error")) {
                final JSONObject error = json.getJSONObject("error");
                final String errorMsg = error.getString("message");
                final int errorCode = error.getInt("code");
                log.warn("Apixu service responded with error for '" + context + "' message: '" + errorMsg + "' code: '" + errorCode + "'");
            } else {
                JSONObject condition = json.getJSONObject("current").getJSONObject("condition");
                int weatherCode = condition.getInt("code");
                String weatherDescription;
                try {
                    weatherDescription = condition.getString("text");
                } catch (JSONException e) {
                    weatherDescription = "(no description)";
                }
                log.debug("Apixu service returned {}/{} for '{}'", weatherCode, weatherDescription, context);
                return weatherCode;
            }
        } catch (JSONException e) {
            log.error("Failed to parse response from Apixu service", e);
        }
        return INVALID_WEATHER_CODE;
    }

    private String getWeatherData(String ip) throws IOException {
        final URL apixuUrl = getApixuUrl(ip);
        long start = System.currentTimeMillis();
        URLConnection urlConnection = null;
        try {
            urlConnection = apixuUrl.openConnection();
            urlConnection.setReadTimeout(1000);
            return IOUtils.toString(urlConnection.getInputStream());
        } catch (IOException e) {
            InputStream error = ((HttpURLConnection)urlConnection).getErrorStream();
            if (error != null) {
                return IOUtils.toString(error);
            }
            throw e;
        }
        finally {
            log.debug("Getting weather data for '{}' took {} ms", ip, String.valueOf(System.currentTimeMillis() - start));
        }
    }

    private URL getApixuUrl(String ip) throws MalformedURLException {
        final StringBuilder sb = new StringBuilder(apixuServiceUrl);
        sb.append("/current.json");
        sb.append("?key=").append(apixuApiKey);
        sb.append("&q=").append(ip);
        log.debug("Weather data URL for '{}' is {}", ip, sb.toString());
        return new URL(sb.toString());
    }
}
