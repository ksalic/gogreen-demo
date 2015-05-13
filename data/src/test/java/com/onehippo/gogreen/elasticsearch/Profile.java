/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class Profile {

    private List<String> pages;
    private List<Conversion> conversions = Collections.emptyList();
    private Map<String, Form> forms = Collections.emptyMap();

    private int rate = 5;
    private List<String> ips = Collections.emptyList();
    private List<String> keywords = Collections.emptyList();
    private Frequency frequency = new Frequency();

    public Profile() {
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public List<String> getIps() {
        return ips;
    }

    public void setIps(List<String> ips) {
        this.ips = ips;
    }

    public List<String> getPages() {
        return pages;
    }

    public void setPages(List<String> pages) {
        this.pages = pages;
    }

    public List<Conversion> getConversions() {
        return conversions;
    }

    public void setConversions(List<Conversion> conversions) {
        this.conversions = conversions;
    }

    public Map<String, Form> getForms() {
        return forms;
    }

    public void setForms(Map<String, Form> forms) {
        this.forms = forms;
    }

    public List<String> getKeywords() {
        return keywords;
    }

    public void setKeywords(List<String> keywords) {
        this.keywords = keywords;
    }

    public Frequency getFrequency() {
        return frequency;
    }

    public void setFrequency(Frequency frequency) {
        this.frequency = frequency;
    }

}
