<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:link var="products" siteMapItemRefId="products"/>
<fmt:message key="products.main.title" var="title"/>
<h1 class="h1-page-title">
  <a href="${products}">${title}</a>
</h1>
<hippo-gogreen:title title="${title}"/>

<h2 class="h2-page-desc">
    <fmt:message key="products.main.subtitle"/>
</h2>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="products.overview.location.home"/></a>
        </li>
        <li class="active"><a href="${products}"><fmt:message key="products.overview.title"/></a></li>
    </ol>
</div>

