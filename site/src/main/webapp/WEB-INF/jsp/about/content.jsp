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

<%@include file="../includes/tags.jspf" %>

<c:set var="abouttitle"><fmt:message key="about.title"/></c:set>
<hippo-gogreen:title title="${abouttitle}"/>

<c:choose>
    <c:when test="${documents ne null}">
        <h2 class="h2-section-title"><c:out value="${folderName}"/></h2>
        <div class="i-section-title"></div>
        <c:forEach items="${documents}" var="document">
            <hst:link var="link" hippobean="${document}"/>
                <hst:cmseditlink hippobean="${document}" />
                <h3>
                    <a href="${link}"><c:out value="${document.title}"/></a>
                </h3>

                <p><c:out value="${document.summary}"/></p>
                <div class="divider divider-shadow"></div>
        </c:forEach>
    </c:when>
    <c:when test="${document ne null}">
        <hst:cmseditlink hippobean="${document}" />
        <h2 ><c:out value="${document.title}"/></h2>

        <p><c:out value="${document.summary}"/></p>
        <p><hst:html hippohtml="${document.description}"/></p>
    </c:when>
</c:choose>