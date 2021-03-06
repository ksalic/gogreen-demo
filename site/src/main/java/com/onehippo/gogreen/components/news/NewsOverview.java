/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.news;

import java.util.Collections;
import java.util.List;

import com.onehippo.gogreen.beans.NewsItem;
import com.onehippo.gogreen.components.BaseComponent;
import com.onehippo.gogreen.components.ComponentUtil;
import com.onehippo.gogreen.utils.Constants;
import com.onehippo.gogreen.utils.GoGreenUtil;
import com.onehippo.gogreen.utils.PageableCollection;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.HstQueryResult;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.query.filter.BaseFilter;
import org.hippoecm.hst.content.beans.query.filter.Filter;
import org.hippoecm.hst.content.beans.query.filter.PrimaryNodeTypeFilterImpl;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoBeanIterator;
import org.hippoecm.hst.content.beans.standard.HippoDocumentIterator;
import org.hippoecm.hst.content.beans.standard.HippoFacetChildNavigationBean;
import org.hippoecm.hst.content.beans.standard.HippoFacetNavigationBean;
import org.hippoecm.hst.content.beans.standard.HippoResultSetBean;
import org.hippoecm.hst.content.beans.standard.facetnavigation.HippoFacetNavigation;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.request.ResolvedSiteMapItem;
import org.hippoecm.hst.util.ContentBeanUtils;
import org.hippoecm.hst.util.SearchInputParsingUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <p>
 * Fetches matching news items within the scope of the current content bean, ordered descending by date. The news items
 * are put into a {@link PageableCollection} that is available on the request as attribute 'news'.
 * </p>
 * <p>
 * The following news items are fetched:
 * </p>
 * <ol>
 * <li>If a tag is selected, the news items related to that tag.</li>
 * <li>If one or more facets are selected, all news items matching these facets. The facets are combined
 * with the free text search in the public request parameter 'query'.</li>
 * <li>Otherwise, all available news items.</li>
 * </ol>
 * <em>Component parameters:</em>
 * <ul>
 * <li>pageSize: the number of news items per page</li>
 * <li>
 * <em>Public request parameters:</em>
 * <ul>
 * <li>pageNumber: the page to show</li>
  *<li>query: the free text to combine with the facets to limit the fetched news items.</li>
 * </ul>
 */
public class NewsOverview extends BaseComponent {

    public static final Logger log = LoggerFactory.getLogger(NewsOverview.class);

    private static final int DEFAULT_PAGE_SIZE = 5;
    private static final String PARAM_CURRENT_PAGE = "pageNumber";
    private static final int DEFAULT_CURRENT_PAGE = 1;

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        HippoBean scope = ctx.getContentBean();
        if (scope == null) {
            ResolvedSiteMapItem resolvedSiteMapItem = request.getRequestContext().getResolvedSiteMapItem();
            log.warn("Scope bean not found; please check the relative content path for sitemap item: {}. Relative content path: {}.",
                    resolvedSiteMapItem.getHstSiteMapItem().getId(),
                    resolvedSiteMapItem.getRelativeContentPath());
            return;
        }

        HippoBean facet = null;
        if (scope instanceof HippoFacetChildNavigationBean || scope instanceof HippoFacetNavigation) {
            facet = scope;
        }

        String defaultScope = getComponentParameter("scope");
        HippoBean folderBean = ctx.getSiteContentBaseBean();
        if (defaultScope  != null) {
            folderBean = folderBean.getBean(defaultScope);
            if (folderBean == null) {
                log.warn("Scope not found: '{}'", defaultScope);
                return;
            } else {
                scope = folderBean;
            }
        }

        int pageSize = GoGreenUtil.getIntConfigurationParameter(request, Constants.PAGE_SIZE, DEFAULT_PAGE_SIZE);

        String currentPageParam = getPublicRequestParameter(request, PARAM_CURRENT_PAGE);
        int currentPage = ComponentUtil.parseIntParameter(PARAM_CURRENT_PAGE, currentPageParam, DEFAULT_CURRENT_PAGE, log);

        String query = this.getPublicRequestParameter(request, "query");
        query = SearchInputParsingUtils.parse(query, false);
        request.setAttribute("query", StringEscapeUtils.escapeHtml(query));

        try {
            final PageableCollection news = getNews(request, scope, facet, pageSize, currentPage, query);
            request.setAttribute("news", news);

        } catch (QueryException e) {
            throw new HstComponentException("Query error while getting news: " + e.getMessage(), e);
        }
    }

    private PageableCollection getNews(HstRequest request, HippoBean scope, HippoBean facet, int pageSize, int currentPage, String query) throws QueryException {

        final HstRequestContext ctx = request.getRequestContext();
        final HstQuery hstQuery = ctx.getQueryManager().createQuery(scope, NewsItem.class);
        final BaseFilter filter = new PrimaryNodeTypeFilterImpl("hippogogreen:newsitem");
        hstQuery.setFilter(filter);
        hstQuery.addOrderByDescending("hippogogreen:date");

        if (!StringUtils.isEmpty(query)) {
            final Filter f = hstQuery.createFilter();
            final Filter f1 = hstQuery.createFilter();
            f1.addContains(".", query);
            final Filter f2 = hstQuery.createFilter();
            f2.addContains("hippogogreen:title", query);
            f.addOrFilter(f1);
            f.addOrFilter(f2);
            hstQuery.setFilter(f);
        }

        if (facet instanceof HippoFacetChildNavigationBean || facet instanceof HippoFacetNavigation) {
            // only show faceted news items
            final HippoFacetNavigationBean facetBean = ContentBeanUtils.getFacetNavigationBean(hstQuery);

            if (facetBean == null) {
                final List<HippoBean> noResults = Collections.emptyList();
                return new PageableCollection(0, noResults);
            } else {
                final HippoResultSetBean resultSet = facetBean.getResultSet();
                final HippoDocumentIterator<NewsItem> facetIt = resultSet.getDocumentIterator(NewsItem.class);
                if (hstQuery.getOffset() > 0) {
                    facetIt.skip(hstQuery.getOffset());
                }
                final int facetCount = facetBean.getCount().intValue();
                return new PageableCollection(facetIt, facetCount, pageSize, currentPage);
            }
        }

        // show all news items
        final HstQueryResult result = hstQuery.execute();
        final HippoBeanIterator iterator = result.getHippoBeans();
        return new PageableCollection<NewsItem>(iterator, pageSize, currentPage);
    }


}
