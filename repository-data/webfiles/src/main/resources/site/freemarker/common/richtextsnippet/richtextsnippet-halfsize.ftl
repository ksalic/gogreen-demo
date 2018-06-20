<#include "../../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.document??>
<div class="richtextsnippet-component">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-sm-6">
        <@hst.manageContent hippobean=Request.document templateQuery="new-richcontextsnippet" defaultPath="common/rich-text-snippets" parameterName="bannerlocation"/>
          <@hst.html hippohtml=Request.document.richText/>
      </div>
    </div>
  </div>
</div>
<#elseif editMode>
<div class="not-configured">
    <h2>Click to configure Rich text snippet</h2>
    <@hst.manageContent templateQuery="new-richcontextsnippet" defaultPath="common/rich-text-snippets" parameterName="bannerlocation"/>
</div>
</#if>
