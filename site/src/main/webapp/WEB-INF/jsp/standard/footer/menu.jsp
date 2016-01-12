<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:cmseditmenu menu="${requestScope.menu}"/>

<ul class="footer-category-list">
  <c:forEach var="item" items="${requestScope.menu.siteMenuItems}">
    <c:choose>
      <c:when test="${empty item.externalLink}">
        <hst:link var="link" link="${item.hstLink}"/>
      </c:when>
      <c:otherwise>
        <c:set var="link" value="${fn:escapeXml(item.externalLink)}"/>
      </c:otherwise>
    </c:choose>
    <li><a href="${link}"><c:out value="${item.name}"/></a></li>
  </c:forEach>
</ul>
