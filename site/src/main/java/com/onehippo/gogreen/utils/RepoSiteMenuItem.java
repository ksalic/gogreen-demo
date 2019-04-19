/**
 * Copyright 2010-2019 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.utils;

import java.util.List;

import javax.jcr.Node;
import javax.jcr.RepositoryException;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFolderBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.linking.HstLinkCreator;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.sitemenu.EditableMenuItem;
import org.hippoecm.hst.core.sitemenu.EditableMenuItemImpl;
import org.hippoecm.repository.api.HippoNode;

public class RepoSiteMenuItem extends EditableMenuItemImpl {

    private int childCount;
    
    public RepoSiteMenuItem(HippoFolderBean folder, EditableMenuItem parent, HstRequest request,
            HippoBean currentContentBean) {
        super(parent);

        name = folder.getDisplayName();
        depth = parent.getDepth() - 1;
        repositoryBased = true;
        properties = folder.getProperties();

        HstRequestContext requestContext = request.getRequestContext();
        HstLinkCreator linkCreator = requestContext.getHstLinkCreator();
        hstLink = linkCreator.create(folder, requestContext);

        if (currentContentBean != null) {
            if (folder.isAncestor(currentContentBean)) {
                expanded = true;
            }
            if (folder.isSelf(currentContentBean)) {
                expanded = true;
                selected = true;
                getEditableMenu().setSelectedMenuItem(this);
            }
        }

        List<HippoFolderBean> childFolders = folder.getFolders();
        childCount = folder.getDocumentSize() + childFolders.size();

        if (depth > 0 && expanded) {
            for (HippoFolderBean childFolder : childFolders) {
                RepoSiteMenuItem childMenuItem = new RepoSiteMenuItem(childFolder, this, request, currentContentBean);
                if (childMenuItem.getChildCount() > 0) {
                    addChildMenuItem(childMenuItem);
                }
            }
        }
    }

    public int getChildCount() {
        return childCount;
    }

}
