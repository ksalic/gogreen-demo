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

<c:set var="newsoverviewtitle"><fmt:message key="news.overview.content.title"/></c:set>
<hippo-gogreen:title title="${newsoverviewtitle}"/>

<div class="news-overview">
<%--@elvariable id="news" type="java.util.List<com.onehippo.gogreen.beans.SimpleDocument>"--%>
<c:forEach items="${requestScope.news.items}" var="newsitem" varStatus="status">
    <hst:link var="link" hippobean="${newsitem}"/>
    <div class="blog-post">

        <div class="blog-post-type">
            <i class="icon-news"> </i>
        </div>

        <div class="blog-span">
            <hst:cmseditlink hippobean="${newsitem}" />
            <h2>
                <a href="${link}"><c:out value="${newsitem.title}"/></a>
            </h2>

            <div class="blog-post-body">
                <p><c:out value="${newsitem.summary}"/></p>
                <p><hst:html hippohtml="${newsitem.description}"/></p>
            </div>

            <div class="blog-post-details">

                <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                    <fmt:formatDate value="${newsitem.date.time}" type="date" pattern="d MMMM, yyyy"/>
                </div>

                <div class="blog-post-details-item blog-post-details-item-right">
                    <a href="${link}">
                        <fmt:message key="common.read.more"/> <i class="fa fa-chevron-right"></i>
                    </a>
                </div>

            </div>
        </div>
    </div>
</c:forEach>

<c:choose>
  <c:when test="${requestScope.news.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults"/> '${requestScope.query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${requestScope.news}" queryName="query" queryValue="${requestScope.query}"/>
  </c:otherwise>
</c:choose>
</div>
