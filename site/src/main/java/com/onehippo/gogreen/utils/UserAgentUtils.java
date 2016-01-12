/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

/**
 * UserAgentUtils
 * @version $Id$
 */
public class UserAgentUtils {
    
    private static Pattern [] mobileUserAgentPatterns = 
    {
        Pattern.compile(".*(iphone|ipod).*", Pattern.CASE_INSENSITIVE),
        Pattern.compile(".*(android).*", Pattern.CASE_INSENSITIVE),
        Pattern.compile(".*(blackberry|opera mini).*", Pattern.CASE_INSENSITIVE),
        Pattern.compile(".*(webos|palm|treo).*", Pattern.CASE_INSENSITIVE),
        Pattern.compile(".*(kindle|pocket|o2|vodafone|wap|midp|psp).*", Pattern.CASE_INSENSITIVE)
    };
    
    public static boolean isMobile(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if(StringUtils.isEmpty(userAgent)) {
            return false;
        }
        for (final Pattern pattern : mobileUserAgentPatterns) {
            final Matcher matcher = pattern.matcher(userAgent);
            if (matcher.find()) {
                return true;
            }
        }
        
        return false;
    }
    
}
