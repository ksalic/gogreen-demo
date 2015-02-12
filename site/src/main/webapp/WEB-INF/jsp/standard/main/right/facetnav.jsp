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

<%@include file="../../../includes/tags.jspf" %>

<div class="sidebar-block">
    <div class="sidebar-content tags blog-search">
        <hst:link var="searchLink" hippobean="${facetnav}"/>
        <c:set var="formId"><hst:namespace/>facetnavsearch</c:set>
        <form id="${formId}" action="${searchLink}" method="get" onsubmit="sanitizeRequestParam(document.forms['${formId}']['query'])">
            <div class="input-group">
                <input type="text" value="${query}" name="query" class="form-control blog-search-input text-input" placeholder="<fmt:message key="news.overview.facetnav.submit.label"/>...">
                <span class="input-group-addon">
                    <button class="blog-search-button icon-search ">
                    </button>
                </span>
            </div>
        </form>
    </div>
</div>


<c:forEach var="facet" items="${facetnav.folders}">
    <c:if test="${facet.count > 0}">
        <c:choose>
            <c:when test="${facet.leaf}">
                <div class="sidebar-block">
                    <h3 class="h3-sidebar-title sidebar-title">
                        <c:out value="${facet.name}"/>
                    </h3>
                    <div class="sidebar-content tags">
                        <a class="active" href="#"><c:out value="${facet.name}"/></a></li>
                    </div>
                </div>
            </c:when>
            <c:when test="${facet.childCountsCombined eq 0}">
            </c:when>
            <c:otherwise>
                <div class="sidebar-block">
                    <h3 class="h3-sidebar-title sidebar-title">
                        <c:out value="${facet.name}"/>
                    </h3>
                    <c:if test="${not empty facet.folders}">
                        <div class="sidebar-content tags">
                            <c:forEach items="${facet.folders}" var="item">
                                <c:choose>
                                    <c:when test="${item.leaf and item.count gt 0}">
                                        <hst:facetnavigationlink remove="${item}" current="${facetnav}" var="removeLink"/>
                                        <a href="${removeLink}" class="remove"><c:out value="${item.name}"/><i class="fa fa-times"> </i></a>
                                    </c:when>
                                    <c:when test="${item.leaf and item.count eq 0}">
                                    </c:when>
                                    <c:otherwise>
                                        <hst:link var="link" hippobean="${item}" navigationStateful="true" />
                                        <c:choose>
                                            <c:when test="${query eq null}">
                                                <a href="${link}"><c:out value="${item.name}"/>&nbsp;(${item.count})</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${link}"><c:out value="${item.name}"/>&nbsp;(${item.count})</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>
</c:forEach>