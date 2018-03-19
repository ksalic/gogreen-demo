<#include "../../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
-->

<h1 class="h1-page-title">
    <a href="<@hst.link siteMapItemRefId="resellerfaq"/>"><@fmt.message key="faq.overview.content.title" var="contenttitle"/> ${contenttitle?html}</a>
</h1>

<h2 class="h2-page-desc">
    <@fmt.message key="faq.overview.content.subtitle" var="contentsubtitle"/> ${contentsubtitle?html}
</h2>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<@hst.link siteMapItemRefId="home"/>"><@fmt.message key="faq.overview.content.location.home" var="locationhome"/> ${locationhome?html}</a>
        </li>
        <li class="active"><a href="<@hst.link siteMapItemRefId="resellerfaq"/>"><@fmt.message key="faq.overview.content.title" var="contenttitle"/> ${contenttitle?html}</a></li>
    </ol>
</div>