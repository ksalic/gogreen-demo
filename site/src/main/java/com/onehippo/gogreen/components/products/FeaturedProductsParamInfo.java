/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.products;

import com.onehippo.gogreen.components.common.BaseLayoutParamsInfo;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(
                titleKey = "fields.channel",
                value = {"product1", "product2", "product3", "product4"}
)
})
public interface FeaturedProductsParamInfo extends BaseLayoutParamsInfo {

    @Parameter(name = "product1", required = true, displayName = "Product 1")
    @JcrPath(isRelative = true, pickerInitialPath = "products", pickerSelectableNodeTypes = {"hippogogreen:product"})
    String getProduct1();

    @Parameter(name = "product2", displayName = "Product 2")
    @JcrPath(isRelative = true, pickerInitialPath = "products", pickerSelectableNodeTypes = {"hippogogreen:product"})
    String getProduct2();

    @Parameter(name = "product3", displayName = "Product 3")
    @JcrPath(isRelative = true, pickerInitialPath = "products", pickerSelectableNodeTypes = {"hippogogreen:product"})
    String getProduct3();

    @Parameter(name = "product4", displayName = "Product 4")
    @JcrPath(isRelative = true, pickerInitialPath = "products", pickerSelectableNodeTypes = {"hippogogreen:product"})
    String getProduct4();

}
