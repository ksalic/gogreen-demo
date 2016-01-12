<#include "../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#import "../macro/macro.imagecopyright.ftl" as imageCopyright >
<#import "../macro/macro.copyright.ftl" as copyright >
<div class="blog-post">
  <div class="blog-post-type">
    <i class="icon-news"> </i>
  </div>
  <div class="blog-span">
  <@hst.cmseditlink hippobean=Request.document/>
  <#assign image=Request.document.firstImage/>
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

    <h2>${Request.document.title?html}</h2>

    <div class="blog-post-body">
    ${Request.document.summary?html}
      <#if Request.document.description??>
        <@hst.html hippohtml=Request.document.description/>
      <#elseif Request.document.contentBlocks??>
        <#list Request.document.contentBlocks as block>
          <#if block.type == "quote">
            <div class="quote ${block.alignment?lower_case}">${block.quote?html}</div>
          <#elseif block.type == "image"  >
            <@hst.link var="img" hippobean=block.image.original/>
            <figure class="${block.alignment?lower_case}">
              <img src="${img}" title="${block.image.fileName?html}"
                   alt="${block.image.fileName?html}"/>
              <#if block.image.description??><figcaption>${block.image.description?html}</figcaption></#if>
            </figure>
          <#elseif block.type == "paragraph">
            <h2>${block.header?html}</h2>
            <p>${block.text?html}</p>
          </#if>
        </#list>
      </#if>
      <@copyright.copyright document=Request.document/>
    </div>

    <div class="blog-post-details">
      <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
        <span class="date">
        <@hst.setBundle basename="messages"/>
        <@fmt.message key="standard.date.format" var="dateformat"/>
        <@fmt.formatDate value=Request.document.date.time type="date" pattern=dateformat/>
        </span>
      </div>
      <div class="blog-post-details-item blog-post-details-item-left blog-post-details-item-last icon-comment">
      <@hst.setBundle basename="messages"/>
      <#if Request.commentCount gt 0>
      ${Request.commentCount}
        &nbsp;
        <@fmt.message key="blogs.detail.content.commentsfound"/>
        <#if Request.commentCount gt 1>
          <@fmt.message key="blogs.detail.content.commentsplural"/>
        </#if>
      <#else>
        <@fmt.message key="blogs.detail.content.nocomments"/>
      </#if>
      </div>
    </div>

    <!-- If there are any tags for this document, then display them with links -->
  <#if Request.document.categories??>
    <@hst.setBundle basename="messages"/>
    <div class="tags">
      <#list Request.document.categories as tag>
        <@hst.link siteMapItemRefId="search-faceted" var="link"/>
        <@fmt.message key="search.facet.category" var="tagname"/>
        <a href="${link}/${tagname}/${tag}">${tag}</a>
      </#list>
    </div>
  </#if>
  </div>
</div>


<@hst.include ref="comments"/>
