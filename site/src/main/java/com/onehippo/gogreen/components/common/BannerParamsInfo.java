/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.*;

@FieldGroupList({
        @FieldGroup(
                titleKey = "banner",
                value = { "bannerlocation"}
        )
})

/**
 * HST Component Parameters Info class for the Banner. Used by the PageComposer.
 */
public interface BannerParamsInfo extends BaseLayoutParamsInfo {
    String PARAM_BANNERLOCATION = "bannerlocation";

    @Parameter(name = PARAM_BANNERLOCATION, required = true, displayName = "Banner")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:banner"}, pickerConfiguration = "cms-pickers/documents-only")
    String getBannerLocation();

}
 