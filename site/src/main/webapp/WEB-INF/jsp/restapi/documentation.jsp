<%--
    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../includes/tags.jspf" %>

<c:set var="resttitle"><fmt:message key="restapi.documentation.title" var="documentationtitle"/> <c:out value="documentationtitle"/></c:set>
<hippo-gogreen:title title="${resttitle}"/>

<hst:manageContent hippobean="${requestScope.text}" />
<h2 class="h2-section-title"><c:out value="${requestScope.text.title}"/></h2>
<div class="i-section-title"></div>

<p><c:out value="${requestScope.text.summary}"/></p>
<p><hst:html hippohtml="${requestScope.document.description}"/></p>

<c:if test="${not empty requestScope.documents}">
    <c:forEach items="${requestScope.documents}" var="document">
        <hst:manageContent hippobean="${document}" />
        <hst:link var="link" hippobean="${document}"/>
        <p><a href="${link}"><c:out value="${document.apiPath}"/></a></p>
        <p><c:out value="${document.summary}"/></p>
    </c:forEach>
</c:if>