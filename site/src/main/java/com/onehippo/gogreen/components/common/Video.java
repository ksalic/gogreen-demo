/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = VideoParamsInfo.class)
public class Video extends BaseLayout {

    public static final Logger log = LoggerFactory.getLogger(Video.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        VideoParamsInfo paramsInfo = getComponentParametersInfo(request);
        String videoURL = paramsInfo.getVideoURL();
        log.debug("Video URL specified in hst is " + videoURL);

        request.setAttribute("videoURL", videoURL);
    }
}
