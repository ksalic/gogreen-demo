/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.Parameter;

/**
 * HST Component Parameters Info class for the Banner. Used by the PageComposer.
 */
public interface MapParamsInfo {
    String PARAM_ADDRESS = "address";
    String PARAM_ZOOMLEVEL = "zoomlevel";

    @Parameter(name = PARAM_ADDRESS, required = true, displayName = "Address", defaultValue = "")
    String getAddress();

    @Parameter(name = PARAM_ZOOMLEVEL, required = false, displayName = "Zoom level", defaultValue = "")
    String getZoomlevel();

}