/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoItem;

import com.onehippo.gogreen.utils.Constants;

/**
 * Bean mapping class for the 'hippogogreen:copyright' document type
 */
@Node(jcrType = Constants.NT_COPYRIGHT)
public class Copyright extends HippoItem {
    public String getDescription() {
        return getProperty(Constants.PROP_COPYRIGHT_DESCRIPTION);
    }

    public String getUrl() {
        return getProperty(Constants.PROP_COPYRIGHT_URL);
    }

}
