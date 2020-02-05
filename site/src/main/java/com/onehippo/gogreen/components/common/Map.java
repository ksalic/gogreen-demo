/**
 * Copyright 2010-2020 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.components.BaseComponent;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.RepositoryException;

@ParametersInfo(type = MapParamsInfo.class)
public class Map extends BaseComponent {

    public static final Logger log = LoggerFactory.getLogger(Map.class);
    public static final String EXPERIENCE_OPTIMIZER_PERSPECTIVE = "/hippo:configuration/hippo:frontend/cms/hippo-targeting/experience-optimizer-perspective";
    public static final String GOOGLE_API_KEY = "google.api.key";

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

        try {
            final Node experiencePerspective = request.getRequestContext().getSession().getNode(EXPERIENCE_OPTIMIZER_PERSPECTIVE);
            if (experiencePerspective.hasProperty(GOOGLE_API_KEY)) {
                String apiKey = experiencePerspective.getProperty(GOOGLE_API_KEY).getString();
                request.setAttribute("googleApiKey", apiKey);
            }
        } catch (RepositoryException e) {
            log.warn("could not retrieve configuration node {}", EXPERIENCE_OPTIMIZER_PERSPECTIVE);
        }

    }
}