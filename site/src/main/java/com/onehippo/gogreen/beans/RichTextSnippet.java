/**
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

package com.onehippo.gogreen.beans;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;

import static com.onehippo.gogreen.utils.Constants.PROP_RICHTEXT;

@HippoEssentialsGenerated(allowModifications = false)
@Node(jcrType = "hippogogreen:richtextsnippet")
public class RichTextSnippet extends BaseDocument {

    private HippoHtml richtext;

    public HippoHtml getRichText() {
        if(richtext==null){
            richtext = getBean(PROP_RICHTEXT);
        }
        return richtext;
    }

}
