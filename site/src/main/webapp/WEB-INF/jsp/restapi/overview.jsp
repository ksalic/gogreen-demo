<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:set var="resttitle"><fmt:message key="restapi.main.title"/></c:set>

<hst:cmseditlink hippobean="${requestScope.document}" />
<h2 class="h2-section-title"><c:out value="${requestScope.document.title}"/></h2>
<div class="i-section-title"></div>

<hippo-gogreen:title title="${requestScope.document.title}" />
<p><c:out value="${requestScope.document.summary}"/></p>
<p><hst:html hippohtml="${requestScope.document.description}"/></p>