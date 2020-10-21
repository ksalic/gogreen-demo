<%--
    Copyright 2020 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../includes/tags.jspf" %>

<c:choose>
  <c:when test="${not empty requestScope.document}">
    <hippo-gogreen:title title="${requestScope.document.title}"/>
    <div class="blog-post">
      <div class="blog-post-type">
        <i class="icon-news"> </i>
      </div>

      <div class="blog-span">
        <hst:manageContent hippobean="${requestScope.document}"/>
        <h2>
          <c:out value="${requestScope.document.title}"/>
        </h2>

        <div class="blog-post-body">
          <c:out value="${requestScope.document.summary}"/>
          <hst:html hippohtml="${requestScope.document.description}"/>
        </div>

        <c:if test="${hst:isReadable(document, 'date')}">
          <div class="blog-post-details">
            <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
              <span class="date">
                <hst:setBundle basename="messages"/>
                <fmt:message key="standard.date.format" var="dateformat"/>
                <fmt:formatDate value="${requestScope.document.date.time}" type="date" pattern="${dateformat}"/>
              </span>
            </div>
          </div>
        </c:if>
      </div>
    </div>
  </c:when>
  <c:otherwise>
    <ul class="box-general">
      <fmt:message key="common.simpledocument.nodocfound" var="nodoc"/><c:out value="${nodoc}"/>
    </ul>
  </c:otherwise>
</c:choose>