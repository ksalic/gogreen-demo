<%--

    Copyright 2011-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<c:if test="${not empty requestScope.logo and not empty requestScope.logo.mobileLogo}">
    <hst:link var="logoSrc" hippobean="${requestScope.logo.mobileLogo}"/>
    <h1><img src="${logoSrc}" alt="${fn:escapeXml(requestScope.logo.alt)}" class="logo" width="${requestScope.logo.mobileLogo.width}" height="${requestScope.logo.mobileLogo.height}" /></h1>
</c:if>
