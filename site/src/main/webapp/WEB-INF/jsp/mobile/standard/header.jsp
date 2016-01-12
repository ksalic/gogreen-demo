<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>


<div id="hd">
  <!-- language navigation -->
  <hst:include ref="langnavigation"/>

  <div id="hd-main">

    <!-- logo -->
    <c:set var="lang" value="${pageContext.request.locale.language}"/>

    <hst:include ref="logo"/>

    <!-- navigation -->
    <ul id="nav">
      <c:forEach var="item" items="${requestScope.menu.siteMenuItems}">
        <c:choose>
          <c:when test="${empty item.externalLink}">
            <hst:link var="link" link="${item.hstLink}"/>
          </c:when>
          <c:otherwise>
            <c:set var="link" value="${fn:escapeXml(item.externalLink)}"/>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${item.expanded}">
            <li class="active">
              <a href="${link}"><c:out value="${item.name}"/></a>
              <ul>
                <c:choose>
                  <c:when test="${requestScope.detailPage}">
                    <li class="back">
                      <i class="fa fa-arrow-circle-left"></i>
                      <a href="${link}" onclick="javascript:history.back(); return false;"><c:out value="${item.name}"/></a>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <c:forEach items="${item.childMenuItems}" var="childItem">
                      <c:choose>
                        <c:when test="${empty childItem.externalLink}">
                          <hst:link var="childLink" link="${childItem.hstLink}"/>
                        </c:when>
                        <c:otherwise>
                          <c:set var="childLink" value="${fn:escapeXml(childItem.externalLink)}"/>
                        </c:otherwise>
                      </c:choose>
                      <c:choose>
                        <c:when test="${childItem.expanded or (requestScope.menu.deepestExpandedItem == item and childItem == item.childMenuItems[0])}">
                          <li class="active">
                            <a href="${childLink}"><c:out value="${childItem.name}"/></a>
                          </li>
                        </c:when>
                        <c:otherwise>
                          <li>
                            <a href="${childLink}"><c:out value="${childItem.name}"/></a>
                          </li>
                        </c:otherwise>
                      </c:choose>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </ul>
            </li>
          </c:when>
          <c:otherwise>
            <li>
              <a href="${link}"><c:out value="${item.name}"/></a>
            </li>
          </c:otherwise>
        </c:choose>
      </c:forEach>

      <hst:defineObjects/>
      <c:if test="${hstRequest.requestContext.preview}">
        <li class="edit-menu-button">
          <hst:cmseditmenu menu="${requestScope.menu}"/>
        </li>
      </c:if>
    </ul>
  </div>
</div>
