<%--
  Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../includes/tags.jspf" %>
<c:choose>
  <c:when test="${requestScope.preview && empty requestScope.htmlContent}">
    <h2 class="not-configured">Click to configure HTML component</h2>
  </c:when>
  <c:otherwise>${requestScope.htmlContent}</c:otherwise>
</c:choose>


