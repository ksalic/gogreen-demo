/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(
                titleKey = "video",
                value = { "videoURL" }
        )
})

/**
 * HST Component Parameters Info class for the Banner. Used by the PageComposer.
 */
public interface VideoParamsInfo extends BaseLayoutParamsInfo {
    String PARAM_VIDEOURL = "videoURL";

    @Parameter(name = PARAM_VIDEOURL, required = true, displayName = "Youtube ID", defaultValue = "")
    String getVideoURL();
}
