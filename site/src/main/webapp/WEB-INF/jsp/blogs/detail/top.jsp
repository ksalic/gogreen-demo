<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<h1 class="h1-page-title">
    <a href="<hst:link siteMapItemRefId="blogs"/>"><fmt:message key="blogs.overview.content.title"/></a>
</h1>

<c:if test="${not empty requestScope.document}">
    <h2 class="h2-page-desc">
        <c:out value="${requestScope.document.title}"/>
    </h2>
    <hippo-gogreen:title title="${requestScope.document.title}"/>
</c:if>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="news.overview.content.location.home"/></a>
        </li>
        <li class="active"><a href="<hst:link siteMapItemRefId="blogs"/>"><fmt:message key="blogs.overview.content.title"/></a></li>
    </ol>
</div>