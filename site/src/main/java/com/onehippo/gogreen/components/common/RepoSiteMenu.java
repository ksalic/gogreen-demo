/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoFolderBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.request.ResolvedSiteMapItem;
import org.hippoecm.hst.core.sitemenu.EditableMenu;
import org.hippoecm.hst.core.sitemenu.EditableMenuItem;
import org.hippoecm.hst.core.sitemenu.HstSiteMenu;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.onehippo.gogreen.components.BaseComponent;
import com.onehippo.gogreen.exceptions.MenuNotFoundException;
import com.onehippo.gogreen.utils.GoGreenUtil;
import com.onehippo.gogreen.utils.RepoSiteMenuItem;

public class RepoSiteMenu extends BaseComponent {

    public static final Logger LOGGER = LoggerFactory.getLogger(RepoSiteMenu.class);
    
    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        
        String siteMenuName = GoGreenUtil.getSiteMenuName(this, request);
        
        HstSiteMenu menu = request.getRequestContext().getHstSiteMenus().getSiteMenu(siteMenuName);
        
        if (menu != null) {
            EditableMenu editableMenu = menu.getEditableMenu();
            addRepoBasedMenuItems(editableMenu, request);
            request.setAttribute("menu", editableMenu);
        } else {
            throw new MenuNotFoundException("Unknown site menu: " + siteMenuName);
        }
    }

    private void addRepoBasedMenuItems(EditableMenu editable, HstRequest request) {
        final HstRequestContext ctx = request.getRequestContext();
        EditableMenuItem item = editable.getDeepestExpandedItem();
        
        if (item != null && item.isRepositoryBased() && item.getDepth() > 0) {
            ResolvedSiteMapItem resolved = item.resolveToSiteMapItem();
            HippoBean rootMenuBean = getBeanForResolvedSiteMapItem(request, resolved);
   
            if (rootMenuBean != null && rootMenuBean.isHippoFolderBean()) {
                HippoFolderBean rootFolder = (HippoFolderBean) rootMenuBean;
                
                for (HippoFolderBean childFolder : rootFolder.getFolders()) {
                    HippoBean contentBean = ctx.getContentBean();
                    RepoSiteMenuItem repoMenuItem = new RepoSiteMenuItem(childFolder, item, request, contentBean);
                    if (repoMenuItem.getChildCount() > 0) {
                        item.addChildMenuItem(repoMenuItem);
                    }
                }
            }
        }
    }

}
