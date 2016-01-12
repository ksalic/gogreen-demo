/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.onehippo.forge.tcmp.beans.TagCloudBean;
import org.onehippo.forge.tcmp.model.TagCloud;

/**
 * This component puts tagcloud information on the request.
 */
@ParametersInfo(type = TagcloudParamsInfo.class)
public class TagCloudComponent extends org.onehippo.forge.tcmp.hst.TagCloudComponent {

    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        TagcloudParamsInfo paramsInfo = getComponentParametersInfo(request);
        String tagCloudLocation = paramsInfo.getTagcloudLocation();
        TagCloudBean bean;

        if (tagCloudLocation != null && StringUtils.isNotBlank(tagCloudLocation)) {
        	 bean = getBean(tagCloudLocation, request);
        } else {
        	bean = getTagCloudBean(request);
        	response.setContentType("text/xml");
        }

        if (bean == null) {
            return;
        }

        TagCloud tagCloud = new TagCloud(bean, request);

        request.setAttribute("tagcloud", tagCloud);
	}

}
