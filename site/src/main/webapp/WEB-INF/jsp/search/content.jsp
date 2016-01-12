<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:set var="searchresultstitle"><fmt:message key="search.results.title"/></c:set>
<hippo-gogreen:title title="${searchresultstitle}"/>

<c:set var="isFound" value="${requestScope.tags != null or requestScope.searchResult.total > 0}"/>
<c:set var="searched" value="'${fn:escapeXml(requestScope.tag != null ? requestScope.tag.label : requestScope.query)}'"/>

<c:choose>
    <%-- When page is not found --%>
    <c:when test="${requestScope.pagenotfound}">
        <h4><fmt:message key="search.results.pagenotfound"/></h4>
        <p>
            <fmt:message key="search.results.notfounddescr"/>
            <c:if test="${not isFound}">
                <br/><br/><fmt:message key="search.results.norelatedpages"/>
            </c:if>
        </p>
        <c:if test="${isFound}">
            <p class="b"><fmt:message key="search.results.suggestion"/></p>
        </c:if>
    </c:when>
    <%-- When a search is done, but no results where found --%>
    <c:when test="${not isFound}">
        <h4><fmt:message key="search.results.noresults"/> '${searched}'</h4>
    </c:when>
    <%-- When a search is done and there is a result --%>
    <c:otherwise>
        <h4>
            <c:choose>
                <c:when test="${empty requestScope.query}">
                    <fmt:message key="search.results.found">
                        <fmt:param value="${requestScope.searchResult.startOffset + 1}"/>
                        <fmt:param value="${requestScope.searchResult.endOffset}"/>
                        <fmt:param value="${requestScope.searchResult.total}"/>
                    </fmt:message>
                </c:when>
                <c:otherwise>
                    <fmt:message key="search.results.resultsfound">
                        <fmt:param value="${requestScope.searchResult.startOffset + 1}"/>
                        <fmt:param value="${requestScope.searchResult.endOffset}"/>
                        <fmt:param value="${requestScope.searchResult.total}"/>
                        <fmt:param value="${searched}"/>
                     </fmt:message>
                </c:otherwise>
            </c:choose>
        </h4>
    </c:otherwise>
</c:choose>

<%-- if there is a result, show it --%>
<c:if test="${isFound}">
    <div id="search-results">
        <c:forEach items="${requestScope.searchResult.items}" var="hit">
            <hst:link var="link" hippobean="${hit}"/>
            <c:set var="hitClassName" value="${hit['class'].simpleName}"/>
            <div class="blog-post">

                <div class="blog-post-type">
                    <c:choose>
                        <c:when test="${hit['class'].simpleName eq 'NewsItem'}">
                            <i class="icon-news"> </i>
                        </c:when>
                        <c:when test="${hit['class'].simpleName eq 'EventDocument'}">
                            <i class="icon-calendar"> </i>
                        </c:when>
                        <c:when test="${hit['class'].simpleName eq 'Product'}">
                            <i class="icon-shop"> </i>
                        </c:when>
                        <c:when test="${hit['class'].simpleName eq 'JobsDocument'}">
                            <i class="icon-user"> </i>
                        </c:when>
                        <c:otherwise>
                            <i class="icon-file"> </i>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="blog-span">
                    <c:choose>
                        <c:when test="${hitClassName eq 'HippoAsset'}">
                            <h2><a href="${fn:escapeXml(link)}"><c:out value="${hit.name}"/></a></h2>
                        </c:when>
                        <c:when test="${hitClassName eq 'Faq'}">
                            <h2><a href="${fn:escapeXml(link)}"><c:out value="${hit.question}"/></a></h2>
                        </c:when>
                        <c:otherwise>
                            <h2><a href="${fn:escapeXml(link)}"><c:out value="${hit.title}"/></a></h2>
                            <div class="blog-post-body">
                                <c:out value="${hit.summary}"/>
                            </div>

                            <div class="blog-post-details">

                                <div class="blog-post-details-item blog-post-details-item-right">
                                    <a href="${link}">
                                        <fmt:message key="common.read.more"/> <i class="fa fa-chevron-right"></i>
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>

<%-- Show bottom pagination if it is a proper search, if it comes from pagenotfound, dont show it --%>
<c:choose>
    <c:when test="${not requestScope.pagenotfound}">
        <hippo-gogreen:pagination pageableResult="${requestScope.searchResult}" queryName="query" queryValue="${fn:escapeXml(requestScope.query)}"/>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>