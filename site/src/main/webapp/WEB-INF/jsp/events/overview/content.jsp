<%--
    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../../includes/tags.jspf" %>

<fmt:message key="events.overview.title" var="overviewtitle"/>
<hippo-gogreen:title title="${overviewtitle}"/>

<%--@elvariable id="documents" type="java.util.List<com.onehippo.gogreen.beans.EventDocument>"--%>
<hst:setBundle basename="messages"/>
<fmt:message key="standard.date.format" var="dateformat"/>
<hst:manageContent documentTemplateQuery="new-event" defaultPath="events"/>
<c:forEach items="${documents.items}" var="event" varStatus="status">
    <hst:link var="link" hippobean="${event}"/>
    <div class="blog-post">

        <div class="blog-post-type">
            <i class="icon-calendar"> </i>
        </div>

        <div class="blog-span">
            <hst:manageContent hippobean="${event}" />
            <c:set var="image" value="${event.firstImage}"/>
            <c:if test="${image != null and image.landscapeImage != null}">
                <div class="blog-post-featured-img">
                    <hst:link var="src" hippobean="${image.landscapeImage}"/>
                    <a href="${link}"><img src="${src}" alt="${fn:escapeXml(image.alt)}"/></a>
                </div>
            </c:if>
            <h2>
                <a href="${link}"><c:out value="${event.title}"/></a>
            </h2>

            <div class="blog-post-body">
                <c:out value="${event.summary}"/>
            </div>

            <div class="blog-post-details">

                <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                    <fmt:formatDate value="${event.date.time}" type="date" pattern="${dateformat}"/>
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
  <c:when test="${documents.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults" var="noresults"/><c:out value="${noresults}"/> '${requestScope.query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${documents}" queryName="query" queryValue="${requestScope.query}"/>
  </c:otherwise>
</c:choose>