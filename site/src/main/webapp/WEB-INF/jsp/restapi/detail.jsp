<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

            http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.Product"--%>
<%@include file="../includes/tags.jspf" %>

<c:set var="datePattern" value="dd-MM-yyyy"/>

<hippo-gogreen:title title="REST API - ${document.apiPath}"/>

<hst:link var="sh" path="/js/syntaxhighlighter_3.0.83" />
<script type="text/javascript" src="${sh}/scripts/shCore.js"></script> 
<script type="text/javascript" src="${sh}/scripts/shBrushJScript.js"></script> 
<link type="text/css" rel="stylesheet" href="${sh}/styles/shCoreDefault.css"/> 

<h2 class="h2-section-title"><c:out value="${document.apiPath}"/></h2>
<div class="i-section-title"></div>

<div id="restapidoc" class="restapidoc-item <c:if test="${preview}">editable</c:if>">
    <hst:cmseditlink hippobean="${document}" />

    <h3><fmt:message key="restapi.detail.type" /></h3>
    <p><c:out value="${document.type}" /></p>

    <h3><fmt:message key="restapi.detail.description" /></h3>
    <p><c:out value="${document.summary}"/></p>

    <h3><fmt:message key="restapi.detail.documentation" /></h3>
    <p><hst:html hippohtml="${document.documentation}"/></p>

    <h3><fmt:message key="restapi.detail.url" /></h3>
    <p><c:out value="${document.url}"/></p>

    <h3><fmt:message key="restapi.detail.response" /></h3>
    <pre class="brush: js"><c:out value="${document.response}"/></pre>

</div>

<script type="text/javascript">SyntaxHighlighter.all();</script>