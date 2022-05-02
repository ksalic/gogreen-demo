package com.onehippo.gogreen.beans.gs;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoBean;

@HippoEssentialsGenerated(internalName = "myproject:banneritemcta")
@Node(jcrType = "myproject:banneritemcta")
public class Banneritemcta extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "myproject:text")
    public String getText() {
        return getSingleProperty("myproject:text");
    }

    @HippoEssentialsGenerated(internalName = "myproject:style")
    public String getStyle() {
        return getSingleProperty("myproject:style");
    }

    @HippoEssentialsGenerated(internalName = "myproject:link")
    public HippoBean getLink() {
        return getLinkedBean("myproject:link", HippoBean.class);
    }
}
