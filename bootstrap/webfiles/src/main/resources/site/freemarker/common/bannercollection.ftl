<#include "../include/imports.ftl">
<#if banners??>

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
<#-- COL SIZE-->
  <#if banners?size == 1>
    <#assign colSize=12/>
  <#elseif banners?size == 2>
    <#assign colSize=6/>
  <#elseif banners?size == 3>
    <#assign colSize=4/>
  <#elseif banners?size == 4>
    <#assign colSize=3/>
  </#if>
  <#if banners?size % 2 == 0>
    <#assign bannerCount=banners?size / 2.0 />
  <#else>
    <#assign bannerCount=(banners?size - 1.0 ) / 2.0 /></#if>
<#-- START MARKUP-->
<div class="container">
  <div class="row">
    <#list banners as banner>
      <@hst.setBundle basename="products.facet"/>
      <#assign docLink=""/>
      <#if banner.docLink??>
        <#if banner.docLink.hippoFolderBean??>
          <@fmt.message var="path" key="path"/>
          <@fmt.message var="category" key="category"/>
          <@hst.link var="docLink" path="${path}/${category}/${banner.docLink.localizedName}"/>
        <#else>
          <@hst.link var="docLink" hippobean=banner.docLink/>
        </#if>
      </#if>
      <@fmt.setBundle basename="messages"/>
      <div class="col-md-${colSize} col-sm-${colSize}">
        <div class="feature product-category">
          <div class="feature-content">
            <#if  docLink??>
              <h3 class="h3-body-title"><a href="${docLink}">
              ${banner.title}
              </a>
              </h3>
            <#else>
              <h3 class="h3-body-title">
              ${banner.title}
              </h3>
            </#if>
          </div>
          <div class="feature-image">
            <hst:cmseditlink hippobean="${banner}"/>
            <#if banner.image??>
              <#if docLink??>
                <a href="${docLink}">
                  <img src="<@hst.link hippobean=banner.image.largeThumbnail/>" alt="${banner.image.alt}"/>
                </a>
              <#else>
                <img src="<@hst.link hippobean=banner.image.largeThumbnail/>" alt="${banner.image.alt}"/>
              </#if>
            </#if>
          </div>
        </div>
      </div>
    </#list>
  </div>
</div>
<#-- END MARKUP-->
  <#if separatorBorderTop??>
    <#assign cssClass> border-top</#assign>
  </#if>
  <#if  separatorBorderBottom??>
    <#assign cssClass>${cssClass} border-bottom</#assign>
  </#if>
  <#if separatorMargin?? && cssClass??>
  <div class="space-sep ${separatorMargin} ${cssClass}"></div>
  <#elseif separatorMargin??>
  <div class="space-sep  ${cssClass}"></div>
  <#elseif cssClass??>
  <div class="space-sep  ${cssClass}"></div>
  </#if>

<#elseif preview??>
<h2 class="not-configured">Click to configure banner collection</h2>
</#if>






