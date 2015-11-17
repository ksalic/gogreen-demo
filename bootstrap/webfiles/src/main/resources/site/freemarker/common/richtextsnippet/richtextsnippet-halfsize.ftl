<#include "../../include/imports.ftl">
<#if Request.document??>
<div class="richtextsnippet-component">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-sm-6">
        <@hst.cmseditlink hippobean=Request.document/>
          <@hst.html hippohtml=Request.document.richText/>
      </div>
    </div>
  </div>
</div>
<#elseif Request.preview>
<h2 class="not-configured">Click to configure Rich text snippet</h2>
</#if>
