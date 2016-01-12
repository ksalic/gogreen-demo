<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>
<%@include file="../includes/tags.jspf" %>

<c:choose>
  <c:when test="${not empty requestScope.document}">
    <ul class="box-general box-simple <c:if test="${requestScope.preview}">editable</c:if>">
      <c:if test="${requestScope.preview}">
        <li><hst:cmseditlink hippobean="${requestScope.document}"/></li>
      </c:if>
      <li class="title"><c:out value="${requestScope.document.title}"/></li>
      <li class="subtitle"><c:out value="${requestScope.document.summary}"/></li>
      <li class="content"><hst:html hippohtml="${requestScope.document.description}"/></li>
    </ul>
  </c:when>
  <c:otherwise>
    <ul class="box-general">
      <li class="title"><fmt:message key="common.simpledocument.nodocfound"/></li>
    </ul>
  </c:otherwise>
</c:choose>
