<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
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
                        <@hst.link var="docLink" path="${path}/${category}/${banner.docLink.localizedName}"/>
                    <#else>
                        <@hst.link var="docLink" hippobean=banner.docLink/>
                    </#if>
                </#if>
                <@hst.setBundle basename="messages"/>

                <#if banner_index==0>
            <div class="col-md-6 col-sm-6 right-text">
                <ul class="icon-content-list-container">
                </#if>

                <#if bannerCount !=0 && banner_index == bannerCount>
                </ul>
            </div>
            <div class="col-md-6 col-sm-6">
                <ul class="icon-content-list-container">
                </#if>

                    <li class="icon-content-single">
                        <div class="content-box style5 animated fadeIn animatedVisi" data-animtype="fadeIn" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.2s" style="-webkit-animation: 1s 0.2s;">
                            <h4 class="h4-body-title">
                                <#if docLink??>
                                    <a href="${docLink}">
                                </#if>
                                ${banner.title}
                                <#if banner.icon??>
                                    <i class="${banner.icon}"></i>
                                <#else>
                                    <img src="<@hst.link hippobean=banner.image.thumbnail/>" class="icon-replacement">
                                </#if>
                                <#if docLink??>
                                    </a>
                                </#if>
                            </h4>
                            <div class="content-box-text">
                                <p>${banner.text}
                                <@hst.cmseditlink hippobean=banner />
                                </p>
                            </div>
                        </div>
                    </li>
                    <#if !banner_has_next>
                </ul>
            </div>
                    </#if>
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
    <#elseif Request.separatorMargin??>
    <div class="space-sep ${Request.separatorMargin}"></div>
    <#elseif cssClass??>
    <div class="space-sep ${cssClass}"></div>
    </#if>

<#elseif Request.preview??>
    <h2 class="not-configured">Click to configure banner collection</h2>
</#if>