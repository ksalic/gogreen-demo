/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.restapi;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFolderBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;

import com.onehippo.gogreen.beans.RestApi;
import com.onehippo.gogreen.components.BaseComponent;
import com.onehippo.gogreen.exceptions.BeanNotFoundException;

public class RestApiDocumentationList extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        HippoBean bean = ctx.getContentBean();
        if (bean == null) {
            throw new BeanNotFoundException("Cannot create document list: content bean is null");
        } else if (bean.isHippoFolderBean()) {
            HippoFolderBean folder = (HippoFolderBean) bean;
            request.setAttribute("text", folder.getBean("index"));
            request.setAttribute("documents", folder.getDocuments(RestApi.class));
        }
    }

}
