/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components;

import com.onehippo.gogreen.components.common.BaseLayoutParamsInfo;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

/**
 * HST Component Parameters Info class for the Feed. Used by the PageComposer.
 */
@FieldGroupList({
        @FieldGroup(
                titleKey = "group.feed",
                value = {
                        FeedParamsInfo.PARAM_FEEDURL,
                        FeedParamsInfo.PARAM_NUMBEROFITEMS,
                        FeedParamsInfo.PARAM_UPDATEINTERVAL
                }
        ),
        @FieldGroup(
                titleKey = "group.connection",
                value = {
                        FeedParamsInfo.PARAM_CONNECTTIMEOUT,
                        FeedParamsInfo.PARAM_READTIMEOUT
                }
        )
})
public interface FeedParamsInfo extends BaseLayoutParamsInfo {
    String PARAM_FEEDURL = "feedURL";
    String PARAM_NUMBEROFITEMS = "numberOfItems";
    String PARAM_UPDATEINTERVAL = "updateInterval";
    String PARAM_CONNECTTIMEOUT = "connectTimeout";
    String PARAM_READTIMEOUT = "readTimeout";

    @Parameter(name = PARAM_FEEDURL, required = true, defaultValue = "")
    String getFeedUrl();

    @Parameter(name = PARAM_NUMBEROFITEMS, required = true, defaultValue = "3")
    int getNumberOfItems();

    @Parameter(name = PARAM_UPDATEINTERVAL, required = true, defaultValue = "15")
    int getUpdateInterval();

    @Parameter(name = PARAM_CONNECTTIMEOUT, required = true, defaultValue = "2000")
    int getConnectTimeout();

    @Parameter(name = PARAM_READTIMEOUT, required = true, defaultValue = "5000")
    int getReadTimeout();

}
