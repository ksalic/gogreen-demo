<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<h1 class="h1-page-title">
    <a href="<hst:link siteMapItemRefId="about"/>"><fmt:message key="about.title" var="abouttitle"/> <c:out value="abouttitle"/></a>
</h1>

<h2 class="h2-page-desc">
    <fmt:message key="about.subtitle" var="aboutsubtitle"/> <c:out value="aboutsubtitle"/>
</h2>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="news.overview.content.location.home" var="locationhome"/> <c:out value="locationhome"/></a>
        </li>
        <li class="active"><a href="<hst:link siteMapItemRefId="about"/>">About</a></li>
    </ol>
</div>