/**
// * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.utils;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import javax.servlet.http.HttpServletRequest;

import org.easymock.EasyMock;
import org.junit.Test;

public class TestUserAgentUtils {
    
    private String firefox = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.04 (lucid) Firefox/3.6.13";
    private String iphone = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A537a Safari/419.3";
    
    @Test
    public void testUserAgents() {
        HttpServletRequest request = EasyMock.createNiceMock(HttpServletRequest.class);
        EasyMock.expect(request.getHeader("User-Agent")).andReturn(firefox).anyTimes();
        EasyMock.replay(request);
        
        assertFalse(UserAgentUtils.isMobile(request));
        
        request = EasyMock.createNiceMock(HttpServletRequest.class);
        EasyMock.expect(request.getHeader("User-Agent")).andReturn(iphone).anyTimes();
        EasyMock.replay(request);
        
        assertTrue(UserAgentUtils.isMobile(request));
    }
    
}
