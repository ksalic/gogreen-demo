<#include "../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->

<div class="container">
  <div class="row video">
  <#if Request.title??>
    <div class="row">
      <div class="col-md-12 col-sm-12">
        <h2 class="h2-section-title">
        ${Request.title?html}
        </h2>
        <#if Request.icon??>
          <div class="i-section-title">
            <i class="fa ${Request.icon}"></i>
          </div>
        </#if>
      </div>
    </div>
  </#if>
  <#if Request.videoURL??>
    <iframe width="560" height="315" src="https://www.youtube.com/embed/${Request.videoURL}" frameborder="0" allowfullscreen></iframe>
  <#elseif Request.preview??>
    <h2 class="not-configured">Click to configure Video component</h2>
  </#if>
  </div>
</div>