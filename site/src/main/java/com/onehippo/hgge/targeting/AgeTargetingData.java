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


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.onehippo.cms7.targeting.data.AbstractTargetingData;

/**
 * Returns the name
 */
public class AgeTargetingData extends AbstractTargetingData {

    private Integer age;

    // This constructor is created to be used by Jackson
    @JsonCreator
    @SuppressWarnings("unused")
    public AgeTargetingData(@JsonProperty("collectorId") final String collectorId,
                                       @JsonProperty("age") final Integer visitorAge) {
        this(collectorId);
        this.age = visitorAge;
    }

    public AgeTargetingData(final String collectorId) {
        super(collectorId);
        this.age = -1;
    }

    @JsonProperty("age")
    public Integer getAge() {
        return age;
    }

    public void setAge(int visitorAge) {
        this.age = visitorAge;
    }
}
