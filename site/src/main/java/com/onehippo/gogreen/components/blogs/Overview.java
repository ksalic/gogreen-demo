/*
 * Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.blogs;

import com.onehippo.gogreen.beans.BlogItem;
import com.onehippo.gogreen.beans.BlogItemContentBlocks;
import com.onehippo.gogreen.beans.Comment;
import com.onehippo.gogreen.components.ComponentUtil;
import com.onehippo.gogreen.components.TagComponent;
import com.onehippo.gogreen.utils.Constants;
import com.onehippo.gogreen.utils.GoGreenUtil;
import com.onehippo.gogreen.utils.PageableCollection;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.HstQueryResult;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.query.filter.Filter;
import org.hippoecm.hst.content.beans.standard.*;
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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 * Fetches matching blog items within the scope of the current content bean, ordered descending by date. The blog items
 * are put into a {@link PageableCollection} that is available on the request as attribute 'blogs'.
 * </p>
 * <p>
 * The following blog items are fetched:
 * </p>
 * <ol>
 * <li>If a tag is selected, the blog items related to that tag.</li>
 * <li>If one or more facets are selected, all blog items matching these facets. The facets are combined
 * with the free text search in the public request parameter 'query'.</li>
 * <li>Otherwise, all available blog items.</li>
 * </ol>
 * <p>
 * For each blog items on the current page, the number of comments is determined. These counts are put in a list
 * in the same order as the blog items, and put on the request as attribute 'commentsCountList'.
 * </p>
 * <em>Component parameters:</em>
 * <ul>
 * <li>pageSize: the number of blog items per page</li>
 * <li>
 * <em>Public request parameters:</em>
 * <ul>
 * <li>pageNumber: the page to show</li>
 * <li>query: the free text to combine with the facets to limit the fetched blog items.</li>
 * </ul>
 */
public class Overview extends TagComponent {

    public static final Logger log = LoggerFactory.getLogger(Overview.class);

    private static final int DEFAULT_PAGE_SIZE = 5;
    private static final String PARAM_CURRENT_PAGE = "pageNumber";
    private static final int DEFAULT_CURRENT_PAGE = 1;

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        final HippoBean scope = ctx.getContentBean();
        if (scope == null) {
            ResolvedSiteMapItem resolvedSiteMapItem = request.getRequestContext().getResolvedSiteMapItem();
            log.warn("Scope bean not found; please check the relative content path for sitemap item: {}. Relative content path: {}.",
                    resolvedSiteMapItem.getHstSiteMapItem().getId(),
                    resolvedSiteMapItem.getRelativeContentPath());
            return;
        }

        int pageSize = GoGreenUtil.getIntConfigurationParameter(request, Constants.PAGE_SIZE, DEFAULT_PAGE_SIZE);

        String currentPageParam = getPublicRequestParameter(request, PARAM_CURRENT_PAGE);
        int currentPage = ComponentUtil.parseIntParameter(PARAM_CURRENT_PAGE, currentPageParam, DEFAULT_CURRENT_PAGE, log);

        String query = this.getPublicRequestParameter(request, "query");
        query = SearchInputParsingUtils.parse(query, false);
        request.setAttribute("query", StringEscapeUtils.escapeHtml(query));

        try {
            final PageableCollection blogs = getBlogs(request, scope, pageSize, currentPage, query);
            request.setAttribute("blogs", blogs);

            updateCommentsCount(request, blogs);
        } catch (QueryException e) {
            throw new HstComponentException("Query error while getting blogs: " + e.getMessage(), e);
        }
    }

    private PageableCollection getBlogs(HstRequest request, HippoBean scope, int pageSize, int currentPage, String query) throws QueryException {
        List<? extends HippoBean> relatedBeans = getRelatedBeans(request);

        if (!relatedBeans.isEmpty()) {
            // only show tagged blogs items
            return new PageableCollection(relatedBeans, pageSize, currentPage);
        }
        final HstRequestContext ctx = request.getRequestContext();
        final HstQuery hstQuery = ctx.getQueryManager().createQuery(ctx.getSiteContentBaseBean(), BlogItem.class, BlogItemContentBlocks.class);

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

        if (scope instanceof HippoFacetChildNavigationBean || scope instanceof HippoFacetNavigation) {
            // only show faceted blogs items
            final HippoFacetNavigationBean facetBean = ContentBeanUtils.getFacetNavigationBean(hstQuery);

            if (facetBean == null) {
                final List<HippoBean> noResults = Collections.emptyList();
                return new PageableCollection(0, noResults);
            } else {
                final HippoResultSetBean resultSet = facetBean.getResultSet();
                final HippoDocumentIterator<BlogItem> facetIt = resultSet.getDocumentIterator(BlogItem.class);
                if (hstQuery.getOffset() > 0) {
                    facetIt.skip(hstQuery.getOffset());
                }
                final int facetCount = facetBean.getCount().intValue();
                return new PageableCollection(facetIt, facetCount, pageSize, currentPage);
            }
        } else {
            // show all blogs items
            final HstQueryResult result = hstQuery.execute();
            final HippoBeanIterator iterator = result.getHippoBeans();
            return new PageableCollection<BlogItem>(iterator, pageSize, currentPage);
        }
    }

    private void updateCommentsCount(HstRequest request, PageableCollection blogs) throws QueryException {
        List<Integer> commentCount = new ArrayList<>();
        final HstRequestContext ctx = request.getRequestContext();
        HippoBean siteContentBase = ctx.getSiteContentBaseBean();

        if (siteContentBase == null) {
            log.warn("Site content base bean is not found: {}", ctx.getSiteContentBaseBean());
            return;
        }

        HippoFolder blogsCommentFolder = siteContentBase.getBean("comments/blogs");

        if (blogsCommentFolder == null) {
            log.warn("Blogs comment folder is not found: {}/comments/blogs. So it fails to update comments count", siteContentBase.getPath());
            return;
        }

        for (Object blogItem : blogs.getItems()) {
            final HstQuery incomingBeansQuery = ContentBeanUtils.createIncomingBeansQuery((HippoDocumentBean) blogItem, blogsCommentFolder, 4, Comment.class, false);
            commentCount.add(incomingBeansQuery.execute().getSize());

        }
        request.setAttribute("commentsCountList", commentCount);

    }


}
