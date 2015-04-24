/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.onehippo.cms7.targeting.data.AbstractTargetingData;


public class WeatherData extends AbstractTargetingData {

    private int weatherCode;

    @JsonCreator
    public WeatherData(@JsonProperty("collectorId") String collectorId, @JsonProperty("weatherCode") int weatherCode) {
        super(collectorId);
        this.weatherCode = weatherCode;
    }

    public int getWeatherCode() {
        return weatherCode;
    }

    void setWeatherCode(int weatherCode) {
        this.weatherCode = weatherCode;
    }

}
