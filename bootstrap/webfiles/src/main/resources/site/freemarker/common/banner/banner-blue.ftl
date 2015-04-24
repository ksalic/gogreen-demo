<#include "../../include/imports.ftl">
<#if  document??>
  <#if  title??>
  <div class="row">
    <div class="col-md-12 col-sm-12">
      <h2 class="h2-section-title">
      ${title}
      </h2>
      <#if  icon??>
        <div class="i-section-title">
          <i class="fa  ${icon}"></i>
        </div>
      </#if>
    </div>
  </div>
  </#if>
  <div class="banner-component section-content section-color-dark-blue white-text">
    <div class="container">
      <div class="row">
        <@hst.cmseditlink hippobean=document/>
          <div class="col-md-6 col-sm-6 animated fadeInLeftBig animatedVisi" data-animtype="fadeInLeftBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <div class="space-sep100"></div>
            <#if document.docLink??>
              <h2 class="h2-section-title"><a href="<@hst.link hippobean=document.docLink/>">${document.title}</a></h2>
            <#else>
              <h2 class="h2-section-title">${document.title}</h2>
            </#if>
            <h3 class="h3-section-info">${document.text}</h3>
          </div>
          <div class="col-md-6 col-sm-6 animated fadeInRightBig animatedVisi" data-animtype="fadeInRightBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <div class="right-image-container">
              <img src="<@hst.link hippobean=document.image/>" height="300" alt="" />
            </div>
          </div>
      </div>
    </div>
  </div>


  <#if separatorBorderTop>
    <#assign cssClass> border-top</#assign>
  </#if>
  <#if separatorBorderBottom>
    <#assign cssClass>${cssClass} border-bottom</#assign>
  </#if>
  <#if separatorMargin??>
  <#else>

  </#if>
  <#if separatorMargin?? && cssClass??>
    <div class="space-sep ${separatorMargin} ${cssClass}"></div>
  <#elseif separatorMargin??>
    <div class="space-sep ${separatorMargin}"></div>    <#elseif cssClass??>
    <div class="space-sep ${cssClass}"></div>
  </#if>
<#elseif preview??>
  <h2 class="not-configured">Click to configure banner</h2>
</#if>
