<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#if  Request.document??>
    <#if Request.document.image??>
        <div class="banner-component section-content full-banner no-padding" style="background-image: url('<@hst.link hippobean=Request.document.image.original/>')">
            <@hst.cmseditlink hippobean=Request.document/>
        </div>
    </#if>

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
        <div class="space-sep ${Request.separatorMargin} ${cssClass}"></div>
    <#elseif separatorMargin??>
        <div class="space-sep ${Request.separatorMargin}"></div>    <#elseif cssClass??>
        <div class="space-sep ${cssClass}"></div>
    </#if>
    <#elseif Request.preview??>
        <h2 class="not-configured">Click to configure banner</h2>
    </#if>
