<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<h1 class="h1-page-title">
    <fmt:message key="restapi.main.location.label"/></li>
</h1>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li><hst:link var="home" siteMapItemRefId="home" /><a href="${home}"><fmt:message key="restapi.main.location.home"/></a></li>
        <li><hst:link var="rest" siteMapItemRefId="restapi" /><fmt:message key="restapi.main.location.rest"/></li>
    </ol>
</div>