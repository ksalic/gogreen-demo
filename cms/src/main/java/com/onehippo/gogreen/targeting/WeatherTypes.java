/*
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
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
            "113", "116", "119", "122", "143", "248", "260",
            // rain
            "263", "266", "176", "293", "296", "353", "299", "302", "356", "305", "308", "359",
            // freezing rain
            "185", "281", "284", "311", "314",
            // in between rain and snow (sleet, ice pellets)
            "182", "317", "320", "362", "365", "350", "374", "377",
            // snow
            "323", "326", "368", "179", "329", "332", "371", "335", "338", "227", "230",
            // thunder
            "200", "386", "389", "392", "395"
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
