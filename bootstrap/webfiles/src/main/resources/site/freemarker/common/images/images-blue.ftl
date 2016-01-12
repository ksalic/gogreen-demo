<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.images??>
  <#if  Request.title??>
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

<div class="section-content section-color-dark-blue white-text">
  <div class="container images-component">
    <div class="row">
      <div class="col-md-12 col-sm-12">
        <ul class="section-clients">
          <#list Request.images as doc>
            <li class="animated bounceIn animatedVisi" data-animtype="bounceIn" data-animrepeat="0" data-animdelay="0.2s" style="-webkit-animation: 0.2s;">
              <#assign image=doc.firstImage/>
              <a href="<@hst.link hippobean=doc/>">
                <#if image.alt??>
                  <img src="<@hst.link hippobean=image.largeThumbnail/>" alt="${image.alt}">
                <#else>
                  <img src="<@hst.link hippobean=image.largeThumbnail/>">
                </#if>
              </a>
              <@hst.cmseditlink hippobean=doc/>
            </li>
          </#list>
        </ul>
      </div>
    </div>
  </div>
</div>
  <#if Request.separatorBorderTop??>
    <#assign cssClass> border-top</#assign>
  </#if>
  <#if Request.separatorBorderBottom??>
    <#assign cssClass>${cssClass} border-bottom</#assign>
  </#if>

  <#if Request.separatorMargin?? && cssClass??>
  <div class="space-sep ${Request.separatorMargin} ${cssClass}"></div>
  <#elseif Request.separatorMargin??>
  <div class="space-sep ${Request.separatorMargin}"></div>
  <#elseif cssClass??>
  <div class="space-sep ${cssClass}"></div>
  </#if>

<#elseif Request.preview??>
<h2 class="not-configured">Click to configure Image component</h2>
</#if>