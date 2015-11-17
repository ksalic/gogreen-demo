package com.onehippo.gogreen.targeting;


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.onehippo.cms7.targeting.data.AbstractTargetingData;


/**
 * Created by charliechen on 11/16/15.
 */
public class DeviceTypeTargetingData extends AbstractTargetingData {

    private DeviceType deviceType;

    // This constructor is created to be used by Jackson
    @JsonCreator
    public DeviceTypeTargetingData(@JsonProperty("collectorId") final String collectorId,
                                   @JsonProperty("deviceType") final DeviceType deviceType) {
        this(collectorId);
        this.deviceType = deviceType;
    }

    public DeviceTypeTargetingData(final String collectorId) {
        super(collectorId);
        this.deviceType = DeviceType.DESKTOP;
    }

    @JsonProperty("deviceType")
    public DeviceType getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(DeviceType deviceType) {
        this.deviceType = deviceType;
    }
}
