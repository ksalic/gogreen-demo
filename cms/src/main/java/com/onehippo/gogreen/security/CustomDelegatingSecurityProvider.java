package com.onehippo.gogreen.security;

import org.apache.commons.lang.StringUtils;
import org.apache.jackrabbit.api.security.user.UserManager;
import org.apache.jackrabbit.value.StringValue;
import org.hippoecm.repository.security.DelegatingSecurityProvider;
import org.hippoecm.repository.security.RepositorySecurityProvider;
import org.hippoecm.repository.security.user.DelegatingHippoUserManager;
import org.hippoecm.repository.security.user.HippoUserManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.*;
import java.util.Arrays;

public class CustomDelegatingSecurityProvider extends DelegatingSecurityProvider {
    private static final Logger log = LoggerFactory.getLogger(CustomDelegatingSecurityProvider.class);

    private HippoUserManager userManager;

    /**
     * Constructs by creating the default <code>RepositorySecurityProvider</code> to delegate all the other calls
     * except of authentication calls.
     *
     * @throws RepositoryException
     */
    public CustomDelegatingSecurityProvider() {
        super(new RepositorySecurityProvider());
    }

    /**
     * Returns a custom (delegating) HippoUserManager to authenticate a user by SAML Assertion.
     */
    @Override
    public UserManager getUserManager() throws RepositoryException {
        if (userManager == null) {
            userManager = new DelegatingHippoUserManager((HippoUserManager) super.getUserManager()) {
                @Override
                public boolean authenticate(SimpleCredentials creds) throws RepositoryException {
                    if (validateAuthentication(creds)) {
                        String userId = creds.getUserID();
                        if (!hasUser(userId)) {
                            //user doesn't exist in the repository
                            log.debug("1. User doesn't exist in the repository. Creating user: {}", userId);
                            syncUser(createUser(userId), getGroupManager().getGroup("admin"));
                        }
                        return true;
                    } else {
                        return false;
                    }
                }
            };
        }
        return userManager;
    }

    /**
     * Returns a custom (delegating) HippoUserManager to authenticate a user by SAML Assertion.
     */
    @Override
    public UserManager getUserManager(Session session) throws RepositoryException {
        return new DelegatingHippoUserManager((HippoUserManager) super.getUserManager(session)) {
            @Override
            public boolean authenticate(SimpleCredentials creds) throws RepositoryException {
                if (validateAuthentication(creds)) {
                    String userId = creds.getUserID();
                    if (!hasUser(userId)) {
                        //user doesn't exist in the repository
                        log.debug("2. User doesn't exist in the repository. Creating user: {}", userId);
                        syncUser(createUser(userId), getGroupManager().getGroup("admin"));
                    }
                    return true;
                } else {
                    return false;
                }
            }
        };
    }

    /**
     * Validates SAML SSO Assertion.
     * <p>
     * In this example, simply invokes SAML API (<code>AssertionHolder#getAssertion()</code>) to validate.
     * </P>
     *
     * @param creds
     * @return
     * @throws RepositoryException
     */
    protected boolean validateAuthentication(SimpleCredentials creds) {
        log.info("CustomDelegatingSecurityProvider validating credentials: {}", creds);

        SSOUserState userState = LoginSuccessFilter.getCurrentSSOUserState();

        /*
         * If userState found in the current thread context, this authentication request came from
         * CMS application.
         * Otherwise, this authentication request came from SITE application (e.g, channel manager rest service).
         */

        if (userState != null) {

            // Asserting must have been done by the *AssertionValidationFilter* and the assertion thread local variable
            // must have been set by AssertionThreadLocalFilter already.
            // So, simply check if you have assertion object in the thread local.
            return StringUtils.isNotEmpty(userState.getCredentials().getUsername());

        } else {

            String samlId = (String) creds.getAttribute(SSOUserState.SAML_ID);

            log.debug("userState is null. samlId: {}", samlId);

            if (StringUtils.isNotBlank(samlId)) {
                log.debug("Authentication allowed to: {}", samlId);
                return true;
            }
        }

        return false;
    }

    protected void syncUser(final Node user, final Node group) throws RepositoryException {
        if (group == null) {
            throw new RepositoryException();
        }
        user.setProperty("hipposys:securityprovider", "saml");
        user.setProperty("hipposys:active", true);
        user.setPrimaryType("hipposys:externaluser");

        //updating group members
        Value[] values = group.getProperties("hipposys:members").nextProperty().getValues();
        Value[] newValues = Arrays.copyOf(values, values.length + 1);
        newValues[values.length] = new StringValue(user.getName());
        group.setProperty("hipposys:members", newValues);
    }
}
