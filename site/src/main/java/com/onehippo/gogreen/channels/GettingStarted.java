/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.channels;

import org.hippoecm.hst.configuration.channel.ChannelInfo;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;


public interface GettingStarted extends ChannelInfo {

    @Parameter(name = "logo")
    @JcrPath(
            pickerSelectableNodeTypes = {"hippogallery:imageset"},
            pickerInitialPath = "/content/gallery"
    )
    String getLogoPath();

    @Parameter(name = "pageTitlePrefix", defaultValue = "")
    String getPageTitlePrefix();

    @Parameter(name = "themeCss")
    @JcrPath(
            pickerConfiguration = "cms-pickers/assets",
            pickerSelectableNodeTypes = {"hippogallery:exampleAssetSet"},
            pickerInitialPath = "/content/assets"
    )
    String getCss();

    @Parameter(name = "additionalJs")
    @JcrPath(
            pickerConfiguration = "cms-pickers/assets",
            pickerSelectableNodeTypes = {"hippogallery:exampleAssetSet"},
            pickerInitialPath = "/content/assets"
    )
    String getJS();


}