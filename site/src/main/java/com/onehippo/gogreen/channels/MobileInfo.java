/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.channels;

import org.hippoecm.hst.configuration.channel.ChannelInfo;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

import com.onehippo.gogreen.DocumentTypes;

/**
 * Retrieves the properties of the GoGreen channels.
 */
@FieldGroupList({
        @FieldGroup(
                titleKey = "fields.channel",
                value = { "logo", "pageTitlePrefix" }
        )
})
public interface MobileInfo extends ChannelInfo {

    @Parameter(name = "logo", displayName = "Logo")
    @JcrPath(
            pickerSelectableNodeTypes = { DocumentTypes.IMAGE_SET },
            pickerInitialPath = "/content/gallery/logos"
    )
    String getLogoPath();

    @Parameter(name = "pageTitlePrefix", displayName = "Page title prefix", defaultValue = "Hippo Go Green")
    String getPageTitlePrefix();

}
