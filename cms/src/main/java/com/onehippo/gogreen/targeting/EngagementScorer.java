/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
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


public class EngagementScorer implements Scorer<EngagementData> {

    private static final Logger log = LoggerFactory.getLogger(EngagementScorer.class);

    private final Map<String, String> targetGroups = new HashMap<>();

    @Override
    public void init(final Map<String, TargetGroup> targetGroups) {
        for (Map.Entry<String, TargetGroup> entry : targetGroups.entrySet()) {
            final String targetGroupId = entry.getKey();
            String segmentId = null;
            for (String code : entry.getValue().getProperties().keySet()) {
                try {
                    segmentId = code;
                } catch (NumberFormatException e) {
                    log.error("Failed to parse weather target group configuration '" + targetGroupId + "': " +
                            "expected a number as weather code, but got '" + code + "'");
                }
                this.targetGroups.put(targetGroupId, segmentId);
                break;
            }
        }
    }

    @Override
    public double evaluate(final String targetGroupId, final EngagementData targetingData) {
        if (targetingData == null) {
            return 0.0;
        }

        if (!targetGroups.containsKey(targetGroupId)) {
            return 0.0;
        }

        String segmentId = targetGroups.get(targetGroupId);
        return targetingData.getSegments().contains(segmentId) ? 1.0 : 0.0;
    }
}
