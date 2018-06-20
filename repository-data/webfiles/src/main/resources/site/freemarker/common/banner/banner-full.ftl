<#include "../../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
-->
<#if  Request.document??>
    <#if Request.document.image??>
        <div class="banner-component section-content full-banner no-padding" style="background-image: url('<@hst.link hippobean=Request.document.image.original/>')">
            <@hst.manageContent hippobean=Request.document templateQuery="new-banner" defaultPath="common/banners" parameterName="bannerlocation"/>
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
<#elseif editMode>
    <div class="not-configured">
        <h2>Click to configure banner</h2>
        <@hst.manageContent templateQuery="new-banner" defaultPath="common/banners" parameterName="bannerlocation"/>
    </div>
</#if>
