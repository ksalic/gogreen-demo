<#include "../include/imports.ftl">
<#import "../macro/macro.imagecopyright.ftl" as imageCopyright >
<#import "../macro/macro.copyright.ftl" as copyright >
<div class="blog-post">
  <div class="blog-post-type">
    <i class="icon-news"> </i>
  </div>
  <div class="blog-span">
  <@hst.cmseditlink hippobean=document/>
  <#assign image=document.firstImage/>
  <#if image?? && image.landscapeImage??>
    <div class="blog-post-featured-img img-overlay">
      <@hst.link var="src" hippobean=image.landscapeImage/>
      <@hst.link var="imgOrig" hippobean=image.original/>
      <img class="img-responsive" src="${src}" alt="${image.alt}"/>
      <@imageCopyright.imageCopyright image=image/>
      <div class="item-img-overlay">
        <a class="portfolio-zoom icon-zoom-in" href="${imgOrig}" data-rel="prettyPhoto[portfolio]" title="${image.alt}"></a>
      </div>
    </div>
  </#if>

    <h2>${document.title}</h2>

    <div class="blog-post-body">
    ${document.summary}
      <@hst.html hippohtml=document.description/>
      <@copyright.copyright document=document/>
    </div>

    <div class="blog-post-details">
      <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
        <span class="date">
        <@fmt.formatDate value=document.date.time type="date" pattern="d MMMM, yyyy"/>
        </span>
      </div>
      <div class="blog-post-details-item blog-post-details-item-left blog-post-details-item-last icon-comment">
      <#if commentCount gt 0>
      ${commentCount}
        &nbsp;
        <@fmt.message key="news.detail.content.commentsfound"/>
        <#if commentCount gt 1>
          <@fmt.message key="news.detail.content.commentsplural"/>
        </#if>
      <#else>
        <@fmt.message key="news.detail.content.nocomments"/>
      </#if>
      </div>
    </div>
    <!-- If there are any tags for this document, then display them with links -->
  <#if  document.tags??>
    <@hst.setBundle basename="general.text"/>
    <div class="tags">
      <#list document.tags as tag>
        <@hst.link siteMapItemRefId="search-faceted" var="link"/>
        <@fmt.message key="search.facet.tags" var="tagname"/>
        <a href="${link}/${tagname}/${tag}">${tag}</a>
      </#list>
    </div>
  </#if>
  </div>
</div>

<@hst.include ref="comments"/>
