<%--
    Copyright 2010-2016 Hippo B.V. (http://www.onehippo.com)
--%>

<%@include file="../../includes/tags.jspf" %>
<hst:setBundle basename="messages,typenames,products.facet"/>

<c:if test="${not empty requestScope.facetnav.folders}">
    <div class="portfolio-filter-container">
        <ul class="portfolio-filter">
            <c:choose>
              <c:when test="${requestScope.activeFacNavBean.name eq 'facetedproducts'}">
                <li><a class="portfolio-selected" href="<hst:link siteMapItemRefId="products" navigationStateful="true"/>"><fmt:message key="categories.all"/></a></li>
              </c:when>
              <c:otherwise>
                <li><a href="<hst:link siteMapItemRefId="products" navigationStateful="true"/>"><fmt:message key="categories.all"/></a></li>
              </c:otherwise>
            </c:choose>
            <%--@elvariable id="facetnav.folders" type="java.util.List<org.hippoecm.hst.content.beans.standard.facetnavigation.HippoFacetSubNavigation>"--%>
            <c:forEach items="${requestScope.facetnav.folders}" var="facet">
                <c:choose>
                  <c:when test="${facet eq requestScope.activeFacNavBean}">
                    <li><a class="portfolio-selected" href="<hst:link hippobean="${facet}" navigationStateful="true"/>"><c:out value="${facet.name}"/></a></li>
                  </c:when>
                  <c:otherwise>
                    <li><a href="<hst:link hippobean="${facet}" navigationStateful="true"/>"><c:out value="${facet.name}"/></a></li>
                  </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
</c:if>