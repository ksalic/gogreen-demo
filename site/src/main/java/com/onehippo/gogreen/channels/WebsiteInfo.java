/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
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
            "p4",
            "p6",
            "psneutral",
            "pwmazewhite",
            "pwpattern",
            "retinawood",
            "shattered",
            "subtledots",
            "subtlesurface",
            "whitediamond"})
    String getBoxedPattern();

}