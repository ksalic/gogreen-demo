/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

public class Conversion {

    private String from;
    private String to;
    private String text;
    private double rateNoMatch;
    private double rateMatch;

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public double getRateNoMatch() {
        return rateNoMatch;
    }

    public void setRateNoMatch(double rateNoMatch) {
        this.rateNoMatch = rateNoMatch;
    }

    public double getRateMatch() {
        return rateMatch;
    }

    public void setRateMatch(double rateMatch) {
        this.rateMatch = rateMatch;
    }
}
