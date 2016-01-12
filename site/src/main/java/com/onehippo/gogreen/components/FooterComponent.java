/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;

public class FooterComponent extends BaseComponent {

    private static final String TERMS_PATH = "termsPath";
    
    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        
        String termsPath = getComponentParameter(TERMS_PATH);
        request.setAttribute("termsPath", termsPath);
    }

}
