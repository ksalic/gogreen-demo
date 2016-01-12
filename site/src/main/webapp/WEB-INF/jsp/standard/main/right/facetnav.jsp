<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../../includes/tags.jspf"%>

<div class="sidebar-block">
    <div class="sidebar-content tags blog-search">
        <hst:link var="searchLink" hippobean="${requestScope.facetnav}" />
        <c:set var="formId">
            <hst:namespace />facetnavsearch</c:set>
        <form id="${formId}" action="${searchLink}" method="get"
              onsubmit="sanitizeRequestParam(document.forms['${formId}']['query'])">
            <div class="input-group">
                <input type="text" value="${requestScope.query}" name="query"
                       class="form-control blog-search-input text-input"
                       placeholder='<fmt:message key="news.overview.facetnav.submit.label"/>...'>
                <span class="input-group-addon">
                    <button class="blog-search-button icon-search "></button>
                </span>
            </div>
        </form>
    </div>
</div>



<c:forEach var="facet" items="${requestScope.facetnav.folders}">

    <c:if test="${facet.count gt 0}">
        <c:choose>
            <c:when test="${facet.leaf}">
                <div class="sidebar-block">
                    <h3 class="h3-sidebar-title sidebar-title">
                        <c:out value="${facet.name}" />
                    </h3>
                    <div class="sidebar-content tags">
                        <a class="active" href="#"><c:out value="${facet.name}" /></a>
                        <li></li>
                    </div>
                </div>
            </c:when>
            <c:when test="${facet.childCountsCombined eq 0}">
            </c:when>
            <c:otherwise>
                <div class="sidebar-block">
                    <h3 class="h3-sidebar-title sidebar-title">
                        <c:out value="${facet.name}" />
                    </h3>
                    <hst:setBundle  basename="document.type" />
                    <c:if test="${not empty facet.folders}">
                        <div class="sidebar-content tags">
                            <c:forEach items="${facet.folders}" var="item">
                                <!-- store facet name as "label" -->
                                <c:set var="label" value="${item.name}" />
                               <!-- store resource bundle value for current face name as "name"-->
                               <fmt:message  key="${item.name}" var="name" />
                                <!-- if a facet value does not start with "???" then it has to be one of the values defined in the resource bundle -->
                                <c:if test="${!fn:startsWith(name, '???')}">
                                    <!-- use this value as label for the search result facets, stored as "label"-->
                                    <c:set var="label" value="${name}" />
                                </c:if>
                                <c:choose>
                                    <c:when test="${item.leaf and item.count gt 0}">
                                        <hst:facetnavigationlink remove="${item}"
                                                                 current="${requestScope.facetnav}" var="removeLink" />

                                        <a href="${removeLink}" class="remove"><c:out
                                                value="${label}}" /><i class="fa fa-times"> </i></a>
                                        </c:when>
                                        <c:when test="${item.leaf and item.count eq 0}">
                                        </c:when>
                                        <c:otherwise>
                                            <hst:link var="link" hippobean="${item}"
                                                      navigationStateful="true" />
                                            <c:choose>
                                                <c:when test="${requestScope.query eq null}">
                                                <a href="${link}"><c:out value="${label}" />&nbsp;(${item.count})</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${link}"><c:out value="${label}" />&nbsp;(${item.count})</a>
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