<#include "../../include/imports.ftl">
<#if banners??>
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
<#-- COL SIZE-->
    <#if banners?size == 1>
        <#assign colSize=12/>
    <#elseif banners?size == 2>
        <#assign colSize=6/>
    <#elseif banners?size == 3>
        <#assign colSize=4/>
    <#elseif banners?size == 4>
        <#assign colSize=3/>
    </#if>
    <#if banners?size % 2 == 0>
        <#assign bannerCount=banners?size / 2.0 />
    <#else>
        <#assign bannerCount=(banners?size - 1.0 ) / 2.0 /></#if>

<div class="section-content no-padding">
<#-- START MARKUP-->
    <div class="container">
        <div class="row">
            <#list banners as banner>
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
                <@fmt.setBundle basename="messages"/>

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
    <#if separatorBorderTop>
        <#assign cssClass> border-top</#assign>
    </#if>
    <#if separatorBorderBottom>
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
    <h2 class="not-configured">Click to configure banner collection</h2>
</#if>