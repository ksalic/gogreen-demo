<%--
    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)
--%>
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.Product"--%>
<%@include file="../includes/tags.jspf" %>

<c:set var="datePattern" value="dd-MM-yyyy"/>

<hippo-gogreen:title title="REST API - ${requestScope.document.apiPath}"/>

<hst:link var="sh" path="/js/syntaxhighlighter_3.0.83" />
<script type="text/javascript" src="${sh}/scripts/shCore.js"></script> 
<script type="text/javascript" src="${sh}/scripts/shBrushJScript.js"></script> 
<link type="text/css" rel="stylesheet" href="${sh}/styles/shCoreDefault.css"/> 

<h2 class="h2-section-title"><c:out value="${requestScope.document.apiPath}"/></h2>
<div class="i-section-title"></div>

<div id="restapidoc" class="restapidoc-item <c:if test="${requestScope.preview}">editable</c:if>">
    <hst:manageContent hippobean="${requestScope.document}" />

    <h3><fmt:message key="restapi.detail.type" var="detailtype"/> <c:out value="detailtype"/></h3>
    <p><c:out value="${requestScope.document.type}" /></p>

    <h3><fmt:message key="restapi.detail.description" var="detaildescription"/> <c:out value="detaildescription"/></h3>
    <p><c:out value="${requestScope.document.summary}"/></p>

    <h3><fmt:message key="restapi.detail.documentation" var="detaildocumentation"/> <c:out value="detaildocumentation"/></h3>
    <p><hst:html hippohtml="${requestScope.document.documentation}"/></p>

    <h3><fmt:message key="restapi.detail.url" var="detailurl"/> <c:out value="detailurl"/></h3>
    <p><c:out value="${requestScope.document.url}"/></p>

    <h3><fmt:message key="restapi.detail.response" var="detailresponse"/> <c:out value="detailresponse"/></h3>
    <pre class="brush: js"><c:out value="${requestScope.document.response}"/></pre>

</div>

<script type="text/javascript">SyntaxHighlighter.all();</script>