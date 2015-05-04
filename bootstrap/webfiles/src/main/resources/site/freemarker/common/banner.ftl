<#include "../include/imports.ftl">
<#if document??>
    <#if title?? && title!=''>
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h2 class="h2-section-title">
            ${title}
            </h2>
            <#if icon??>
                <div class="i-section-title">
                    <i class="fa  ${icon}"></i>
                </div>
            </#if>
        </div>
    </div>
    </#if>
<div class="banner-component section-content no-padding">
    <div class="container">
        <div class="row">
            <@hst.cmseditlink hippobean=document/>
            <div class="col-md-12 col-sm-12 animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                <#if document.docLink??>
                    <h2 class="h2-section-title"><a href="<@hst.link hippobean=document.docLink/>">${document.title}</a></h2>
                <#else>
                    <h2 class="h2-section-title">${document.title}</h2>
                </#if>
                <#if document.bannerIcon??>
                    <div class="i-section-title">
                        <i class="fa ${bannerIcon}">

                        </i>
                    </div>
                </#if>
                <h3 class="h3-section-info">${document.text}</h3>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 no-bottom-margin animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.7s" style="-webkit-animation: 1s 0.7s;">
                    <div class="align-center">
                        <#if document.image??>
                            <img src="<@hst.link hippobean=document.image.banner/>" alt="<@fmt.message key=document.image.alt/>" class="img-responsive"/>
                        </#if>
                    </div>
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
