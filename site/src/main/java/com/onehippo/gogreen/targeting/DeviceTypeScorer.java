/*
 * Copyright 2016 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.Scorer;
import com.onehippo.cms7.targeting.model.TargetGroup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class DeviceTypeScorer implements Scorer<DeviceTypeTargetingData> {

    private static final Logger log = LoggerFactory.getLogger(DeviceTypeScorer.class);

    private final Map<String, Set<DeviceType>> targetGroups = new HashMap<>(3);

    @Override
    public void init(final Map<String, TargetGroup> targetGroups) {
        for (Map.Entry<String, TargetGroup> entry : targetGroups.entrySet()) {
            final String targetGroupId = entry.getKey();
            final Set<DeviceType> deviceTypes = new HashSet<>();
            for (String deviceType : entry.getValue().getProperties().keySet()) {
                try {
                    deviceTypes.add(DeviceType.valueOf(deviceType));
                } catch (IllegalArgumentException e) {
                    log.error("Failed to parse device-type target group configuration '" + targetGroupId + "': " +
                            "expected a DeviceType, but got '" + deviceType + "'");
                }
                this.targetGroups.put(targetGroupId, deviceTypes);
            }
        }
    }

    @Override
    public double evaluate(final String targetGroupId, final DeviceTypeTargetingData targetingData) {
        if (targetingData == null) {
            return 0.0;
        }

        if (!targetGroups.containsKey(targetGroupId)) {
            return 0.0;
        }

        final Set<DeviceType> deviceTypes = targetGroups.get(targetGroupId);

        return deviceTypes.contains(targetingData.getDeviceType()) ? 1.0 : 0.0;
    }
}
