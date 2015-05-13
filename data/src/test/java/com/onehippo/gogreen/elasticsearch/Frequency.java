/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import java.util.Arrays;
import java.util.List;

public class Frequency {
    private List<Integer> daily = Arrays.asList(5, 5, 5, 5);
    private List<Integer> weekly = Arrays.asList(5, 5, 5, 5, 5, 5, 5);

    public List<Integer> getDaily() {
        return daily;
    }

    public void setDaily(List<Integer> daily) {
        this.daily = daily;
    }

    public List<Integer> getWeekly() {
        return weekly;
    }

    public void setWeekly(List<Integer> weekly) {
        this.weekly = weekly;
    }
}
