/*
 * Copyright 2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.blogs;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.onehippo.gogreen.components.Detail;

import org.hippoecm.hst.content.beans.standard.facetnavigation.HippoFacetNavigation;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JobDetail extends Detail {

    public static final Logger log = LoggerFactory.getLogger(JobDetail.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {

        super.doBeforeRender(request, response);
        HippoFacetNavigation facnav = ((HippoFacetNavigation)request.getRequestContext().getSiteContentBaseBean().getBean("jobfacets"));
        List<String> facets = new ArrayList<String>();
        String[] facetArray = facnav.getMultipleProperty("hippofacnav:facets");
        Collections.addAll(facets, facetArray);
        int employerIndex = facets.indexOf("hippogogreen:employer");

        if(employerIndex >= 0 && employerIndex < ((String[])facnav.getMultipleProperty("hippofacnav:facetnodenames")).length) {
            request.setAttribute("employer", ((String[])facnav.getMultipleProperty("hippofacnav:facetnodenames"))[employerIndex]);
        }
        else {
            log.warn("Error occurred during fetching of employer facet translation");
        }

    }
}
