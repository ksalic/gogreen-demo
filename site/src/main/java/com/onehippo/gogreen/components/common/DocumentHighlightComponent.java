/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.DocumentLink;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.core.request.HstRequestContext;

@ParametersInfo(type = DocumentHighlightComponentParamsInfo.class)
public class DocumentHighlightComponent extends BaseLayout {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        DocumentHighlightComponentParamsInfo paramsInfo = getComponentParametersInfo(request);
        String location = paramsInfo.getDocumentLocation();

        final HippoBean document = ctx.getSiteContentBaseBean().getBean(location);
        if (document == null) {
            return;
        }
        request.setAttribute("document", document);

    }
}

interface DocumentHighlightComponentParamsInfo extends BaseLayoutParamsInfo {
    String PARAM_DOCUMENTLOCATION = "documentlocation";

    @Parameter(name = PARAM_DOCUMENTLOCATION, required = true, displayName = "Document")
    @JcrPath(isRelative = true)
    String getDocumentLocation();
}
