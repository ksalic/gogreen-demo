/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import java.util.Calendar;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;

@Node(jcrType="hippogogreen:blogitem")
public class BlogItem extends Document {

    public Calendar getDate() {
        return getProperty(Constants.PROP_DATE);
    }

    public String[] getCategories() {
        return getProperty(Constants.PROP_CATEGORIES);
    }
    
     public String[] getTags() {
        return getProperty(Constants.PROP_TAGS);
    }
}
