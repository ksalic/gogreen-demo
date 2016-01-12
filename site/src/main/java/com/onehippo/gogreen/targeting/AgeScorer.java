/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import java.util.HashMap;
import java.util.Map;

import com.onehippo.cms7.targeting.model.TargetGroup;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 */
public class AgeScorer extends AbstractJexlScorer<AgeTargetingData> {

    private static final Logger log = LoggerFactory.getLogger(AgeScorer.class);

    private Map<String, TargetGroup> targetGroups;

    @Override
    public void init(Map<String, TargetGroup> targetGroups) {
        this.targetGroups = targetGroups;
    }

    @Override
    public double evaluate(final String targetGroupId, final AgeTargetingData targetingData) {
        if (targetingData == null) {
            return 0.0;
        }

        if (!targetGroups.containsKey(targetGroupId)) {
            log.warn("Cannot find target group with id '{}'. Return a score of 0.0", targetGroupId);
            return 0.0;
        }

        TargetGroup targetGroup = targetGroups.get(targetGroupId);

        Map<String, String> props = targetGroup.getProperties();

        if (props.isEmpty()) {
            return 0.0;
        }

        String expression = props.keySet().iterator().next();

        if (StringUtils.isBlank(expression)) {
            return 0.0;
        }

        Integer age = targetingData.getAge();

        if (age == null) {
            return 0.0;
        }

        if (age < 0) {
            return 0.0;
        }

        Map<String, Object> vars = new HashMap<String, Object>();
        vars.put("data", targetingData);
        vars.put("age", age);
        return evaluateExpression(expression, vars);
    }

}
