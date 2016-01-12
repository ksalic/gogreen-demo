/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = MapParamsInfo.class)
public class Map extends BaseComponent {

    public static final Logger log = LoggerFactory.getLogger(Map.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);

        MapParamsInfo paramsInfo = getComponentParametersInfo(request);
        String address = paramsInfo.getAddress();
        String zoomlevel = paramsInfo.getZoomlevel();
        log.debug("Address specified in hst is " + address);
        // the address is inserted in a URL, to retrieve a map through Google Maps' Static Image API
        // therefore, remove all non-word characters and replace spaces by '+'-sign.
        address.replaceAll("[^a-zA-Z_0-9 ]", "");
        address.replaceAll(" ", "+");
        request.setAttribute("address", address);
        request.setAttribute("zoomlevel", zoomlevel);
    }
}