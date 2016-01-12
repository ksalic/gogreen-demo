/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.channels;

import org.hippoecm.hst.configuration.channel.ChannelInfo;
import org.hippoecm.hst.core.parameters.*;

import com.onehippo.gogreen.DocumentTypes;

/**
 * Retrieves the properties of the GoGreen channels.
 */
@FieldGroupList({
        @FieldGroup(
                titleKey = "fields.channel",
                value = { "logo", "pageTitlePrefix", "themeCss" }
        ),
        @FieldGroup(
            titleKey = "fields.channel.boxed",
            value = { "boxed", "boxedPattern" }
)
})
public interface WebsiteInfo extends ChannelInfo {

    @Parameter(name = "logo")
    @JcrPath(
            pickerSelectableNodeTypes = { DocumentTypes.IMAGE_SET },
            pickerInitialPath = "/content/gallery/logos"
    )
    String getLogoPath();

    @Parameter(name = "pageTitlePrefix", defaultValue = "Hippo Go Green")
    String getPageTitlePrefix();

    @Parameter(name = "themeCss", defaultValue = "/content/assets/themes/css/green.css")
    @JcrPath(
            pickerConfiguration = "cms-pickers/assets",
            pickerSelectableNodeTypes = {"hippogallery:exampleAssetSet"},
            pickerInitialPath = "/content/assets/themes/css"
    )
    String getThemeCss();

    @Parameter(name = "boxed")
    boolean getBoxed();

    @Parameter(name = "boxedPattern", defaultValue = "shattered")
    @DropDownList(value= {"blacktwill",
            "darkfishskin",
            "escheresque",
            "grey",
            "knitting250px",
            "p4",
            "p5",
            "p6",
            "pwpattern",
            "psneutral",
            "pwmazewhite",
            "retinawood",
            "shattered",
            "subtledots",
            "subtlesurface",
            "whitediamond"})
    String getBoxedPattern();

}