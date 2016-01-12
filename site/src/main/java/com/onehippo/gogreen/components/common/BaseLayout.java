/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;

/**
 * Header/title component for Home Page
 */
@ParametersInfo(type = BaseLayoutParamsInfo.class)
public class BaseLayout extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        BaseLayoutParamsInfo paramsInfo = getComponentParametersInfo(request);

        request.setAttribute("title", paramsInfo.getTitle());
        request.setAttribute("icon", paramsInfo.getIcon());

        request.setAttribute("separatorMargin", paramsInfo.getSeparatorMargin());
        request.setAttribute("separatorBorderTop", paramsInfo.getSeparatorBorderTop());
        request.setAttribute("separatorBorderBottom", paramsInfo.getSeparatorBorderBottom());
    }
}
