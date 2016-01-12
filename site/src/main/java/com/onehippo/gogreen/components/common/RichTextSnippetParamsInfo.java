/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.*;

/**
 * HST Component Parameters Info class for the Rich-text Snippet. Used by the PageComposer.
 */
public interface RichTextSnippetParamsInfo {
    String PARAM_SNIPPETLOCATION = "bannerlocation";

    @Parameter(name = PARAM_SNIPPETLOCATION, required = true, displayName = "Rich-text Snippet")
    @JcrPath(isRelative = true, pickerInitialPath = "common/banners", pickerSelectableNodeTypes = {"hippogogreen:richtextsnippet"}, pickerConfiguration = "cms-pickers/documents-only")
    String getSnippetLocation();

}