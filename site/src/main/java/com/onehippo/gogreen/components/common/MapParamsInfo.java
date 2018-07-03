/*
 * Copyright 2011-2018 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

import static com.onehippo.gogreen.components.common.MapParamsInfo.PARAM_ADDRESS;
import static com.onehippo.gogreen.components.common.MapParamsInfo.PARAM_ZOOMLEVEL;

/**
 * HST Component Parameters Info class for the Banner. Used by the PageComposer.
 */

@FieldGroupList({
        @FieldGroup(
                titleKey = "settings",
                value = {PARAM_ADDRESS, PARAM_ZOOMLEVEL}
        )
})
public interface MapParamsInfo {
    String PARAM_ADDRESS = "address";
    String PARAM_ZOOMLEVEL = "zoomlevel";

    @Parameter(name = PARAM_ADDRESS, required = true, displayName = "Address", defaultValue = "")
    String getAddress();

    @Parameter(name = PARAM_ZOOMLEVEL, required = false, displayName = "Zoom level", defaultValue = "")
    String getZoomlevel();

}