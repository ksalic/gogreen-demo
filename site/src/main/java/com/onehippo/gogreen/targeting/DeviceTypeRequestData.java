package com.onehippo.gogreen.targeting;

/**
 * Created by charliechen on 11/16/15.
 */
public class DeviceTypeRequestData {

    protected DeviceType deviceType;

    // Required by Jackson
    public DeviceTypeRequestData() {
        this.deviceType = DeviceType.DESKTOP;
    }

    // Required by Jackson
    public DeviceTypeRequestData(DeviceType deviceType) {
        this.deviceType = deviceType;
    }

    public DeviceType getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(DeviceType deviceType) {
        this.deviceType = deviceType;
    }
}
