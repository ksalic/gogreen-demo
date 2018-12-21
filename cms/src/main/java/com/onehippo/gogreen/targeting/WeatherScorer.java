/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.onehippo.cms7.targeting.Scorer;
import com.onehippo.cms7.targeting.model.TargetGroup;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class WeatherScorer implements Scorer<WeatherData> {

    private static final Logger log = LoggerFactory.getLogger(WeatherScorer.class);

    private final Map<String, Set<Integer>> targetGroups = new HashMap<String, Set<Integer>>(3);

    @Override
    public void init(final Map<String, TargetGroup> targetGroups) {
        for (Map.Entry<String, TargetGroup> entry : targetGroups.entrySet()) {
            final String targetGroupId = entry.getKey();
            final Set<Integer> codes = new HashSet<Integer>();
            for (String code : entry.getValue().getProperties().keySet()) {
                try {
                    codes.add(Integer.parseInt(code));
                } catch (NumberFormatException e) {
                    log.error("Failed to parse weather target group configuration '" + targetGroupId + "': " +
                            "expected a number as weather code, but got '" + code + "'");
                }
                this.targetGroups.put(targetGroupId, codes);
            }
        }
    }

    @Override
    public double evaluate(final String targetGroupId, final WeatherData targetingData) {
        if (targetingData == null) {
            return 0.0;
        }

        if (!targetGroups.containsKey(targetGroupId)) {
            return 0.0;
        }

        final Set<Integer> codes = targetGroups.get(targetGroupId);
        return codes.contains(targetingData.getWeatherCode()) ? 1.0 : 0.0;
    }
}
