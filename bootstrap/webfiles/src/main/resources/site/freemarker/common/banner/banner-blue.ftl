<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.document??>
  <#if Request.title?? && Request.title!=''>
  <div class="row">
    <div class="col-md-12 col-sm-12">
      <h2 class="h2-section-title">
      ${Request.title?html}
      </h2>
      <#if Request.icon??>
        <div class="i-section-title">
          <i class="fa  ${Request.icon}"></i>
        </div>
      </#if>
    </div>
  </div>
  </#if>
  <div class="banner-component section-content section-color-dark-blue white-text">
    <div class="container">
      <div class="row">
          <div class="col-md-6 col-sm-6 animated fadeInLeftBig animatedVisi" data-animtype="fadeInLeftBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <div class="space-sep100"></div>
            <@hst.cmseditlink hippobean=Request.document/>
            <#if Request.document.docLink??>
              <h2 class="h2-section-title"><a href="<@hst.link hippobean=Request.document.docLink/>">${Request.document.title}</a></h2>
            <#else>
              <h2 class="h2-section-title">${Request.document.title}</h2>
            </#if>
            <h3 class="h3-section-info">${Request.document.text}</h3>
          </div>
          <div class="col-md-6 col-sm-6 animated fadeInRightBig animatedVisi" data-animtype="fadeInRightBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <div class="right-image-container">
              <img src="<@hst.link hippobean=Request.document.image/>" height="300" alt="" />
            </div>
          </div>
      </div>
    </div>
  </div>

    <#if Request.separatorBorderTop>
        <#assign cssClass> border-top</#assign>
    </#if>
    <#if Request.separatorBorderBottom>
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
  <h2 class="not-configured">Click to configure banner</h2>
</#if>
