package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.collectors.AbstractCollector;
import com.onehippo.cms7.targeting.data.TargetingData;
import org.apache.commons.lang.StringUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.hippoecm.repository.util.JcrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by charliechen on 11/16/15.
 */
public class DeviceTypeCollector extends AbstractCollector<DeviceTypeTargetingData, DeviceTypeRequestData> {

    private static final Logger log = LoggerFactory.getLogger(DeviceTypeCollector.class);

    public DeviceTypeCollector(String id, Node node) throws RepositoryException {
        super(id);
    }

    @Override
    public DeviceTypeRequestData getTargetingRequestData(
            HttpServletRequest request,
            boolean newVisitor,
            boolean newVisit,
            DeviceTypeTargetingData previousTargetingData) {
        DeviceType deviceType = DeviceType.DESKTOP;

        String userAgent = request.getHeader("User-Agent");

        if (StringUtils.isBlank(userAgent)) {
            if (previousTargetingData != null) {
                deviceType = previousTargetingData.getDeviceType();
            }
        } else {
            deviceType = getDeviceType(userAgent);
        }

        return new DeviceTypeRequestData(deviceType);
    }

    @Override
    public DeviceTypeTargetingData updateTargetingData(DeviceTypeTargetingData targetingData, DeviceTypeRequestData requestData) throws IllegalArgumentException {
        DeviceType deviceType = null;

        if (requestData != null) {
            deviceType = requestData.getDeviceType();
        } else {
            return targetingData;
        }

        if (deviceType == null) {
            deviceType = DeviceType.DESKTOP;
        }

        if (targetingData == null) {
            targetingData = new DeviceTypeTargetingData(getId());
        }

        targetingData.setDeviceType(deviceType);

        return targetingData;
    }

    private DeviceType getDeviceType(String userAgent) {
        if (StringUtils.isBlank(userAgent)) return DeviceType.DESKTOP;

        userAgent = userAgent.toLowerCase();

        //iOS devices
        if (userAgent.contains("iphone")) return DeviceType.PHONE;

        if (userAgent.contains("ipad")) return DeviceType.TABLET;

        //Android devices
        if (userAgent.contains("android")) {
            if (userAgent.contains("mobile")) return DeviceType.PHONE;
            else return DeviceType.TABLET;
        }

        //Other mobile devices
        if (userAgent.contains("mobile")) return DeviceType.PHONE;

        //Others
        return DeviceType.DESKTOP;
    }
}
