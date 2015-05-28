<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

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

<%@include file="../includes/tags.jspf" %>

<c:set var="resttitle"><fmt:message key="restapi.documentation.title"/></c:set>
<hippo-gogreen:title title="${resttitle}"/>

<hst:cmseditlink hippobean="${requestScope.text}" />
<h2 class="h2-section-title"><c:out value="${requestScope.text.title}"/></h2>
<div class="i-section-title"></div>

<p><c:out value="${requestScope.text.summary}"/></p>
<p><hst:html hippohtml="${requestScope.document.description}"/></p>

<c:if test="${not empty requestScope.documents}">
    <c:forEach items="${requestScope.documents}" var="document">
        <hst:cmseditlink hippobean="${document}" />
        <hst:link var="link" hippobean="${document}"/>
        <p><a href="${link}"><c:out value="${document.apiPath}"/></a></p>
        <p><c:out value="${document.summary}"/></p>
    </c:forEach>
</c:if>