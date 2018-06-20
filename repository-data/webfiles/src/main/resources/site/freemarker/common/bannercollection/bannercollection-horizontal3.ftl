<#include "../../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.banners?? && (Request.banners?size > 0)>
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
<#-- COL SIZE-->
    <#assign colSize = 12 / Request.banners?size/>
    <#if Request.banners?size % 2 == 0>
        <#assign bannerCount=Request.banners?size / 2.0 />
    <#else>
        <#assign bannerCount=(Request.banners?size - 1.0 ) / 2.0 /></#if>

<div class="section-content no-padding">
<#-- START MARKUP-->
    <div class="container">
        <div class="row">
            <#list Request.banners as banner>
                <@hst.setBundle basename="products.facet"/>
                <#if banner.docLink??>
                    <#if banner.docLink.hippoFolderBean??>
                        <@fmt.message var="path" key="path"/>
                        <@fmt.message var="category" key="category"/>
                        <@hst.link var="docLink" path="${path?html}/${category?html}/${banner.docLink.localizedName?html}"/>
                    <#else>
                        <@hst.link var="docLink" hippobean=banner.docLink/>
                    </#if>
                </#if>
                <@hst.setBundle basename="messages"/>
                <div class="col-md-${colSize} col-sm-${colSize}">
                    <div class="content-box style5 small  animated fadeIn animatedVisi" data-animtype="fadeIn" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.2s" style="-webkit-animation: 1s 0.2s;">
                        <h4 class="h4-body-title">
                            <#if banner.icon??>
                                <i class="${banner.icon}"></i>
                            <#elseif banner.image??>
                                <img src="<@hst.link hippobean=banner.image.thumbnail/>" alt="<#if banner.image.alt??>${banner.image.alt?html}</#if>" class="icon-replacement">
                            </#if>
                        ${banner.title}
                        </h4>

                        <div class="content-box-text">
                            ${banner.text}
                            <@hst.manageContent hippobean=banner templateQuery="new-banner" defaultPath="common/banners"/>
                            <#if docLink??>
                                <div>
                                    <a href="${docLink}" class="read-more">
                                        <span><@fmt.message key="common.read.more" var="readmore"/> ${readmore?html}</span>
                                    </a>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</div>

<#-- END MARKUP-->
    <#if Request.separatorBorderTop>
        <#assign cssClass> border-top</#assign>
    </#if>
    <#if Request.separatorBorderBottom>
        <#assign cssClass>${cssClass} border-bottom</#assign>
    </#if>
    <#if Request.separatorMargin?? && cssClass??>
    <div class="space-sep ${Request.separatorMargin} ${cssClass}"></div>
    <#elseif separatorMargin??>
    <div class="space-sep ${Request.separatorMargin}"></div>
    <#elseif cssClass??>
    <div class="space-sep ${cssClass}"></div>
    </#if>

<#elseif editMode>
    <div class="not-configured">
        <h2>Click to configure banner collection</h2>
        <@hst.manageContent templateQuery="new-banner" defaultPath="common/banners" parameterName="banner1"/>
    </div>
</#if>