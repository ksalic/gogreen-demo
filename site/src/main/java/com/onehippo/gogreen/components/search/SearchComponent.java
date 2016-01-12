/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.search;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;

public class SearchComponent extends AbstractSearchComponent {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        if (!showTaggedDocuments(request) && !showFacetedDocuments(request)) {
            String query = getQuery(request);
            searchDocuments(request, query);
        }
    }
}
