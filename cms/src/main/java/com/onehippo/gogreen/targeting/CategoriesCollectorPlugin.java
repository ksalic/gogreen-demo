/**
 * Copyright 2012 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.frontend.plugin.TermsFrequencyCollectorPlugin;

import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;

/**
 * Plugin for the 'categories' collector. It simply extends the terms frequency collector plugin, and provides its own
 * collector name in the resource bundle of this class.
 */
public class CategoriesCollectorPlugin extends TermsFrequencyCollectorPlugin {

    public CategoriesCollectorPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

}
