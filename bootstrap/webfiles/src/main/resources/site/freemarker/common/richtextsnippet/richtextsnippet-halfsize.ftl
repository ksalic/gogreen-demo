<#include "../../include/imports.ftl">
<#if document??>
<div class="richtextsnippet-component">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-sm-6">
        <@hst.cmseditlink hippobean=document/>
          <@hst.html hippohtml=document.richText/>
      </div>
    </div>
  </div>
</div>
<#elseif preview??>
<h2 class="not-configured">Click to configure Rich text snippet</h2>
</#if>
