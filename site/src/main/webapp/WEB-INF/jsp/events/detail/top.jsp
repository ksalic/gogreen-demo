<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:link var="events" siteMapItemRefId="events" />
<h1 class="h1-page-title"><a href="${events}"><fmt:message key="events.overview.title"/></a></h1>

<c:if test="${not empty requestScope.document}">
    <h2 class="h2-page-desc">
        <c:out value="${requestScope.document.title}"/>
    </h2>
</c:if>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="events.overview.location.home"/></a>
        </li>
        <li class="active"><a href="${events}"><fmt:message key="events.latest.label"/></a></li>
    </ol>
</div>