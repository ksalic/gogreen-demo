/**
 * Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.targeting;

import com.onehippo.cms7.targeting.frontend.BaseVisitorDetailsPanel;

import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.wicketstuff.js.ext.util.ExtClass;

/**
 * Custom visitor details panel in the real-time visitor analysis tab of the experience optimizer perspective.
 * The panel shows all default components, but adds two charts for the characteristics 'documenttype' and 'categories'.
 */
@ExtClass("Hippo.Hgge.VisitorDetailsPanel")
public class VisitorDetailsPanel extends BaseVisitorDetailsPanel {

    private static final JavaScriptResourceReference JS = new JavaScriptResourceReference(VisitorDetailsPanel.class, "VisitorDetailsPanel.js");

    public VisitorDetailsPanel(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    public void renderHead(final Component component, final IHeaderResponse response) {
        super.renderHead(component, response);

        response.render(JavaScriptHeaderItem.forReference(JS));
    }
}
