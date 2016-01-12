/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components;

import java.util.List;

import com.onehippo.gogreen.exceptions.BeanNotFoundException;
import com.onehippo.gogreen.utils.RepoSiteMenuItem;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoDocumentBean;
import org.hippoecm.hst.content.beans.standard.HippoFolderBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;

public class AboutList extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        
        HippoBean bean = ctx.getContentBean();;
        
        if (bean == null) {
            redirectToNotFoundPage(response);
            throw new BeanNotFoundException("Cannot create document list: content bean is null");
        } else if (bean.isHippoDocumentBean()) {
            request.setAttribute("document", bean);
        } else if (bean.isHippoFolderBean()) {
            HippoFolderBean folder = (HippoFolderBean) bean;
            List<HippoDocumentBean> documents = folder.getDocuments();
            
            if (documents.size() == 1) {
                request.setAttribute("document", documents.get(0));
            } else {
                String folderName = RepoSiteMenuItem.retrieveLocalizedName(folder);
                request.setAttribute("folderName", folderName);
                request.setAttribute("documents", documents);
            }
        }
    }

}
