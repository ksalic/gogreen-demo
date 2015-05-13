/*
 * Copyright 2012-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.elasticsearch;

import java.util.Map;

public class Form {
    private String formname;
    private Map<String, Object> data;

    public String getFormName() {
        return formname;
    }

    public void setFormname(String formname) {
        this.formname = formname;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}
