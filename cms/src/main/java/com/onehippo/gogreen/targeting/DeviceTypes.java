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
class DeviceTypes {

    private static final String[] DEVICE_TYPES = {
            "PHONE", "TABLET", "DESKTOP"
    };

    private static final Logger log = LoggerFactory.getLogger(DeviceTypes.class);

    private DeviceTypes() {
        // prevent instantiation
    }

    static JSONArray get() {
        JSONArray deviceTypes = new JSONArray();
        Session session = Session.get();
        ClassStringResourceLoader resourceLoader = new ClassStringResourceLoader(DeviceTypes.class);
        for (String type : DEVICE_TYPES) {
            final String description = resourceLoader.loadStringResource(DeviceTypes.class, "device.type." + type.toLowerCase(), session.getLocale(), null, null);
            final JSONObject codeAndDescription = new JSONObject();
            try {
                codeAndDescription.put("type", type);
                codeAndDescription.put("description", description);
                deviceTypes.put(codeAndDescription);
            } catch (JSONException e) {
                log.warn("Cannot convert device type '" + type + "' with description '" + description
                        + "' to JSON, ignoring this device type", e);
            }
        }
        return deviceTypes;
    }

}
