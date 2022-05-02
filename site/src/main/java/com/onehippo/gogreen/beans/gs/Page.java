package com.onehippo.gogreen.beans.gs;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;

@HippoEssentialsGenerated(internalName = "myproject:page")
@Node(jcrType = "myproject:page")
public class Page extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "myproject:title")
    public String getTitle() {
        return getSingleProperty("myproject:title");
    }

    @HippoEssentialsGenerated(internalName = "myproject:metadescription")
    public String getMetadescription() {
        return getSingleProperty("myproject:metadescription");
    }

    @HippoEssentialsGenerated(internalName = "myproject:metarobots")
    public String getMetarobots() {
        return getSingleProperty("myproject:metarobots");
    }

    @HippoEssentialsGenerated(internalName = "myproject:ogtitle")
    public String getOgtitle() {
        return getSingleProperty("myproject:ogtitle");
    }

    @HippoEssentialsGenerated(internalName = "myproject:ogtype")
    public String getOgtype() {
        return getSingleProperty("myproject:ogtype");
    }

    @HippoEssentialsGenerated(internalName = "myproject:ogimage")
    public HippoGalleryImageSet getOgimage() {
        return getLinkedBean("myproject:ogimage", HippoGalleryImageSet.class);
    }
}
