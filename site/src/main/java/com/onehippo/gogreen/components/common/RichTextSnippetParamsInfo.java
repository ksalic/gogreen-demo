/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *  http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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