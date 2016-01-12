/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.products;

import org.hippoecm.hst.core.parameters.Parameter;

public interface OverviewParamInfo {

    @Parameter(name = "reviewsFolder", required = false, defaultValue = "reviews", displayName = "Reviews folder")
    String getReviewsFolder();

}
