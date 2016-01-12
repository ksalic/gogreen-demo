<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf"%>

<div class="list-group left-nav">
    <c:forEach var="item1" items="${menu.menuItems}">
         <hst:link var="link1" link="${item1.hstLink}" />
         <a href="${link1}" class="list-group-item level1"><c:out value="${item1.name}"/></a>
         <c:if test="${item1.expanded and not empty item1.childMenuItems}">
              <c:forEach var="item2" items="${item1.childMenuItems}">
                  <hst:link var="link2" link="${item2.hstLink}" />
                  <a href="${link2}" class="list-group-item level2"><i class="fa fa-angle-right"> </i><c:out value="${item2.name}"/></a>
                  <c:if test="${item2.expanded and not empty item2.childMenuItems}">
                      <c:forEach var="item3" items="${item2.childMenuItems}">
                          <hst:link var="link3" link="${item3.hstLink}" />
                          <a href="${link3}" class="list-group-item level3"><i class="fa fa-angle-right"> </i><c:out value="${item3.name}"/></a>
                          <c:if test="${item3.expanded and not empty item3.childMenuItems}">
                              <c:forEach var="item4" items="${item3.childMenuItems}">
                                  <hst:link var="link4" link="${item4.hstLink}" />
                                  <a href="${link4}" class="list-group-item level4"><i class="fa fa-angle-right"> </i><c:out value="${item4.name}"/></a>
                              </c:forEach>
                          </c:if>
                      </c:forEach>
                  </c:if>
              </c:forEach>
        </c:if>
    </c:forEach>
</div>
