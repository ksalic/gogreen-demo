/*
 * Copyright 2016 Hippo B.V. (http://www.onehippo.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.onehippo.gogreen.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.google.common.base.Splitter;
import com.google.common.base.Strings;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class AccessFilter implements Filter {

    private static final Logger log = LoggerFactory.getLogger(AccessFilter.class);
    private static final Splitter COMMA_SPLITTER = Splitter.on(',').trimResults().omitEmptyStrings();
    private Collection<IpMatcher> configuration;

    @Override
    public void init(final FilterConfig filterConfig) throws ServletException {
        configuration = new ArrayList<>();
        final String parameter = filterConfig.getInitParameter("allowed-ip-ranges");
        if (!Strings.isNullOrEmpty(parameter)) {
            final Iterable<String> ranges = COMMA_SPLITTER.split(parameter);
            for (String range : ranges) {
                configuration.add(IpMatcher.valueOf(range));
            }
        }
    }

    @Override
    public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) throws IOException, ServletException {
        if (allowed((HttpServletRequest)request)) {
            chain.doFilter(request, response);
            return;
        }
        final HttpServletResponse resp = (HttpServletResponse)response;
        resp.sendRedirect("/");

    }

    private boolean allowed(final HttpServletRequest request) {
        final String ip = getIp(request);
        if (Strings.isNullOrEmpty(ip)) {
            return false;
        }
        log.debug("IP found for '{}': {}", request.getPathInfo(), ip);
        final Iterator<IpMatcher> i = configuration.iterator();
        try {
            while (i.hasNext()) {
                final IpMatcher ipMatcher = i.next();
                boolean match = ipMatcher.matches(ip);
                if (match) {
                    log.debug("IP {} matching rule {}", ip, ipMatcher);
                    return true;
                } else {
                    log.trace("IP {} NOT matching rule {}", ip, ipMatcher);
                }
            }
        } catch (IllegalArgumentException e) {
            log.warn("Invalid IP address: {}", ip);
        }

        return false;
    }

    @Override
    public void destroy() {

    }

    private static String getIp(HttpServletRequest request) {
        if (request != null) {
            final String header = request.getHeader("X-Forwarded-For");
            if (Strings.isNullOrEmpty(header)) {
                return request.getRemoteAddr();
            }
            final Iterable<String> ipAddresses = COMMA_SPLITTER.split(header);
            final Iterator<String> iterator = ipAddresses.iterator();
            if (iterator.hasNext()) {
                return iterator.next();
            }
            return request.getRemoteAddr();
        }
        return null;
    }

}
