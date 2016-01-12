/*
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import org.hippoecm.hst.core.parameters.*;

@FieldGroupList({
        @FieldGroup(
                titleKey = "header",
                value = { "title", "icon", "separatorMargin", "separatorBorderTop", "separatorBorderBottom" }
        )
})

public interface BaseLayoutParamsInfo {

    final static String PARAM_TITLE = "title";
    final static String PARAM_ICON = "icon";
    final static String PARAM_SEPARATORMARGIN = "separatorMargin";
    final static String PARAM_SEPARATORBORDERTOP = "separatorBorderTop";
    final static String PARAM_SEPARATORBORDERBOTTOM = "separatorBorderBottom";

    @Parameter(name = PARAM_TITLE)
    String getTitle();

    @Parameter(name = PARAM_ICON)
    String getIcon();

    @Parameter(name = PARAM_SEPARATORBORDERTOP)
    boolean getSeparatorBorderTop();

    @Parameter(name = PARAM_SEPARATORBORDERBOTTOM)
    boolean getSeparatorBorderBottom();

    @Parameter(name = PARAM_SEPARATORMARGIN, required = true, defaultValue = "20")
    @DropDownList(value= {"0", "20", "30", "40", "50", "60", "70", "80", "90", "100"})
    String getSeparatorMargin();

}
