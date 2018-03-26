/*
 * Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

/**
 * HST Component Parameters Info class for SimpleDocument. Used by PageComposer.
 */
public interface SimpleDocumentParamsInfo {
    String PARAM_DOCUMENTLOCATION = "documentlocation";

    @Parameter(name = PARAM_DOCUMENTLOCATION, required = true, displayName = "Document")
    @JcrPath(pickerSelectableNodeTypes = "hippogogreen:simpledocument", pickerInitialPath = "common/simpledocuments")
    String getDocumentLocation();
}
