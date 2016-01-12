/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.components;

import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.content.beans.standard.HippoFolder;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DocumentComponent extends BaseComponent {
    public static final Logger LOGGER = LoggerFactory.getLogger(DocumentComponent.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {

        super.doBeforeRender(request, response);
        final HstRequestContext ctx = request.getRequestContext();
        if (!(ctx.getContentBean() instanceof HippoFolder)) {
            HippoDocument document = (HippoDocument) ctx.getContentBean();
            if (document == null) {
                return;
            }
            request.setAttribute("document", document);

        } else {
            return;
        }

    }

}
