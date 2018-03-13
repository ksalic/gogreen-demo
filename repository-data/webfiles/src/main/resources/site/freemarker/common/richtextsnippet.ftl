<#include "../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.document??>
<div class="richtextsnippet-component">
  <div class="container">
    <div class="row">
      <div class="col-md-12 col-sm-12">
        <@hst.manageContent hippobean="Request.document" templateQuery="new-document"/>
          <@hst.html hippohtml=Request.document.richText/>
      </div>
    </div>
  </div>
</div>
<#elseif editMode>
<h2 class="not-configured">Click to configure Rich text snippet</h2>
</#if>
