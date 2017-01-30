/*
 * Copyright 2017 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.filter;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.apache.commons.io.IOUtils;
import org.apache.wicket.util.string.Strings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Filter that proxies /rss/* requests based on the 'feed' parameter.
 */
public class RssFeedFilter implements Filter {
    private static final Logger log = LoggerFactory.getLogger(RssFeedFilter.class);
    private OkHttpClient client;


    @Override
    public void init(final FilterConfig filterConfig) throws ServletException {
        client = new OkHttpClient();
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
        Response response = null;
        try {
            final Request request = new Request.Builder().url(url).build();
            response = client.newCall(request).execute();
            log.debug("Response code from URL is '{}'", response.code());
            if (response.code() != HttpServletResponse.SC_OK) {
                r.setStatus(response.code());
                return;
            }
            final String result = response.body().string();
            final PrintWriter writer = r.getWriter();
            writer.write(result);
            writer.flush();
            writer.close();
        } catch (Exception e) {
            log.error("Caught " + e.getClass().getName(), e);
            r.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
        } finally {
            IOUtils.closeQuietly(response);
        }
    }

    @Override
    public void destroy() {
    }
}
