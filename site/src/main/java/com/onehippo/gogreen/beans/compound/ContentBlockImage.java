/*
 * Copyright 2015 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompoundBean;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSetBean;
import org.hippoecm.hst.content.beans.standard.HippoItem;

/**
 * Bean mapping class for the 'hippogogreen:imageblock' document type
 */
@Node(jcrType = "hippogogreen:imageblock")
public class ContentBlockImage extends HippoItem implements HippoCompoundBean {

    public String getType() {
        return "image";
    }

    public HippoGalleryImageSetBean getImage() {
        return getLinkedBean("hippogogreen:image", HippoGalleryImageSetBean.class);
    }

    public String getAlignment() {
        return getProperty("hippogogreen:alignment");
    }

}
