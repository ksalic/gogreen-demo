<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<div id="left-nav">
  <ul>
    <c:set var="folder" value="${requestScope.menu.menuItems[0]}"/>
    <c:forEach var="item" items="${folder.childMenuItems}">
      <li>
        <hst:link var="link" link="${item.hstLink}"/>
        <a href="${link}"><c:out value="${item.name}"/></a>
      </li>
    </c:forEach>
  </ul>

  <!-- components container -->
  <hst:include ref="boxes-left"/>
</div>
