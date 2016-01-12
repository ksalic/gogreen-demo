/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.*;

@FieldGroupList({
        @FieldGroup(
                titleKey = "banners",
                value = { "banner1", "banner2", "banner3", "banner4" }
        )
})
public interface BannerCollectionParamsInfo extends BaseLayoutParamsInfo {

    @Parameter(name = "banner1", required = true, displayName = "Banner 1")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:banner"}, pickerConfiguration = "cms-pickers/documents-only")
    String getBanner1();

    @Parameter(name = "banner2", required = false, displayName = "Banner 2")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:banner"}, pickerConfiguration = "cms-pickers/documents-only")
    String getBanner2();

    @Parameter(name = "banner3", required = false, displayName = "Banner 3")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:banner"}, pickerConfiguration = "cms-pickers/documents-only")
    String getBanner3();

    @Parameter(name = "banner4", required = false, displayName = "Banner 4")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:banner"}, pickerConfiguration = "cms-pickers/documents-only")
    String getBanner4();

}
