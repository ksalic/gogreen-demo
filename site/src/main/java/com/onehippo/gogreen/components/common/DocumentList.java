/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import java.util.List;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoDocumentBean;
import org.hippoecm.hst.content.beans.standard.HippoFolderBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.request.ResolvedSiteMapItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.onehippo.gogreen.components.BaseComponent;
import com.onehippo.gogreen.exceptions.BeanTypeException;

public class DocumentList extends BaseComponent {

    private static final Logger log = LoggerFactory.getLogger(DocumentList.class);
    
    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        
        HippoBean bean = ctx.getContentBean();
        
        if (bean == null) {
            ResolvedSiteMapItem resolvedSiteMapItem = request.getRequestContext().getResolvedSiteMapItem();
            log.warn("Cannot create document list: content bean not found; please check the relative content path for sitemap item: {}. Relative content path: {}.", 
                    resolvedSiteMapItem.getHstSiteMapItem().getId(),
                    resolvedSiteMapItem.getRelativeContentPath());
            return;
        } else if (bean instanceof HippoFolderBean) {
            HippoFolderBean folder = (HippoFolderBean) bean;
            List<HippoDocumentBean> documents = folder.getDocuments();
            request.setAttribute("documents", documents);
        } else {
            throw new BeanTypeException("Cannot create document list: " + bean.getPath() + " is not a folder");
        }
    }

}
