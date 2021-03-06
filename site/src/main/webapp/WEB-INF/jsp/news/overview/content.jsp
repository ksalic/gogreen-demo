<%--
    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../../includes/tags.jspf" %>

<fmt:message key="news.overview.content.title" var="newsoverviewtitle"/>
<hippo-gogreen:title title="${newsoverviewtitle}"/>

<div class="news-overview">
<hst:manageContent documentTemplateQuery="new-news" defaultPath="news"/>
<%--@elvariable id="news" type="java.util.List<com.onehippo.gogreen.beans.SimpleDocument>"--%>
<c:forEach items="${requestScope.news.items}" var="newsitem" varStatus="status">
    <hst:link var="link" hippobean="${newsitem}"/>
    <div class="blog-post">

        <div class="blog-post-type">
            <i class="icon-news"> </i>
        </div>

        <div class="blog-span">
            <hst:manageContent hippobean="${newsitem}"/>
            <h2>
                <a href="${link}"><c:out value="${newsitem.title}"/></a>
            </h2>

            <div class="blog-post-body">
                <p><c:out value="${newsitem.summary}"/></p>
                <p><hst:html hippohtml="${newsitem.description}"/></p>
            </div>

            <div class="blog-post-details">

                <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                    <hst:setBundle basename="messages"/>
                    <fmt:message key="standard.date.format" var="dateformat"/>
                    <fmt:formatDate value="${newsitem.date.time}" type="date" pattern="${dateformat}"/>
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
  <c:when test="${requestScope.news.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults" var="noResults"/><c:out value="${noResults}"/> '${requestScope.query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${requestScope.news}" queryName="query" queryValue="${requestScope.query}"/>
  </c:otherwise>
</c:choose>
</div>
