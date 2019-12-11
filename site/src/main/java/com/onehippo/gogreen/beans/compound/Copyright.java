/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoItem;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;

import com.onehippo.gogreen.utils.Constants;

/**
 * Bean mapping class for the 'hippogogreen:copyright' document type
 */
@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = Constants.NT_COPYRIGHT)
public class Copyright extends HippoItem {
    public String getDescription() {
        return getSingleProperty(Constants.PROP_COPYRIGHT_DESCRIPTION);
    }

    public String getUrl() {
        return getSingleProperty(Constants.PROP_COPYRIGHT_URL);
    }

}
