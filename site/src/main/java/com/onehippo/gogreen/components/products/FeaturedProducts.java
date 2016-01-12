/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.products;

import java.util.ArrayList;
import java.util.List;

import com.onehippo.gogreen.components.common.BaseLayout;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.core.request.HstRequestContext;

import com.onehippo.gogreen.beans.Product;

@ParametersInfo(type = FeaturedProductsParamInfo.class)
public class FeaturedProducts extends BaseLayout {

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        FeaturedProductsParamInfo paramInfo = getComponentParametersInfo(request);
        List<Product> products = new ArrayList<Product>();
        final HippoBean siteContentBaseBean = ctx.getSiteContentBaseBean();
        Product product = siteContentBaseBean.<Product>getBean(paramInfo.getProduct1());
        if(product != null) {
            products.add(product);
        }
        product = siteContentBaseBean.<Product>getBean(paramInfo.getProduct2());
        if(product != null) {
            products.add(product);
        }
        product = siteContentBaseBean.<Product>getBean(paramInfo.getProduct3());
        if(product != null) {
            products.add(product);
        }
        product = siteContentBaseBean.<Product>getBean(paramInfo.getProduct4());
        if(product != null) {
            products.add(product);
        }
        request.setAttribute("products", products);
        Boolean isReseller = request.isUserInRole("reseller");
        request.setAttribute("reseller", isReseller);
    }
}

