<#include "../../include/imports.ftl">

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
  <#if videoURL??>
    <iframe src="https://player.vimeo.com/video/${videoURL}" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
  <#elseif preview??>
    <h2 class="not-configured">Click to configure Video component</h2>
  </#if>
  </div>
</div>