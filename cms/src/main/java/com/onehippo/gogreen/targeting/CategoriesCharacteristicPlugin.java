/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.frontend.plugin.TermsFrequencyCharacteristicPlugin;

import org.apache.wicket.request.resource.PackageResourceReference;
import org.apache.wicket.request.resource.ResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;

/**
 * Plugin for the 'categories' characteristic. It simply extends the terms frequency plugin, and provides its own
 * characteristic name and subject in the resource bundle of this class.
 */
public class CategoriesCharacteristicPlugin extends TermsFrequencyCharacteristicPlugin {

    public CategoriesCharacteristicPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    protected ResourceReference getIcon() {
        return new PackageResourceReference(CategoriesCharacteristicPlugin.class, "CategoriesCharacteristicPlugin.png");
    }

}
