<#include "../../include/imports.ftl">
<#if images??>
  <#if  title??>
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
  <div class="section-content section-px">
  <div class="container images-component">
    <div class="row">
      <div class="col-md-12 col-sm-12">
        <ul class="section-clients">
          <#list images as doc>
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
  <#if test="${separatorBorderTop}">
    <#assign cssClass> border-top</#assign>
  </#if>
  <#if test="${separatorBorderBottom}">
    <#assign cssClass>${cssClass} border-bottom</#assign>
  </#if>

  <#if separatorMargin?? && cssClass??>
    <div class="space-sep ${separatorMargin} ${cssClass}"></div>
  <#elseif separatorMargin??>
    <div class="space-sep ${separatorMargin}"></div>
  <#elseif cssClass??>
    <div class="space-sep ${cssClass}"></div>
  </#if>

<#elseif preview??>
  <h2 class="not-configured">Click to configure Image component</h2>
</#if>

