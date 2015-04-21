<#include "../../include/imports.ftl">
<#if  document??>
    <#if document.image??>
        <div class="banner-component section-content full-banner no-padding" style="background-image: url('<@hst.link hippobean=document.image.original/>')">
            <@hst.cmseditlink hippobean=document/>
        </div>
    </#if>

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
