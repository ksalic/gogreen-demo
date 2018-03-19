<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<h1 class="h1-page-title">
    <a href="<hst:link siteMapItemRefId="news"/>"><fmt:message key="news.overview.content.title" var="contentTitle"/><c:out value="${contentTitle}"/></a>
</h1>

<h2 class="h2-page-desc">
    <fmt:message key="news.overview.content.subtitle" var="contentSubtitle"/><c:out value="${contentSubtitle}"/>
</h2>

<c:if test="${not empty requestScope.document}">
    <h2 class="h2-page-desc">
        <c:out value="${requestScope.document.title}"/>
    </h2>
</c:if>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="news.overview.content.location.home" var="locationHome"/><c:out value="${locationHome}"/></a>
        </li>
        <li class="active"><a href="<hst:link siteMapItemRefId="news"/>"><c:out value="${contentTitle}"/></a></li>
    </ol>
</div>