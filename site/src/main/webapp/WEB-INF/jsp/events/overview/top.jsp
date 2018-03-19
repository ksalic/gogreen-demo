<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:link var="events" siteMapItemRefId="events" />
<h1 class="h1-page-title">
  <a href="${events}"><fmt:message key="events.overview.title" var="overviewTitle"/><c:out value="${overviewTitle}"/></a>
</h1>

<h2 class="h2-page-desc">
    <fmt:message key="events.overview.subtitle" var="overviewSubitle"/><c:out value="${overviewSubitle}"/>
</h2>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="events.overview.location.home" var="locationHome"/><c:out value="${locationHome}"/></a>
        </li>
        <li class="active"><a href="${events}"><fmt:message key="events.latest.label" var="latestLabel"/><c:out value="${latestLabel}"/></a></li>
    </ol>
</div>