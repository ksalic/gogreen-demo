package com.onehippo.gogreen.beans.gs;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;

import java.util.List;

@HippoEssentialsGenerated(internalName = "myproject:head")
@Node(jcrType = "myproject:head")
public class Head extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "myproject:title")
    public String getTitle() {
        return getSingleProperty("myproject:title");
    }

    @HippoEssentialsGenerated(internalName = "myproject:bynderimage")
    public String getBynderimage() {
        return getSingleProperty("myproject:bynderimage");
    }

    @HippoEssentialsGenerated(internalName = "myproject:content")
    public HippoHtml getContent() {
        return getHippoHtml("myproject:content");
    }

    @HippoEssentialsGenerated(internalName = "myproject:image")
    public HippoGalleryImageSet getImage() {
        return getLinkedBean("myproject:image", HippoGalleryImageSet.class);
    }

    @HippoEssentialsGenerated(internalName = "myproject:cta")
    public List<Mastheadcta> getCta() {
        return getChildBeansByName("myproject:cta", Mastheadcta.class);
    }

}
