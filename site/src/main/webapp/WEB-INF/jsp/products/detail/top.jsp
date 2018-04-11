<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:link var="products" siteMapItemRefId="products"/>
<h1 class="h1-page-title">
    <a href="${products}"><fmt:message key="products.main.title" var="mainTitle"/><c:out value="${mainTitle}"/></a>
</h1>

<c:if test="${not empty requestScope.document}">
    <h2 class="h2-page-desc">
        <c:out value="${requestScope.document.title}"/>
    </h2>
</c:if>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="products.overview.location.home" var="locationHome"/><c:out value="${locationHome}"/></a>
        </li>
        <li class="active"><a href="${products}"><fmt:message key="products.overview.title" var="overviewTitle"/><c:out value="${overviewTitle}"/></a></li>
    </ol>
</div>

