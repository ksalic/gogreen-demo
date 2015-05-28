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

<c:set var="overviewtitle"><fmt:message key="events.overview.title"/></c:set>
<hippo-gogreen:title title="${overviewtitle}"/>

<%--@elvariable id="documents" type="java.util.List<com.onehippo.gogreen.beans.EventDocument>"--%>
<c:forEach items="${documents.items}" var="event" varStatus="status">
    <hst:link var="link" hippobean="${event}"/>
    <div class="blog-post">

        <div class="blog-post-type">
            <i class="icon-calendar"> </i>
        </div>

        <div class="blog-span">
            <hst:cmseditlink hippobean="${event}" />
            <c:set var="image" value="${event.firstImage}"/>
            <c:if test="${image != null and image.landscapeImage != null}">
                <div class="blog-post-featured-img">
                    <hst:link var="src" hippobean="${image.landscapeImage}"/>
                    <a href="${link}"><img src="${src}" alt="${fn:escapeXml(image.alt)}"/></a>
                </div>
            </c:if>
            <h2>
                <hst:cmseditlink hippobean="${event}"/>
                <a href="${link}"><c:out value="${event.title}"/></a>
            </h2>

            <div class="blog-post-body">
                <c:out value="${event.summary}"/>
            </div>

            <div class="blog-post-details">

                <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                    <fmt:formatDate value="${event.date.time}" type="date" pattern="d MMMM, yyyy"/>
                </div>

                <%--<div class="blog-post-details-item blog-post-details-item-left blog-post-details-tags icon-files">
                    <c:forEach items="${event.categories}" var="category">
                        <a href="">
                            ${category}
                        </a>
                    </c:forEach>
                    ${event.categories}
                </div>--%>

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
  <c:when test="${documents.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults"/> '${requestScope.query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${documents}" queryName="query" queryValue="${requestScope.query}"/>
  </c:otherwise>
</c:choose>


<%--
<fmt:message key="events.overview.location.label"/></li>
            <li>
              <hst:link var="home" siteMapItemRefId="home" />
              <a href="${home}"><fmt:message key="events.overview.location.home"/></a> &gt;
            </li>
            <h2><fmt:message key="events.overview.title"/></h2>
            --%>