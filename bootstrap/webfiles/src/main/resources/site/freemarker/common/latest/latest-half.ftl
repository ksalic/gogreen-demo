<#include "../../include/imports.ftl">
<#if items??>
  <#if (items?size > 0)>

    <#assign colSize=6/>

  <div class="container">
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

    <div class="row latest-items">
      <#list items as item>
        <div class="col-md-${colSize} col-sm-${colSize}">
          <@hst.cmseditlink hippobean=item/>
          <div class="feature">

            <div class="feature-content">
              <h3 class="h3-body-title blog-title">
                <a href="<@hst.link hippobean=item/>">
                ${item.title}
                </a>
              </h3>
              <p>
              ${item.summary}
              </p>
            </div>
            <div class="feature-details">
              <i class="icon-calendar"></i>
              <span>
                <@fmt.formatDate value=item.date.time pattern="MMMM d, YYY"/>
              </span>
            </div>
          </div>
        </div>
      </#list>
    </div>
  </div>

    <#if separatorBorderTop??>
      <#assign cssClass> border-top</#assign>
    </#if>
    <#if separatorBorderBottom??>
      <#assign cssClass>${cssClass} border-bottom</#assign>
    </#if>
    <#if separatorMargin?? && cssClass??>
    <div class="space-sep ${separatorMargin} ${cssClass}"></div>
    <#elseif separatorMargin??>
    <div class="space-sep ${separatorMargin}"></div>
    <#elseif cssClass??>
    <div class="space-sep ${cssClass}"></div>
    </#if>
  </#if>
</#if>