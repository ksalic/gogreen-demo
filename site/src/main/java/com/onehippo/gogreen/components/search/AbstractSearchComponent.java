/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.search;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.onehippo.gogreen.beans.*;
import com.onehippo.gogreen.beans.BlogItem;
import com.onehippo.gogreen.components.BaseComponent;
import com.onehippo.gogreen.components.ComponentUtil;
import com.onehippo.gogreen.utils.Constants;
import com.onehippo.gogreen.utils.PageableCollection;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.HstQueryManager;
import org.hippoecm.hst.content.beans.query.HstQueryResult;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.query.filter.Filter;
import org.hippoecm.hst.content.beans.standard.HippoAsset;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoBeanIterator;
import org.hippoecm.hst.content.beans.standard.HippoDocumentIterator;
import org.hippoecm.hst.content.beans.standard.HippoFacetChildNavigationBean;
import org.hippoecm.hst.content.beans.standard.HippoFacetNavigationBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.util.ContentBeanUtils;
import org.hippoecm.hst.util.SearchInputParsingUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AbstractSearchComponent extends BaseComponent {

    private static final String PARAM_QUERY = "query";

    private static final Logger log = LoggerFactory.getLogger(AbstractSearchComponent.class);

    /**
     * 
     * @param request
     * @return the not yet parsed request parameter 'query' and <code>null</code> if there was no such parameter
     */
    protected String getQuery(HstRequest request) {
        return getPublicRequestParameter(request, PARAM_QUERY);
    }

    protected int getPageSize(HstRequest request) {
        String pageSizeParam = getComponentParameter(Constants.PAGE_SIZE);
        return ComponentUtil.parseIntParameter(Constants.PAGE_SIZE, pageSizeParam, Constants.DEFAULT_PAGE_SIZE, log);
    }

    protected int getCurrentPage(HstRequest request) {
        String currentPageParam = getPublicRequestParameter(request, Constants.PAGE);
        return ComponentUtil.parseIntParameter(Constants.PAGE, currentPageParam, Constants.DEFAULT_PAGE_NUMBER, log);
    }

    protected void searchDocuments(final HstRequest request,final String query) {

        final HstRequestContext ctx = request.getRequestContext();
        String parsedQuery = SearchInputParsingUtils.parse(query,false);
        
        request.setAttribute("query", StringEscapeUtils.escapeHtml(parsedQuery));
        HippoBean scope = ctx.getSiteContentBaseBean();
        if (scope == null) {
            log.error("Scope for search is null");
            return;
        }

        try {
            HstQueryManager manager = ctx.getQueryManager();

            @SuppressWarnings("unchecked")
            HstQuery hstQuery = manager.createQuery(scope, EventDocument.class, BlogItem.class, NewsItem.class,
                    Product.class, HippoAsset.class, SimpleDocument.class, Faq.class);

            HippoBean assetScope = getAssetBaseBean(request);
            hstQuery.addScopes(Collections.singletonList(assetScope));

            if (!StringUtils.isEmpty(parsedQuery)) {
                Filter filter = hstQuery.createFilter();
                hstQuery.setFilter(filter);
                // title field
                Filter titleFilter = hstQuery.createFilter();
                titleFilter.addContains("@hippogogreen:title", parsedQuery);
                // summary field
                Filter summaryFilter = hstQuery.createFilter();
                summaryFilter.addContains("@hippogogreen:summary", parsedQuery);
                // full text
                Filter fullTextFilter = hstQuery.createFilter();
                fullTextFilter.addContains(".", parsedQuery);

                filter.addOrFilter(titleFilter);
                filter.addOrFilter(summaryFilter);
                filter.addOrFilter(fullTextFilter);

                hstQuery.addOrderByDescending("hippogogreen:rating");
            }else{
                hstQuery.addOrderByDescending("hippogogreen:title");
            }
            HstQueryResult result = hstQuery.execute();

            HippoBeanIterator beans = result.getHippoBeans();

            int pageSize = getPageSize(request);
            int currentPage = getCurrentPage(request);

            PageableCollection<HippoBean> results = new PageableCollection<HippoBean>(beans, pageSize, currentPage);
            HstRequestContext requestContext = request.getRequestContext();
            boolean searchHasResults = result.getSize()>0?true:false;
            requestContext.setAttribute("searchHasResults",searchHasResults);
            request.setAttribute("searchResult", results);
        } catch (QueryException e) {
            if(log.isDebugEnabled()) {
                log.warn("Error during search: ", e);
            } else {
                log.warn("Error during search: ", e.getMessage());
            }
        }
    }

    protected boolean showFacetedDocuments(HstRequest request) {
        final HstRequestContext ctx = request.getRequestContext();
        HippoBean bean = ctx.getContentBean();
        if (bean instanceof HippoFacetChildNavigationBean) {
            String query = SearchInputParsingUtils.parse(getQuery(request), false);
            HippoFacetNavigationBean facetBean = ContentBeanUtils.getFacetNavigationBean(query);
            HippoDocumentIterator<HippoBean> facetIt = facetBean.getResultSet().getDocumentIterator(HippoBean.class);
            int facetCount = facetBean.getCount().intValue();
            int pageSize = getPageSize(request);
            int currentPage = getCurrentPage(request);
            PageableCollection<HippoBean> results = new PageableCollection<HippoBean>(facetIt, facetCount,
                    pageSize, currentPage);
            request.setAttribute("searchResult", results);
            request.setAttribute("query", StringEscapeUtils.escapeHtml(query));
            HstRequestContext requestContext = request.getRequestContext();
            boolean searchHasResults = true;
            requestContext.setAttribute("searchHasResults",searchHasResults);
            return true;
        } else {
            return false;
        }
    }

}
