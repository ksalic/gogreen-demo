/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
package com.onehippo.gogreen.components.common;

import com.onehippo.gogreen.utils.Constants;

import org.hippoecm.hst.core.parameters.DropDownList;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

/**
 * HST Component Parameters Info class for LatestItems. Used PageComposer.
 */
@FieldGroupList({
        @FieldGroup(
                titleKey = "group.content",
                value = {
                        LatestItemsParamsInfo.PARAM_SCOPE,
                        LatestItemsParamsInfo.PARAM_LIMIT
                }
        ),
        @FieldGroup(
                titleKey = "group.sorting",
                value = {
                        LatestItemsParamsInfo.PARAM_ORDER_BY,
                        LatestItemsParamsInfo.PARAM_SORT_ORDER
                }
        ),
        @FieldGroup(
                titleKey = "group.constraints",
                value = {
                    LatestItemsParamsInfo.PARAM_TAGS,
                    LatestItemsParamsInfo.PARAM_CONSTRAINT
                }
        )
})
public interface LatestItemsParamsInfo extends BaseLayoutParamsInfo {

    String PARAM_SCOPE = "scope";
    String PARAM_NODE_TYPE = "nodetype";
    String PARAM_LIMIT = "limit";
    String PARAM_ORDER_BY = "orderBy";
    String PARAM_SORT_ORDER = "sortOrder";
    String PARAM_TAGS = "tags";
    String PARAM_CONSTRAINT = "constraint";

    @Parameter(name = PARAM_SCOPE, required = true, defaultValue = "")
    @JcrPath(isRelative = true, pickerInitialPath = "", pickerSelectableNodeTypes = {"hippostd:folder"}, pickerConfiguration = "cms-pickers/folders")
    String getScope();

    @Parameter(name = PARAM_NODE_TYPE, required = true, defaultValue = "", hideInChannelManager = true)
    String getNodetype();

    @Parameter(name = PARAM_LIMIT, required = true, defaultValue = "5")
    int getLimit();

    @Parameter(name = PARAM_ORDER_BY, required = true, defaultValue = "hippogogreen:closingdate")
    String getOrderBy();

    @Parameter(name = PARAM_SORT_ORDER, required = true, defaultValue = "descending")
    @DropDownList(value= {"ascending", "descending"})
    String getSortOrder();

    @Parameter(name = PARAM_TAGS, defaultValue = "")
    String getTags();

    @Parameter(name = PARAM_CONSTRAINT, defaultValue = "")
    String getConstraint();

}
