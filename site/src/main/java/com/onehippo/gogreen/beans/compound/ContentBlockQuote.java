/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompoundBean;
import org.hippoecm.hst.content.beans.standard.HippoItem;

/**
 * Bean mapping class for the 'hippogogreen:quoteblock' document type
 */
@Node(jcrType = "hippogogreen:quoteblock")
public class ContentBlockQuote extends HippoItem implements HippoCompoundBean {

    public String getType() {
        return "quote";
    }

    public String getQuote() {
        return getProperty("hippogogreen:quote");
    }

    public String getAlignment() {
        return getProperty("hippogogreen:alignment");
    }

}
