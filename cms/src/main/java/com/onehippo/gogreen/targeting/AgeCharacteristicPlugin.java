/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.apache.wicket.request.resource.PackageResourceReference;
import org.apache.wicket.request.resource.ResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.wicketstuff.js.ext.util.ExtClass;

import com.onehippo.cms7.targeting.frontend.plugin.CharacteristicPlugin;

/**
 * 
 */
@ExtClass("Hippo.Targeting.AgeCharacteristicPlugin")
public class AgeCharacteristicPlugin extends CharacteristicPlugin {

    private static final long serialVersionUID = 1L;

    private static final JavaScriptResourceReference DOCTYPE_JS =
            new JavaScriptResourceReference(AgeCharacteristicPlugin.class,
                                            "AgeCharacteristicPlugin.js");

    public AgeCharacteristicPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    protected ResourceReference getIcon() {
        return new PackageResourceReference(AgeCharacteristicPlugin.class, "clock_16.png");
    }

    @Override
    public void renderHead(final Component component, IHeaderResponse response) {
        super.renderHead(component, response);
        response.render(JavaScriptHeaderItem.forReference(DOCTYPE_JS));
    }

}
