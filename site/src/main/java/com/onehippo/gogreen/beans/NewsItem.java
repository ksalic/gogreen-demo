/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import java.util.Calendar;
import java.util.List;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;

@Node(jcrType=Constants.NT_NEWSITEM)
public class NewsItem extends SimpleDocument {
    
    public Calendar getDate() {
        return getProperty(Constants.PROP_DATE);
    }

}
