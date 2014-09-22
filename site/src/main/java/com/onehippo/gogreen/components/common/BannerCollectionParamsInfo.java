/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
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
                titleKey = "layout",
                value = { "bannerType", "bannerBackground" }
        ),
        @FieldGroup(
                titleKey = "banners",
                value = { "banner1", "banner2", "banner3", "banner4" }
        )
})
public interface BannerCollectionParamsInfo extends BaseLayoutParamsInfo {

    @Parameter(name = "bannerType", required = true, defaultValue = "horizontaldefault")
    @DropDownList(value= {"horizontaldefault", "horizontal1", "horizontal2", "horizontal3", "vertical", "images"})
    String getBannerType();

    @Parameter(name = "bannerBackground", required = true, defaultValue = "white")
    @DropDownList(value= {"white", "gray", "blue", "gradient"})
    String getBannerBackground();

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
