/*
 * Copyright 2017 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.filter;

import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.SyndFeedOutput;
import com.sun.syndication.io.XmlReader;

import org.apache.wicket.util.string.Strings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;

/**
 * Filter that proxies /rss/* requests based on the 'feed' parameter.
 */
public class RssFeedFilter implements Filter {
    private static final Logger log = LoggerFactory.getLogger(RssFeedFilter.class);


    @Override
    public void init(final FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(final ServletRequest req, final ServletResponse resp, final FilterChain chain) throws IOException, ServletException {
        HttpServletResponse r = (HttpServletResponse) resp;
        final String url = req.getParameter("feed");

        log.debug("Request 'feed' parameter is URL '{}'", url);
        if (Strings.isEmpty(url)) {
            r.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        try {

            // make sure we only fetch XML RSS feeds (to avoid phishing-alike attempts)
            final SyndFeedInput feedInput = new SyndFeedInput();
            final SyndFeed feed = feedInput.build(new XmlReader(new URL(url)));
            if (feed.getEntries() == null || feed.getEntries().size() < 1) {
                log.warn("No entries from URL '{}'", url);
                r.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            final PrintWriter writer = r.getWriter();
            writer.write(new SyndFeedOutput().outputString(feed));
            writer.flush();
            writer.close();
        } catch (Exception e) {
            log.error("Caught " + e.getClass().getName(), e);
            r.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
        }
    }

    @Override
    public void destroy() {
    }
}
