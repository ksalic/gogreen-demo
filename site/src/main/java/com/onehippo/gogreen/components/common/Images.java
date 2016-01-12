/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;


import com.onehippo.gogreen.beans.Document;

import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.core.request.HstRequestContext;

import java.util.ArrayList;
import java.util.List;

/**
 * Images component for Home Page
 */
@ParametersInfo(type = ImagesParamsInfo.class)
public class Images extends BaseLayout {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        ImagesParamsInfo paramsInfo = getComponentParametersInfo(request);
        List<Document> images = new ArrayList<Document>();
        HippoBean siteContentBaseBean = ctx.getSiteContentBaseBean();

        if(!StringUtils.isEmpty(paramsInfo.getImage1())) {
            Document image = siteContentBaseBean.getBean(paramsInfo.getImage1());
            if(image != null) {
                images.add(image);
            }
        }
        if(!StringUtils.isEmpty(paramsInfo.getImage2())) {
            Document image = siteContentBaseBean.getBean(paramsInfo.getImage2());
            if(image != null) {
                images.add(image);
            }
        }
        if(!StringUtils.isEmpty(paramsInfo.getImage3())) {
            Document image = siteContentBaseBean.getBean(paramsInfo.getImage3());
            if(image != null) {
                images.add(image);
            }
        }
        if(!StringUtils.isEmpty(paramsInfo.getImage4())) {
            Document image = siteContentBaseBean.getBean(paramsInfo.getImage4());
            if(image != null) {
                images.add(image);
            }
        }
        if(!StringUtils.isEmpty(paramsInfo.getImage5())) {
            Document image = siteContentBaseBean.getBean(paramsInfo.getImage5());
            if(image != null) {
                images.add(image);
            }
        }

        request.setAttribute("images", images);
    }
}
