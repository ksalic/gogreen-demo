/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

public class AgeTargetingRequestData {

    protected Integer age;

    // Required by Jackson
    @SuppressWarnings("unused")
    public AgeTargetingRequestData() {
        this.age = -1;
    }
    
    // Required by Jackson
    @SuppressWarnings("unused")
    public AgeTargetingRequestData(int visitorAge) {
        this.age = visitorAge;
    }


    @SuppressWarnings("unused")
    public Integer getAge() {
        return age;
    }

    @SuppressWarnings("unused")
    public void setAge(int visitorAge) {
        this.age = visitorAge;
    }
}
