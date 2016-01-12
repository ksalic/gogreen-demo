<#include "../include/imports.ftl">
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
<div class="banner-component section-content no-padding">
    <div class="container">
        <div class="row">
            <@hst.cmseditlink hippobean=Request.document/>
            <div class="col-md-12 col-sm-12 animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                <#if Request.document.docLink??>
                    <h2 class="h2-section-title"><a href="<@hst.link hippobean=Request.document.docLink/>">${Request.document.title}</a></h2>
                <#else>
                    <h2 class="h2-section-title">${Request.document.title}</h2>
                </#if>
                <#if Request.document.bannerIcon??>
                    <div class="i-section-title">
                        <i class="fa ${Request.bannerIcon}">

                        </i>
                    </div>
                </#if>
                <h3 class="h3-section-info">${Request.document.text?html}</h3>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 no-bottom-margin animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.7s" style="-webkit-animation: 1s 0.7s;">
                    <div class="align-center">
                        <#if Request.document.image??>
                            <img src="<@hst.link hippobean=Request.document.image.banner/>" alt="<@fmt.message key=Request.document.image.alt/>" class="img-responsive"/>
                        </#if>
                    </div>
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
    <#if Request.separatorMargin??>
    <#else>

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
