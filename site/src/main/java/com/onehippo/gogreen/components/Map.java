/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.onehippo.gogreen.components;

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