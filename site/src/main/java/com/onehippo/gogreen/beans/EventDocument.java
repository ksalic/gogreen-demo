/**
 * Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.beans;

import java.util.Calendar;

import com.onehippo.gogreen.beans.compound.Address;
import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;

@Node(jcrType = "hippogogreen:event")
public class EventDocument extends Document {

    public Calendar getDate() {
        return getProperty(Constants.PROP_DATE);
    }

    public Calendar getEndDate() {
        return getProperty(Constants.PROP_ENDDATE);
    }

    public Address getLocation() {
        return getBean(Constants.PROP_LOCATION);
    }

    public String[] getTags() {
        return getProperty(Constants.PROP_TAGS);
    }

    public String[] getCategories() {
        return getProperty(Constants.PROP_CATEGORIES);
    }

}
