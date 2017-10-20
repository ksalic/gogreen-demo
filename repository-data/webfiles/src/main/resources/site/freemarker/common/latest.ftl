<#include "../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.items??>
  <#if (Request.items?size > 0)>
    <#assign colSize = 12 / Request.items?size/>
  <div class="container">
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

    <div class="row latest-items">
      <#list Request.items as item>
        <div class="col-md-${colSize} col-sm-${colSize}">
          <@hst.cmseditlink hippobean=item/>
          <div class="feature">

            <div class="feature-content">
              <h3 class="h3-body-title blog-title">
                <a href="<@hst.link hippobean=item/>">
                ${item.title?html}
                </a>
              </h3>
              <p>
              ${item.summary?html}
              </p>
            </div>
            <div class="feature-details">
              <i class="icon-calendar"></i>
              <span>
                <@hst.setBundle basename="messages"/>
                <@fmt.message key="standard.date.format" var="dateformat"/>
                <@fmt.formatDate value=item.date.time pattern=dateformat/>
              </span>
            </div>
          </div>
        </div>
      </#list>
    </div>
  </div>

      <#if Request.separatorBorderTop>
          <#assign cssClass> border-top</#assign>
      </#if>
      <#if Request.separatorBorderBottom>
          <#assign cssClass>${cssClass} border-bottom</#assign>
      </#if>
      <#if Request.separatorMargin?? && cssClass??>
      <div class="space-sep ${separatorMargin} ${cssClass}"></div>
      <#elseif Request.separatorMargin??>
      <div class="space-sep ${Request.separatorMargin}"></div>
      <#elseif cssClass??>
      <div class="space-sep ${cssClass}"></div>
      </#if>
  </#if>
</#if>