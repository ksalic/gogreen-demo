/*
 * Copyright 2014-2014 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.json.JSONException;
import org.json.JSONObject;
import org.wicketstuff.js.ext.util.ExtClass;

import com.onehippo.cms7.targeting.frontend.plugin.CollectorPlugin;
 
@ExtClass("Hippo.Targeting.AgeCollectorPlugin")
@SuppressWarnings("unused")
public class AgeCollectorPlugin extends CollectorPlugin {
    
        private static final JavaScriptResourceReference DOCTYPE_JS =
            new JavaScriptResourceReference(AgeCollectorPlugin.class,
                                            "AgeCollectorPlugin.js");
 
    public AgeCollectorPlugin(final IPluginContext context,
                                 final IPluginConfig config) {
        super(context, config);
    }
 
    @Override
    protected void onRenderProperties(final JSONObject properties)
                                                    throws JSONException {
        super.onRenderProperties(properties);
    }
    
    @Override
    public void renderHead(final Component component, IHeaderResponse response) {
        super.renderHead(component, response);
        response.render(JavaScriptHeaderItem.forReference(DOCTYPE_JS));
    }
 
}
