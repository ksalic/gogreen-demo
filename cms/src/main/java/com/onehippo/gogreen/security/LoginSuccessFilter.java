package com.onehippo.gogreen.security;

import org.hippoecm.frontend.model.UserCredentials;
import org.onehippo.cms7.services.cmscontext.CmsSessionContext;
import org.opensaml.saml2.core.Attribute;
import org.opensaml.saml2.core.NameID;
import org.opensaml.xml.schema.impl.XSStringImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.saml.SAMLCredential;
import org.springframework.web.util.WebUtils;

import javax.jcr.SimpleCredentials;
import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Locale;

public class LoginSuccessFilter implements Filter {
    private static final Logger log = LoggerFactory.getLogger(LoginSuccessFilter.class);

    private static final String SSO_USER_STATE = SSOUserState.class.getName();
    public static final String ATTRIBUTE_EMAIL = "urn:rijksoverheid.nl:emailAddress";
    public static final String DEFAULT_LANGUAGE = "nl";

    private static ThreadLocal<SSOUserState> tlCurrentSSOUserState = new ThreadLocal<>();

    @Override
    public void init(FilterConfig filterConfig) {
        // Do nothing
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        log.trace("doFilter LoginSuccessFilter");

        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (!authentication.isAuthenticated()) {
            log.debug("User not authenticated");
            chain.doFilter(request, response);
            return;
        }

        // Check if the user already has a SSO user state stored in HttpSession before.
        HttpSession session = ((HttpServletRequest) request).getSession();

        SSOUserState userState = (SSOUserState) session.getAttribute(SSO_USER_STATE);

        if (userState == null || !userState.getSessionId().equals(session.getId())) {
            if (authentication.getCredentials() instanceof SAMLCredential) {
                SAMLCredential samlCredential = (SAMLCredential) authentication.getCredentials();
                final NameID nameID = samlCredential.getNameID();
                final Attribute attributeEmail = samlCredential.getAttribute(ATTRIBUTE_EMAIL);
                if (nameID == null) {
                    log.debug("nameID is null in SAML Credentials");
                    chain.doFilter(request, response);
                    return;
                }
                final String nameId = nameID.getValue();
                log.debug("SAML nameID: {}", nameId);

                if (attributeEmail == null || attributeEmail.getAttributeValues().isEmpty()) {
                    log.debug("attribute email is null in SAML Credentials");
                    chain.doFilter(request, response);
                    return;
                }
                final String username = ((XSStringImpl) attributeEmail.getAttributeValues().get(0)).getValue().toLowerCase();
                log.debug("SAML Email ID: {}", username);

                SimpleCredentials creds = new SimpleCredentials(username, "DUMMY".toCharArray());
                creds.setAttribute(SSOUserState.SAML_ID, username);
                userState = new SSOUserState(new UserCredentials(creds), session.getId());
                session.setAttribute(SSO_USER_STATE, userState);


            } else {
                log.debug("Authenticated user credentials are not SAML credentials.");
                chain.doFilter(request, response);
                return;
            }

        }

        // If the user has a valid SSO user state, then
        // set a JCR Credentials as request attribute (named by FQCN of UserCredentials class).
        // Then the CMS application will use the JCR credentials passed through this request attribute.
        if (userState.getSessionId().equals(session.getId())) {
            request.setAttribute(UserCredentials.class.getName(), userState.getCredentials());
            request.setAttribute(CmsSessionContext.LOCALE, Locale.forLanguageTag(getUserLocale(request)));
        }

        try {
            tlCurrentSSOUserState.set(userState);
            chain.doFilter(request, response);
        } finally {
            tlCurrentSSOUserState.remove();
        }

    }

    /**
     * Gets the user locale from the "loc" cookie if present. If not, defaults to "nl"
     *
     * @param request the request
     * @return the locale code
     */
    private String getUserLocale(ServletRequest request) {
        Cookie localeCookie = WebUtils.getCookie((HttpServletRequest) request, "loc");

        if (localeCookie == null) {
            return DEFAULT_LANGUAGE;
        }
        return localeCookie.getValue();
    }

    /**
     * Get current <code>SSOUserState</code> instance from the current thread local context.
     *
     * @return
     */
    static SSOUserState getCurrentSSOUserState() {
        return tlCurrentSSOUserState.get();
    }

    @Override
    public void destroy() {
        // Do nothing
    }
}