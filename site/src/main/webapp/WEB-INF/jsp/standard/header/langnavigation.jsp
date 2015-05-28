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

<%@include file="../../includes/tags.jspf" %>

<c:set var="requestLanguage" value="standard.header.langnav.language.${pageContext.request.locale.language}"/>

<!-- lang navigation -->
<div class="col-sm-7 langnav">
    <nav>
        <ul class="" id="language">

            <%-- RK: Disabled label
            <li class="label">
              <fmt:message key="standard.header.langnav.language" />:
            </li>
            --%>

            <li class="active">
                <i class="fa fa-ellipsis-h"></i> <span><fmt:message key="${requestLanguage}"/></span>
                <c:if test="${not empty requestScope.translations}">
                    <ul>
                        <c:forEach var="translation" items="${requestScope.translations}">
                            <hst:link var="link" link="${translation.link}" />
                            <c:set var="title"><fmt:message key="standard.header.langnav.language.${translation.language}"/></c:set>
                            <li>
                                <a href="${link}"><c:out value="${title}"/></a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </li>

        </ul>
    </nav>
</div>