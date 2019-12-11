/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.hippoecm.hst.content.beans.standard.HippoMirror;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = Constants.NT_SIMPLE_DOCUMENT)
public class SimpleDocument extends BaseDocument {

    public String getTitle() {
        return getSingleProperty(Constants.PROP_TITLE);
    }

    public String getSummary() {
        return getSingleProperty(Constants.PROP_SUMMARY);
    }

    public HippoHtml getDescription() {
        return getBean(Constants.PROP_DESCRIPTION);
    }

}
