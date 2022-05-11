package com.onehippo.gogreen.components;

import org.hippoecm.hst.component.support.bean.dynamic.BaseHstDynamicComponent;
import org.hippoecm.hst.configuration.components.DynamicComponentInfo;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.site.HstServices;
import org.onehippo.cms7.crisp.api.broker.ResourceServiceBroker;
import org.onehippo.cms7.crisp.api.resource.Resource;
import org.onehippo.cms7.crisp.api.resource.ResourceBeanMapper;
import org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource;
import org.onehippo.cms7.crisp.hst.module.CrispHstServices;

@ParametersInfo(type = DynamicComponentInfo.class)
public class ExtDocComponent extends BaseHstDynamicComponent {


    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) throws HstComponentException {
        super.doBeforeRender(request, response);

        ResourceServiceBroker broker = CrispHstServices.getDefaultResourceServiceBroker(HstServices.getComponentManager());
        Resource userResource = broker.resolve("demo", "");
        request.setModel("user", userResource.getNodeData());

    }

}
