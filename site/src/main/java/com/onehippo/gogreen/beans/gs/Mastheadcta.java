package com.onehippo.gogreen.beans.gs;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;

@HippoEssentialsGenerated(internalName = "myproject:mastheadcta")
@Node(jcrType = "myproject:mastheadcta")
public class Mastheadcta extends HippoCompound {

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
