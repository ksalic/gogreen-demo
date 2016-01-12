/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans.compound;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.hippoecm.hst.content.beans.standard.HippoResourceBean;

import com.onehippo.gogreen.DocumentTypes;

@Node(jcrType = DocumentTypes.IMAGE_SET)
public class ImageSet extends HippoGalleryImageSet {

    public String getAlt() {
        return getProperty(DocumentTypes.ImageSet.ALT);
    }

    public HippoResourceBean getSmallThumbnail() {
        return getBean(DocumentTypes.ImageSet.SMALL_THUMBNAIL);
    }

    public HippoResourceBean getLargeThumbnail() {
        return getBean(DocumentTypes.ImageSet.LARGE_THUMBNAIL);
    }

    public HippoResourceBean getExtraLargeThumbnail() {
        return getBean(DocumentTypes.ImageSet.EXTRA_LARGE_THUMBNAIL);
    }

    public HippoResourceBean getMobileLogo() {
        return getBean(DocumentTypes.ImageSet.MOBILE_LOGO);
    }

    public HippoResourceBean getMobileThumbnail() {
        return getBean(DocumentTypes.ImageSet.MOBILE_THUMBNAIL);
    }

    public HippoResourceBean getBannerCarousel() {
        return getBean(DocumentTypes.ImageSet.BANNER_CAROUSEL);
    }

    public HippoResourceBean getBanner() {
        return getBean(DocumentTypes.ImageSet.BANNER);
    }

    public HippoResourceBean getLandscapeImage() {
        return getBean(DocumentTypes.ImageSet.LANDSCAPE_IMAGE);
    }

    public Copyright getCopyright() {
        return getBean(DocumentTypes.ImageSet.COPYRIGHT);
    }
    
}
