<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:if test="${not empty requestScope.feed}">

<c:choose>
  <c:when test="${requestScope.numberOfItems eq 1}">
      <c:set var="colSize" value="12"/>
  </c:when>
  <c:when test="${requestScope.numberOfItems eq 2}">
      <c:set var="colSize" value="6"/>
  </c:when>
  <c:when test="${requestScope.numberOfItems eq 3}">
      <c:set var="colSize" value="4"/>
  </c:when>
  <c:when test="${requestScope.numberOfItems ge 4}">
      <c:set var="colSize" value="3"/>
  </c:when>
</c:choose>

<c:if test="${empty requestScope.icon}">
    <c:set var="cssIcon"> no-icon</c:set>
</c:if>

<div class="container">
    <c:if test="${not empty requestScope.title}">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h2 class="h2-section-title"><c:out value="${requestScope.title}"/></h2>
            </div>
        </div>
        <div class="space-sep20"/></div>
    </c:if>

    <div class="row rss-feed">
          <hst:setBundle basename="messages"/>
          <fmt:message key="standard.date.format" var="dateformat"/>
          <c:forEach items="${requestScope.feed.entries}" var="entry" end="${requestScope.numberOfItems - 1}" varStatus="status">
              <c:if test="${status.index eq 4}">
                </div>
                <div class="row rss-feed">
              </c:if>
              <div class="col-md-${colSize} col-sm-${colSize}">
                  <div class="feature">
                      <div class="feature-content">
                          <c:if test="${not empty requestScope.icon}">
                              <div class="content-style3">
                                  <i class="fa content-style3-icon <c:out value="${requestScope.icon}"/>"></i>
                              </div>
                          </c:if>
                          <p class="link">
                            <a href="${fn:escapeXml(entry.link)}"><c:out value="${entry.title}"/></a>
                          </p>

                      </div>
                      <div class="feature-details ${cssIcon}">
                          <i class="icon-calendar"></i>
                          <span><fmt:formatDate value="${entry.publishedDate}" type="date" pattern="${dateformat}"/></span>
                      </div>
                  </div>
              </div>
          </c:forEach>
        </div>
    </div>

  <c:if test="${requestScope.separatorBorderTop}">
      <c:set var="cssClass"> border-top</c:set>
  </c:if>
  <c:if test="${requestScope.separatorBorderBottom}">
      <c:set var="cssClass">${cssClass} border-bottom</c:set>
  </c:if>
  <c:if test="${not empty requestScope.separatorMargin or not empty cssClass}">
      <div class="space-sep<c:out value="${requestScope.separatorMargin} ${cssClass}"/>"></div>
  </c:if>
</c:if>
