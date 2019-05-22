/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components;

import java.io.IOException;

import org.hippoecm.hst.component.support.bean.BaseHstComponent;
import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;

public class BaseComponent extends BaseHstComponent {

    protected static final String REQUEST_ATTR_CMS_EDIT = "editMode"; // CMS edit mode

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        setEditMode(request);

        request.setAttribute("preview", isPreview(request));
        request.setAttribute("loggedin", request.getUserPrincipal() != null);
    }
    
    protected void redirectToNotFoundPage(HstResponse response) {
        try {
            response.forward("/404");
        } catch (IOException e) {
            throw new HstComponentException(e);
        }
    }

    protected void setEditMode(final HstRequest request) {
        request.setAttribute(REQUEST_ATTR_CMS_EDIT, RequestContextProvider.get().isChannelManagerPreviewRequest());
    }
}
