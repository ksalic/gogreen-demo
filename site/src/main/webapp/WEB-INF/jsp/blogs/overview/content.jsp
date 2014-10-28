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

<%@include file="../../includes/tags.jspf" %>

<c:set var="blogsoverviewtitle"><fmt:message key="blogs.overview.content.title"/></c:set>
<hippo-gogreen:title title="${blogsoverviewtitle}"/>

<%--@elvariable id="blogs" type="java.util.List<com.onehippo.gogreen.beans.BlogsItem>"--%>
<c:forEach items="${blogs.items}" var="blogitem" varStatus="status">
    <hst:link var="link" hippobean="${blogitem}"/>
    <div class="blog-post">

        <div class="blog-post-type">
            <i class="icon-pen"> </i>
        </div>

        <div class="blog-span">
            <hst:cmseditlink hippobean="${blogitem}" />
            <c:set var="image" value="${blogitem.firstImage}"/>
            <c:if test="${image != null and image.landscapeImage != null}">
                <div class="blog-post-featured-img">
                    <hst:link var="src" hippobean="${image.landscapeImage}"/>
                    <a href="${link}"><img src="${src}" alt="${fn:escapeXml(image.alt)}"/></a>
                </div>
            </c:if>
            <h2>
                <a href="${link}"><c:out value="${blogitem.title}"/></a>
            </h2>

            <div class="blog-post-body">
                <c:out value="${blogitem.summary}"/>
            </div>

            <div class="blog-post-details">

                <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                    <fmt:formatDate value="${blogitem.date.time}" type="date" pattern="d MMMM, yyyy"/>
                </div>

                <%--<div class="blog-post-details-item blog-post-details-item-left blog-post-details-tags icon-files">
                    <c:forEach items="${blogitem.categories}" var="category">
                        <a href="">
                            ${category}
                        </a>
                    </c:forEach>
                    ${newsitem.categories}
                </div>--%>

                <div class="blog-post-details-item blog-post-details-item-left blog-post-details-item-last icon-comment">
                    <a href="${link}">
                        <c:choose>
                            <c:when test="${commentsCountList[status.index] > 0}">
                                <c:out value="${commentsCountList[status.index]} "/><fmt:message key="blogs.overview.content.commentsfound"/><c:if test="${commentsCountList[status.index] gt 1}"><fmt:message key="blogs.overview.content.commentsplural"/></c:if>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="blogs.overview.content.nocomments"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
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
  <c:when test="${blogs.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults"/> '${query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${blogs}" queryName="query" queryValue="${query}"/>
  </c:otherwise>
</c:choose>
