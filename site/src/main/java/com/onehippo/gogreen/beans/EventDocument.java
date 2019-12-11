/**
 * Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.beans;

import java.util.Calendar;

import com.onehippo.gogreen.beans.compound.Address;
import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = "hippogogreen:event")
public class EventDocument extends Document {

    public Calendar getDate() {
        return getSingleProperty(Constants.PROP_DATE);
    }

    public Calendar getEndDate() {
        return getSingleProperty(Constants.PROP_ENDDATE);
    }

    public Address getLocation() {
        return getSingleProperty(Constants.PROP_LOCATION);
    }

    public String[] getTags() {
        return getMultipleProperty(Constants.PROP_TAGS);
    }

    public String[] getCategories() {
        return getMultipleProperty(Constants.PROP_CATEGORIES);
    }

}
