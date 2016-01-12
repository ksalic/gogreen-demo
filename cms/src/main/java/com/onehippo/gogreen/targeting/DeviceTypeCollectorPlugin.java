/*
 * Copyright 2016 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.frontend.plugin.CollectorPlugin;
import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.json.JSONException;
import org.json.JSONObject;
import org.wicketstuff.js.ext.util.ExtClass;
@ExtClass("Hippo.Targeting.DeviceTypeCollectorPlugin")
public class DeviceTypeCollectorPlugin extends CollectorPlugin {

    private static final JavaScriptResourceReference DOCTYPE_JS =
            new JavaScriptResourceReference(DeviceTypeCollectorPlugin.class,
                    "DeviceTypeCollectorPlugin.js");

    public DeviceTypeCollectorPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    protected void onRenderProperties(final JSONObject properties)
            throws JSONException {
        super.onRenderProperties(properties);
        properties.put("deviceTypes", DeviceTypes.get());
    }

    @Override
    public void renderHead(final Component component, IHeaderResponse response) {
        super.renderHead(component, response);
        response.render(JavaScriptHeaderItem.forReference(DOCTYPE_JS));
    }

}
