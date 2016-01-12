/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;


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
