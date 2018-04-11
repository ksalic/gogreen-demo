<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<h1 class="h1-page-title">
    <fmt:message key="search.results.title" var="resultsTitle"/><c:out value="${resultsTitle}"/>
</h1>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="products.detail.location.home" var="locationHome"/><c:out value="${locationHome}"/></a>
        </li>
        <li class="active"><a href="<hst:link siteMapItemRefId="search"/>"><fmt:message key="search.results.shorttitle" var="resultsShorttitle"/><c:out value="${resultsShorttitle}"/></a></li>
    </ol>
</div>