/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.restapi;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.onehippo.gogreen.beans.RestApi;
import com.onehippo.gogreen.components.BaseComponent;

public class RestApiDetail extends BaseComponent {
    public static final Logger LOGGER = LoggerFactory.getLogger(RestApiDetail.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {

        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        RestApi document = (RestApi) ctx.getContentBean();

        if (document == null) {
            return;
        }
        request.setAttribute("document", document);

    }

}
