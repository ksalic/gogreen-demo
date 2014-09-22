package com.onehippo.gogreen.components;

import org.hippoecm.hst.configuration.components.HstComponentConfiguration;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.utils.ParameterUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ContainerLatestComponent extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        request.setAttribute("preview", isPreview(request));
        request.setAttribute("composermode", request.getRequestContext().getResolvedMount().getMount().isOfType("composermode"));

        /*Map<String, HstComponentConfiguration> childComponents = request.getRequestContext().getResolvedSiteMapItem().
                getHstComponentConfiguration().getChildByName("main").getChildByName("home-latest").getChildren();
        List<String> titles = new ArrayList<String>();

        if (childComponents != null) {
            for (Map.Entry<String, HstComponentConfiguration> childComponent : childComponents.entrySet()) {
                String title = childComponent.getValue().getParameter("title");
                if (title != null) {
                    titles.add(title);
                }
            }
        }


        request.setAttribute("titles", titles);*/

    }

}
