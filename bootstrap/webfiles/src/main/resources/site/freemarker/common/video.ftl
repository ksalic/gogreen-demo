<#include "../include/imports.ftl">

<div class="container">
  <div class="row video">
  <#if title??>
    <div class="row">
      <div class="col-md-12 col-sm-12">
        <h2 class="h2-section-title">
        ${title}
        </h2>
        <#if icon??>
          <div class="i-section-title">
            <i class="fa ${icon}"></i>
          </div>
        </#if>
      </div>
    </div>
  </#if>
  <#if preview?? && videoURL??>
    <h2 class="not-configured">Click to configure Video component</h2>
  <#else>
    <iframe width="560" height="315" src="https://www.youtube.com/embed/${videoURL}" frameborder="0" allowfullscreen></iframe>
  </#if>
  </div>
</div>