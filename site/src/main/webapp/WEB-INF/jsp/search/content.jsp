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

<c:set var="searchresultstitle"><fmt:message key="search.results.title"/></c:set>
<hippo-gogreen:title title="${searchresultstitle}"/>

<c:set var="isFound" value="${tags != null or searchResult.total > 0}"/>
<c:set var="searched" value="'${fn:escapeXml(tag != null ? tag.label : query)}'"/>

<c:choose>
    <%-- When page is not found --%>
    <c:when test="${pagenotfound}">
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
                <c:when test="${empty query}">
                    <fmt:message key="search.results.found">
                        <fmt:param value="${searchResult.startOffset + 1}"/>
                        <fmt:param value="${searchResult.endOffset}"/>
                        <fmt:param value="${searchResult.total}"/>
                    </fmt:message>
                </c:when>
                <c:otherwise>
                    <fmt:message key="search.results.resultsfound">
                        <fmt:param value="${searchResult.startOffset + 1}"/>
                        <fmt:param value="${searchResult.endOffset}"/>
                        <fmt:param value="${searchResult.total}"/>
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
        <c:forEach items="${searchResult.items}" var="hit">
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
                                        read more <i class="fa fa-chevron-right"></i>
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
    <c:when test="${not pagenotfound}">
        <hippo-gogreen:pagination pageableResult="${searchResult}" queryName="query" queryValue="${fn:escapeXml(query)}"/>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>