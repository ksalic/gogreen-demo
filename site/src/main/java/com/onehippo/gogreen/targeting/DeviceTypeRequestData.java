/*
 * Copyright 2016 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

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
