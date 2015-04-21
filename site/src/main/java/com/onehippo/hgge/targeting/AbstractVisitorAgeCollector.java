/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *         http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.onehippo.hgge.targeting;

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
    public AgeTargetingRequestData getTargetingRequestData(final HttpServletRequest request) {
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
