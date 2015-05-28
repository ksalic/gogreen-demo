<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

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

<!-- Navigation File -->
<div class="col-md-12">

  <!-- Mobile Button Menu -->
  <div class="mobile-menu-button">
    <i class="fa fa-list-ul"></i>
  </div>
  <!-- //Mobile Button Menu// -->

  <nav>
    <ul class="navigation" id="main-navigation">
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
            <li>
              <a href="${link}" class="activelink"><span class="label-nav"><c:out value="${item.name}"/></span>
                <c:set var="subName" value='${item.getParameter("subname")}'/>
                <c:if test="${not empty subName}">
                    <span class="label-nav-sub" data-hover="${subName}">${subName}</span>
                </c:if>
              </a>
              <c:if test="${not empty item.childMenuItems}">
                <ul>
                  <c:forEach var="childItem" items="${item.childMenuItems}">
                    <li>
                      <c:choose>
                        <c:when test="${empty childItem.externalLink}">
                          <hst:link var="childLink" link="${childItem.hstLink}"/>
                        </c:when>
                        <c:otherwise>
                          <c:set var="childLink" value="${fn:escapeXml(childItem.externalLink)}"/>
                        </c:otherwise>
                      </c:choose>
                      <a href="${childLink}"><span class="label-nav"><c:out value="${childItem.name}"/></span></a>
                    </li>
                  </c:forEach>
                </ul>
              </c:if>
            </li>
          </c:when>
          <c:otherwise>
            <li>
              <a href="${link}"><span class="label-nav"><c:out value="${item.name}"/></span>
                <c:set var="subName" value='${item.getParameter("subname")}'/>
                <c:if test="${not empty subName}">
                    <span class="label-nav-sub" data-hover="${subName}">${subName}</span>
                </c:if>
              </a>
              <c:if test="${not empty item.childMenuItems}">
                <ul>
                  <c:forEach var="childItem" items="${item.childMenuItems}">
                    <li>
                      <c:choose>
                        <c:when test="${empty childItem.externalLink}">
                          <hst:link var="childLink" link="${childItem.hstLink}"/>
                        </c:when>
                        <c:otherwise>
                          <c:set var="childLink" value="${fn:escapeXml(childItem.externalLink)}"/>
                        </c:otherwise>
                      </c:choose>
                      <a href="${childLink}"><span class="label-nav"><c:out value="${childItem.name}"/></span></a>
                    </li>
                  </c:forEach>
                </ul>
              </c:if>
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
    </nav>

  <!-- Mobile Nav. Container -->
  <ul class="mobile-nav">
    <li class="responsive-searchbox">
      <!-- Responsive Nave -->
      <hst:link siteMapItemRefId="search" var="doSearch" />
      <form action="${doSearch}" method="get">
        <input type="text" class="searchbox-inputtext" id="searchbox-inputtext-mobile" name="query" />
        <button class="icon-search"></button>
      </form>
      <!-- //Responsive Nave// -->
    </li>
  </ul>
  <!-- //Mobile Nav. Container// -->
</div>