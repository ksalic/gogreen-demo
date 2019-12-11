/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import java.util.Calendar;
import java.util.List;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType=Constants.NT_NEWSITEM)
public class NewsItem extends SimpleDocument {
    
    public Calendar getDate() {
        return getSingleProperty(Constants.PROP_DATE);
    }

}
