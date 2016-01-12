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

@ParametersInfo(type = RichTextSnippetParamsInfo.class)
public class RichTextSnippet extends BaseComponent {

    public static final Logger log = LoggerFactory.getLogger(RichTextSnippet.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        RichTextSnippetParamsInfo paramsInfo = getComponentParametersInfo(request);

        String bannerLocation = paramsInfo.getSnippetLocation();

        log.debug("snippet location specified in hst is " + bannerLocation);

        final HippoBean document = ctx.getSiteContentBaseBean().getBean(bannerLocation);

        log.debug("snippet document is " + document);

        if (document == null) {
            return;
        }
        request.setAttribute("document", document);
    }
}
