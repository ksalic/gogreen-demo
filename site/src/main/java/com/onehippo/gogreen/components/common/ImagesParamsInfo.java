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
                titleKey = "images",
                value = { "background", "image1", "image2", "image3", "image4", "image5" }
        )
})

public interface ImagesParamsInfo extends BaseLayoutParamsInfo {

    @Parameter(name = "background", required = true, defaultValue = "white")
    @DropDownList(value= {"white", "gray", "blue", "gradient"})
    String getBackground();

    @Parameter(name = "image1", required = true, displayName = "Image 1")
    @JcrPath(isRelative = true, pickerSelectableNodeTypes = {"hippogogreen:newsitem", "hippogogreen:event", "hippogogreen:product"}, pickerConfiguration = "cms-pickers/documents-only")
    String getImage1();

    @Parameter(name = "image2", required = false, displayName = "Image 2")
    @JcrPath(isRelative = true, pickerSelectableNodeTypes = {"hippogogreen:newsitem", "hippogogreen:event", "hippogogreen:product"}, pickerConfiguration = "cms-pickers/documents-only")
    String getImage2();

    @Parameter(name = "image3", required = false, displayName = "Image 3")
    @JcrPath(isRelative = true, pickerSelectableNodeTypes = {"hippogogreen:newsitem", "hippogogreen:event", "hippogogreen:product"}, pickerConfiguration = "cms-pickers/documents-only")
    String getImage3();

    @Parameter(name = "image4", required = false, displayName = "Image 4")
    @JcrPath(isRelative = true, pickerSelectableNodeTypes = {"hippogogreen:newsitem", "hippogogreen:event", "hippogogreen:product"}, pickerConfiguration = "cms-pickers/documents-only")
    String getImage4();

    @Parameter(name = "image5", required = false, displayName = "Image 5")
    @JcrPath(isRelative = true, pickerSelectableNodeTypes = {"hippogogreen:newsitem", "hippogogreen:event", "hippogogreen:product"}, pickerConfiguration = "cms-pickers/documents-only")
    String getImage5();

}
