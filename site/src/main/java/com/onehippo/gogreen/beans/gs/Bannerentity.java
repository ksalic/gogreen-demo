package com.onehippo.gogreen.beans.gs;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import com.onehippo.gogreen.beans.gs.Banneritemcta;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;

@HippoEssentialsGenerated(internalName = "myproject:bannerentity")
@Node(jcrType = "myproject:bannerentity")
public class Bannerentity extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "myproject:subtitle")
    public String getSubtitle() {
        return getSingleProperty("myproject:subtitle");
    }

    @HippoEssentialsGenerated(internalName = "myproject:title")
    public String getTitle() {
        return getSingleProperty("myproject:title");
    }

    @HippoEssentialsGenerated(internalName = "myproject:theme")
    public String getTheme() {
        return getSingleProperty("myproject:theme");
    }

    @HippoEssentialsGenerated(internalName = "myproject:content")
    public HippoHtml getContent() {
        return getHippoHtml("myproject:content");
    }

    @HippoEssentialsGenerated(internalName = "myproject:banneritemcta")
    public Banneritemcta getBanneritemcta() {
        return getBean("myproject:banneritemcta", Banneritemcta.class);
    }

    @HippoEssentialsGenerated(internalName = "myproject:image")
    public HippoGalleryImageSet getImage() {
        return getLinkedBean("myproject:image", HippoGalleryImageSet.class);
    }
}
