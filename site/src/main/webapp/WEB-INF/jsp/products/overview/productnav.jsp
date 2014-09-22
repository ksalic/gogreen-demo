<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

            http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>

<%@include file="../../includes/tags.jspf" %>

<c:if test="${not empty facetnav.folders}">
    <div class="portfolio-filter-container">
        <ul class="portfolio-filter">
            <c:choose>
              <c:when test="${activeFacNavBean.name eq 'facetedproducts'}">
                <li><a class="portfolio-selected" href="<hst:link siteMapItemRefId="products"/>">All</a></li>
              </c:when>
              <c:otherwise>
                <li><a href="<hst:link siteMapItemRefId="products"/>">All</a></li>
              </c:otherwise>
            </c:choose>
            <%--@elvariable id="facetnav.folders" type="java.util.List<org.hippoecm.hst.content.beans.standard.facetnavigation.HippoFacetSubNavigation>"--%>
            <c:forEach items="${facetnav.folders}" var="facet">
                <c:choose>
                  <c:when test="${facet eq activeFacNavBean}">
                    <li><a class="portfolio-selected" href="<hst:link hippobean="${facet}"/>"><c:out value="${facet.name}"/></a></li>
                  </c:when>
                  <c:otherwise>
                    <li><a href="<hst:link hippobean="${facet}"/>"><c:out value="${facet.name}"/></a></li>
                  </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
</c:if>