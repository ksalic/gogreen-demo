/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.*;

@FieldGroupList({
        @FieldGroup(
                titleKey = "images",
                value = {"image1", "image2", "image3", "image4", "image5" }
        )
})

public interface ImagesParamsInfo extends BaseLayoutParamsInfo {


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
