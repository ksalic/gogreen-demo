<#include "../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
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
          <i class="fa  ${Request.icon?html}"></i>
        </div>
      </#if>
    </div>
  </div>
  </#if>
<div class="banner-component section-content no-padding">
  <div class="container">
    <div class="row">
      <@hst.manageContent hippobean=Request.document templateQuery="new-document" parameterName="documentlocation" />
      <div class="col-md-12 col-sm-12 animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
        <#--Create a link to the detail page of this document-->
          <@hst.link hippobean=Request.document var="docLink"/>
        <#if docLink??>
          <h2 class="h2-section-title"><a href="${docLink}">${Request.document.title?html}</a></h2>
        <#else>
          <h2 class="h2-section-title">${Request.document.title?html}</h2>
        </#if>
        <#if Request.document.bannerIcon??>
          <div class="i-section-title">
            <i class="fa ${Request.bannerIcon?html}">

            </i>
          </div>
        </#if>
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
  <#if Request.separatorMargin??>
  <#else>

  </#if>
  <#if Request.separatorMargin?? && cssClass??>
  <div class="space-sep ${Request.separatorMargin?html} ${cssClass}"></div>
  <#elseif Request.separatorMargin??>
  <div class="space-sep ${Request.separatorMargin?html}"></div>
  <#elseif cssClass??>
  <div class="space-sep ${cssClass}"></div>
  </#if>
<#elseif editMode>
<h2 class="not-configured">Click to configure Document Highlight</h2>
</#if>
