/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *  http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.*;

@FieldGroupList({
        @FieldGroup(
                titleKey = "banner",
                value = { "bannerlocation", "bannerBackground"}
        )
})

/**
 * HST Component Parameters Info class for the Banner. Used by the PageComposer.
 */
public interface BannerParamsInfo extends BaseLayoutParamsInfo {
    String PARAM_BANNERLOCATION = "bannerlocation";
    String PARAM_BANNERBACKGROUND = "bannerBackground";

    @Parameter(name = PARAM_BANNERBACKGROUND, required = true, defaultValue = "white")
    @DropDownList(value= {"white", "blue", "full"})
    String getBannerBackground();

    @Parameter(name = PARAM_BANNERLOCATION, required = true, displayName = "Banner")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:banner"}, pickerConfiguration = "cms-pickers/documents-only")
    String getBannerLocation();

}
 