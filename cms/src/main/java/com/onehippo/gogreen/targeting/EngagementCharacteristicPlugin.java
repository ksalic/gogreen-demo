/**
 * Copyright 2011-2016 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.frontend.plugin.BuiltinCharacteristicPlugin;
import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.apache.wicket.request.resource.PackageResourceReference;
import org.apache.wicket.request.resource.ResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.wicketstuff.js.ext.util.ExtClass;

@ExtClass("Hippo.Targeting.EngagementCharacteristicPlugin")
public class EngagementCharacteristicPlugin extends BuiltinCharacteristicPlugin {

    private static final JavaScriptResourceReference JS = new JavaScriptResourceReference(EngagementCharacteristicPlugin.class, "EngagementCharacteristicPlugin.js");


    public EngagementCharacteristicPlugin(final IPluginContext context, final IPluginConfig config) {
        super(context, config);
    }

    @Override
    public void renderHead(final Component component, final IHeaderResponse response) {
        super.renderHead(component, response);
        response.render(JavaScriptHeaderItem.forReference(JS));
    }

    @Override
    protected ResourceReference getIcon() {
        return new PackageResourceReference(EngagementCharacteristicPlugin.class, "engagement.png");
    }

}
