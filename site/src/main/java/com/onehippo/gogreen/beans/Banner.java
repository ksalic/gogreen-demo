/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import com.onehippo.gogreen.beans.compound.ImageSet;
import com.onehippo.gogreen.beans.compound.ImageSetLink;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.content.beans.standard.HippoMirror;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;


/**
 * [hippogogreen:banner] > hippogogreen:basedocument
 * - hippogogreen:title (string)
 * + hippogogreen:image (hippogallerypicker:imagelink)
 * + hippogogreen:doclink (hippo:mirror)
 */

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = "hippogogreen:banner")
public class Banner extends HippoDocument {

    public String getTitle() {
        return getSingleProperty("hippogogreen:title");
    }

    public String getIcon() {
        return getSingleProperty("hippogogreen:icon");
    }

    public String getText() {
        return getSingleProperty("hippogogreen:bannertext");
    }

    public HippoBean getDocLink() {
        HippoMirror mirrorBean = getBean("hippogogreen:doclink");
        return mirrorBean.getReferencedBean();
    }


    public ImageSet getImage() {
        ImageSetLink imageLink = getBean("hippogogreen:image");
        return (ImageSet) imageLink.getReferencedBean();
    }


}
