<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<fmt:message key="blogs.overview.content.title" var="blogsoverviewtitle"/>
<hippo-gogreen:title title="${blogsoverviewtitle}"/>
<hst:manageContent documentTemplateQuery="new-blog" defaultPath="blogs" />

<%--@elvariable id="blogs" type="java.util.List<com.onehippo.gogreen.beans.BlogsItem>"--%>
<c:forEach items="${requestScope.blogs.items}" var="blogitem" varStatus="status">
    <hst:link var="link" hippobean="${blogitem}"/>
    <div class="blog-post">

        <div class="blog-post-type">
            <i class="icon-pen"> </i>
        </div>

        <div class="blog-span">
            <hst:manageContent hippobean="${blogitem}"/>
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
                  <hst:setBundle basename="messages"/>
                  <fmt:message key="standard.date.format" var="dateformat"/>
                  <fmt:formatDate value="${blogitem.date.time}" type="date" pattern="${dateformat}"/>
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
                                <fmt:message key="blogs.overview.content.commentsfound" var="contentCommentsfound"/>
                                <fmt:message key="blogs.overview.content.commentsplural" var="contentCommentsplural"/>
                                <c:out value="${commentsCountList[status.index]} "/><c:out value="${contentCommentsfound}"/><c:if test="${commentsCountList[status.index] gt 1}"><c:out value="${contentCommentsplural}"/></c:if>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="blogs.overview.content.nocomments" var="contentNocomments"/><c:out value="${contentNocomments}"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>

                <div class="blog-post-details-item blog-post-details-item-right">
                    <a href="${link}">
                        <fmt:message key="common.read.more" var="readMore"/><c:out value="${readMore}"/> <i class="fa fa-chevron-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<c:choose>
  <c:when test="${requestScope.blogs.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults" var="resultsNoresults"/><c:out value="${resultsNoresults}"/> '${requestScope.query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${requestScope.blogs}" queryName="query" queryValue="${requestScope.query}"/>
  </c:otherwise>
</c:choose>
