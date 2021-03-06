/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.beans.compound.ImageSet;
import com.onehippo.gogreen.channels.MobileInfo;
import com.onehippo.gogreen.components.BaseComponent;

import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.content.beans.ObjectBeanManagerException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MobileLogo extends BaseComponent {

    private final Logger log = LoggerFactory.getLogger(MobileLogo.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();

        final Mount mount = request.getRequestContext().getResolvedMount().getMount();
        final MobileInfo info = mount.getChannelInfo();
        if (info == null) {
            log.warn("No channel info available for mount '{}'. No logo will be shown", mount.getMountPath());
            return;
        }

        final String logoPath = info.getLogoPath();
        try {
            Object logo = ctx.getObjectBeanManager().getObject(logoPath);
            if (logo instanceof ImageSet) {
                request.setAttribute("logo", logo);
            } else {
                log.warn("Mount '{}' has illegal logo path '{}' (not an image set). No logo will be shown.");
            }
        } catch (ObjectBeanManagerException e) {
            log.warn("Cannot retrieve logo at '" + logoPath + "'", e);
        }
    }
}
