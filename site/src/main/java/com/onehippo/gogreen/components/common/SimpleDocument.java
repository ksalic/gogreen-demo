/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = SimpleDocumentParamsInfo.class)
public class SimpleDocument extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        SimpleDocumentParamsInfo paramsInfo = getComponentParametersInfo(request);
        String location = paramsInfo.getDocumentLocation();

        final HippoBean document = ctx.getSiteContentBaseBean().getBean(location);
        if (document == null) {
            return;
        }
        request.setAttribute("document", document);
    }
}
