<%--

    Copyright 2010-2017 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<c:set var="editionCountry" value="standard.header.langnav.edition.${pageContext.request.locale}"/>

<ul id="language">
  <li class="active">
    <fmt:message key="standard.header.langnav.language" />:
    <fmt:message key="${editionCountry}"/>
    <span><a href="#"><fmt:message key="mobile.standard.header.edition.change"/></a></span>
  </li>
  <c:forEach var="translation" items="${requestScope.translations}">
    <c:set var="title"><fmt:message key="standard.header.langnav.language.${translation.language}"/></c:set>
    <hst:link var="link" link="${translation.link}"/>
    <c:choose>
      <c:when test="${not translation.available}">
        <li class="unavailable"><a href="${link}"><c:out value="${title}"/>*</a></li>
      </c:when>
      <c:otherwise>
        <li><a href="${link}"><c:out value="${title}"/></a></li>
      </c:otherwise>
    </c:choose>
  </c:forEach>
</ul>