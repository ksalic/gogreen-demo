<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<h1 class="h1-page-title">
  <a href="<hst:link siteMapItemRefId="blogs"/>"><fmt:message key="blogs.overview.content.title" var="contentTitle"/><c:out value="${contentTitle}"/></a>
</h1>

<h2 class="h2-page-desc">
    <fmt:message key="blogs.overview.content.subtitle" var="contentSubtitle"/><c:out value="${contentSubtitle}"/>
</h2>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="blogs.overview.content.location.home" var="locationhome"/><c:out value="${locationhome}"/></a>
        </li>
        <li class="active"><a href="<hst:link siteMapItemRefId="blogs"/>"><c:out value="${contentTitle}"/></a></li>
    </ol>
</div>