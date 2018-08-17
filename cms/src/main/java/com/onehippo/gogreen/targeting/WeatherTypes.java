/*
 * Copyright 2012-2018 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import org.apache.wicket.Session;
import org.apache.wicket.resource.loader.ClassStringResourceLoader;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Defines the available weather codes and their human-readable description.
 */
class WeatherTypes {

    private static final String[] WEATHER_CODES = {
            // from sunny to foggy
            "1000","1003","1006","1009","1030","1117","1135",
            // rain
            "1063","1150","1153","1180","1183","1186","1189","1192","1195","1240","1243","1246",
            // freezing rain
            "1072","1168","1171","1198","1201",
            // in between rain and snow (sleet, ice pellets)
            "1204","1207","1237","1249","1252","1261","1264","1069",
            // snow
            "1066","1114","1117","1210","1213","1216","1219","1222","1225","1255","1258",
            // thunder
            "1087","1273","1276","1279","1282"
    };

    private static final Logger log = LoggerFactory.getLogger(WeatherTypes.class);

    private WeatherTypes() {
        // prevent instantiation
    }

    static JSONArray get() {
        JSONArray weatherTypes = new JSONArray();
        Session session = Session.get();
        ClassStringResourceLoader resourceLoader = new ClassStringResourceLoader(WeatherTypes.class);
        for (String code : WEATHER_CODES) {
            final String description = resourceLoader.loadStringResource(WeatherTypes.class, "weather.type." + code, session.getLocale(), null, null);
            final JSONObject codeAndDescription = new JSONObject();
            try {
                codeAndDescription.put("code", code);
                codeAndDescription.put("description", description);
                weatherTypes.put(codeAndDescription);
            } catch (JSONException e) {
                log.warn("Cannot convert weather code '" + code + "' with description '" + description
                        + "' to JSON, ignoring this weather code", e);
            }
        }
        return weatherTypes;
    }

}
