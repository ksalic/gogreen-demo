/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = BannerParamsInfo.class)
public class Banner extends BaseLayout {

    public static final Logger log = LoggerFactory.getLogger(Banner.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        BannerParamsInfo paramsInfo = getComponentParametersInfo(request);
        String bannerLocation = paramsInfo.getBannerLocation();
        log.debug("banner location specified in hst is {}", bannerLocation);

        final HippoBean document = ctx.getSiteContentBaseBean().getBean(bannerLocation);

        log.debug("banner document is {}", document);

        if (document == null) {
            return;
        }
        request.setAttribute("document", document);
    }
}
