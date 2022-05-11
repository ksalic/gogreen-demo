/*
 * Copyright 2022-2022 Bloomreach
 */
package com.onehippo.gogreen.components;

import org.hippoecm.hst.component.support.bean.info.dynamic.DocumentQueryDynamicComponentInfo;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(value = {"scope", "documentTypes"}, titleKey = "list.group"),
        @FieldGroup(value = {"searchTermRequestParameter", "searchFields"}, titleKey = "search.group"),
        @FieldGroup(value = {"sortField", "sortOrder"}, titleKey = "sorting.group"),
        @FieldGroup(value = {"hidePastItems", "hideFutureItems", "dateField", "pageSize"}, titleKey = "filter.group")
})
public interface DocumentSimpleSearchComponentInfo extends DocumentQueryDynamicComponentInfo {

    /* Start search group*/
    @Parameter(name = "searchTermRequestParameter", defaultValue = "q")
    String getSearchTermRequestParameter();

    @Parameter(name = "searchFields")
    String getSearchFields();
    /* End search group*/

    /*We don't want to expose this, since we no longer support extending doc types. Yet we want it to be true, since
    internally all of our doc types extend from the base documents, and those from hippo:document.
    We have also removed it from the @FieldGroup annotation. */
    @Parameter(name = "includeSubtypes", defaultValue = "true", hideInChannelManager = true)
    @Override
    Boolean getIncludeSubtypes();

}
