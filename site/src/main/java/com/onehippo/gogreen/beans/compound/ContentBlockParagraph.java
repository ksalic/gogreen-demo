/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoCompoundBean;
import org.hippoecm.hst.content.beans.standard.HippoItem;

/**
 * Bean mapping class for the 'hippogogreen:paragraphblock' document type
 */
@Node(jcrType = "hippogogreen:paragraphblock")
public class ContentBlockParagraph extends HippoItem implements HippoCompoundBean {

    public String getType() {
        return "paragraph";
    }

    public String getText() {
        return getProperty("hippogogreen:text");
    }

    public String getHeader() {
        return getProperty("hippogogreen:header");
    }

}
