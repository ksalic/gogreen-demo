/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;

public class ErrorComponent extends BaseComponent{

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        // set 404 status
        response.setStatus(HstResponse.SC_NOT_FOUND);
    }

}
