<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<h1 class="h1-page-title">
    <fmt:message key="restapi.main.location.label" var="locationlabel"/> <c:out value="locationlabel"/>
</h1>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li><hst:link var="home" siteMapItemRefId="home" /><a href="${home}"><fmt:message key="restapi.main.location.home" var="locationhome"/> <c:out value="locationhome"/></a></li>
        <li><hst:link var="rest" siteMapItemRefId="restapi" /><fmt:message key="restapi.main.location.rest" var="locationrest"/> <c:out value="locationrest"/></li>
    </ol>
</div>