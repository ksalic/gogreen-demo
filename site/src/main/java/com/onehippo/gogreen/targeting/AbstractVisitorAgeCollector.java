/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;

import com.onehippo.cms7.targeting.collectors.AbstractCollector;

/**
 * AbstractContentVisitCollector
 */
public abstract class AbstractVisitorAgeCollector extends AbstractCollector<AgeTargetingData, AgeTargetingRequestData> {

    public AbstractVisitorAgeCollector(String id, Node node) throws RepositoryException {
        super(id);
    }

    @Override
    public AgeTargetingRequestData getTargetingRequestData(final HttpServletRequest request,
                                           final boolean newVisitor,
                                           final boolean newVisit,
                                           final AgeTargetingData targetingData) {

        final Integer age = extractAge(request);
        return new AgeTargetingRequestData(age);      
    }

    @Override
    public AgeTargetingData updateTargetingData(AgeTargetingData targetingData,
            AgeTargetingRequestData requestData) {

        int age = -1;

        if (requestData != null) {
            age = requestData.getAge();
        }

        if (age == -1) {
            return targetingData;
        }

        if (targetingData == null) {
            targetingData = new AgeTargetingData(getId());
        }

        targetingData.setAge(age);

        return targetingData;
    }

    abstract protected Integer extractAge(HttpServletRequest request);

}
