/**
 * Copyright 2010-2014 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.exceptions;

import org.hippoecm.hst.configuration.components.HstComponentInfo;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.container.PageErrorHandler;
import org.hippoecm.hst.core.container.PageErrors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomPageErrorHandler implements PageErrorHandler {
    
    private static final  Logger log = LoggerFactory.getLogger(CustomPageErrorHandler.class);
    
    public Status handleComponentExceptions(PageErrors pageErrors, HstRequest hstRequest, HstResponse hstResponse) {
    
        for (HstComponentInfo componentInfo : pageErrors.getComponentInfos()) {
            for (HstComponentException componentException : pageErrors.getComponentExceptions(componentInfo)) {
                if (componentException instanceof ContentRelatedException) {
                  log.info("Component exception found on " + componentInfo.getComponentClassName(), componentException);
                } else {
                  log.warn("Component exception found on " + componentInfo.getComponentClassName(), componentException);
                }
            }
        }

        return Status.HANDLED_BUT_CONTINUE;
    }

}
