/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.Parameter;

/**
 * HST Component Parameters Info class for the Html component. Used by the PageComposer.
 */
public interface HtmlParamsInfo {
    String PARAM_HTMLCONTENT = "htmlContent";

    @Parameter(name = PARAM_HTMLCONTENT, required = true, displayName = "Html", defaultValue = "")
    String getHtmlContent();
}
