/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.frontend.plugin.CharacteristicPlugin;

import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.apache.wicket.request.resource.PackageResourceReference;
import org.apache.wicket.request.resource.ResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.json.JSONException;
import org.json.JSONObject;
import org.wicketstuff.js.ext.util.ExtClass;

@ExtClass("Hippo.Targeting.WeatherCharacteristicPlugin")
public class WeatherCharacteristicPlugin extends CharacteristicPlugin {

    private static final JavaScriptResourceReference JS = new JavaScriptResourceReference(WeatherCharacteristicPlugin.class, "WeatherCharacteristicPlugin.js");

    public WeatherCharacteristicPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    public void renderHead(final Component component, final IHeaderResponse response) {
        super.renderHead(component, response);

        response.render(JavaScriptHeaderItem.forReference(JS));
    }

    @Override
    protected ResourceReference getIcon() {
        return new PackageResourceReference(WeatherCharacteristicPlugin.class, "WeatherCharacteristicPlugin.png");
    }

    @Override
    protected void onRenderProperties(final JSONObject properties) throws JSONException {
        super.onRenderProperties(properties);
        properties.put("weatherTypes", WeatherTypes.get());
    }

}
