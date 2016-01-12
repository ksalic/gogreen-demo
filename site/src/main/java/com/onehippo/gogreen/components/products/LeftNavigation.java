/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.products;

import org.hippoecm.hst.content.beans.standard.facetnavigation.HippoFacetsAvailableNavigation;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;

import com.onehippo.gogreen.components.BaseComponent;
import com.onehippo.gogreen.exceptions.ComponentParameterNotFoundException;

public class LeftNavigation extends BaseComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        final HstRequestContext ctx = request.getRequestContext();
        String facetLocation = getComponentParameter("facet.location");
        if (facetLocation == null) {
            throw new ComponentParameterNotFoundException("Please configure the 'facet.location' parameter on productleftnav component");
        }

        HippoFacetsAvailableNavigation facetNavigation = ctx.getSiteContentBaseBean().getBean(facetLocation, HippoFacetsAvailableNavigation.class);
        if (facetNavigation != null) {
            request.setAttribute("facets", facetNavigation.getFolders());
        }
    }
}
