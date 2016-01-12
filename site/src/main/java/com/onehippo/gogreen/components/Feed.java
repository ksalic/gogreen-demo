/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components;

import com.onehippo.gogreen.components.common.BaseLayout;
import com.onehippo.gogreen.utils.FeedFetcher;
import com.sun.syndication.feed.synd.SyndFeed;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;

@ParametersInfo(type = FeedParamsInfo.class)
public class Feed extends BaseLayout {

    private static final FeedFetcher feedFetcher = new FeedFetcher();

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        // get parameters
        FeedParamsInfo paramsInfo = getComponentParametersInfo(request);
        request.setAttribute("numberOfItems", paramsInfo.getNumberOfItems());

        String feedUrl = paramsInfo.getFeedUrl();
        int updateInterval = paramsInfo.getUpdateInterval();
        int connectTimeout = paramsInfo.getConnectTimeout();
        int readTimeout = paramsInfo.getReadTimeout();

        // get feed
        SyndFeed feed = feedFetcher.retrieveFeed(feedUrl, updateInterval, connectTimeout, readTimeout);
        request.setAttribute("feed", feed);
        request.setAttribute("feedUrl", feedUrl);
    }

}
