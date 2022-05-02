package com.onehippo.gogreen.beans.gs;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;

import java.util.List;

@HippoEssentialsGenerated(internalName = "myproject:bannercollection")
@Node(jcrType = "myproject:bannercollection")
public class Bannercollection extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "myproject:columns")
    public String getColumns() {
        return getSingleProperty("myproject:columns");
    }

    @HippoEssentialsGenerated(internalName = "myproject:bannerentity")
    public List<Bannerentity> getBannerentity() {
        return getChildBeans(Bannerentity.class);
    }

    @HippoEssentialsGenerated(internalName = "myproject:style")
    public String getStyle() {
        return getSingleProperty("myproject:style");
    }

    @HippoEssentialsGenerated(internalName = "myproject:fullwidth")
    public Boolean getFullwidth() {
        return getSingleProperty("myproject:fullwidth");
    }
}
