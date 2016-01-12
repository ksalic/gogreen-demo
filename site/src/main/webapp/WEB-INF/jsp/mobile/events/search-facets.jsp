<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<%--
<hst:headContribution>
    <hst:link var="filter" path="/js/mobile/filter.js"/>
    <script src="${filter}" type="text/javascript"></script>
</hst:headContribution>
--%>

<!-- search navigation -->
<ul id="filter-by">
    <li id="search">
        <%--<hst:link var="searchLink" hippobean="${facetnav}"/>--%>
        <c:set value="${fn:escapeXml(requestScope.query)}" var="query"/>
        <form method="get" action="${requestScope.searchLink}">
            <p>
                <input type="text" value="${query}" name="query" class="search-field gray" />
                <input type="submit" value="<fmt:message key="mobile.events.searchfacets.submit.label"/>" class="search-button" />
                <!-- Begin: Design for clear search--> 
                <hst:link   var="removeLink" />
                <a class="clear" href="${removeLink}" title="<fmt:message key="mobile.events.searchfacets.clear"/> ${query}">&nbsp;</a>
                <!-- End: Design for clear search -->
            </p>
        </form>
    </li>

    <c:choose>
        <c:when test="${requestScope.childNav}">
            <li class="expanded">
        </c:when>
        <c:otherwise>
            <li>
        </c:otherwise>
    </c:choose>    
        <span><span class="name"><c:out value="${requestScope.facetnav.count}"/> <fmt:message key="mobile.events.searchfacets.results"/> <span class="separator">|</span></span><a href="#"><fmt:message key="mobile.events.searchfacets.filterresults"/></a></span>
        <c:if test="${requestScope.facetnav.count gt 0}">
        
          <ul class="subfilter">          
              <c:forEach var="facetvalue" items="${requestScope.facetnav.folders}">
                  <c:if test="${facetvalue.count > 0}">
                  
                      <c:set var="selectedItem" scope="page" value="${null}"/>
                      <c:forEach items="${facetvalue.folders}" var="item">
                          <c:if test="${item.leaf and item.count gt 0}">
                              <c:set var="selectedItem" scope="page" value="${item}"/>
                          </c:if>
                      </c:forEach>
  
                      <c:choose>
                          <c:when test="${selectedItem != null}">
                              <li class="clear">
                          </c:when>
                          <c:otherwise>
                              <li>
                          </c:otherwise>
                      </c:choose>    
                  
                      <span><span class="name"><c:out value="${facetvalue.name}"/>:</span>
  
                      <c:choose>
                          <c:when test="${selectedItem != null}">
                              <hst:facetnavigationlink remove="${selectedItem}" current="${requestScope.facetnav}" var="removeLink"/>
                              <a class="filter" href="#">
                                          <c:out value="${selectedItem.name}"/>&nbsp;(<c:out value="${selectedItem.count}"/>)
                              </a></span>
                              <a class="clear" href="${removeLink}" title="<fmt:message key="mobile.events.searchfacets.clearfilter"/> ${selectedItem.name}">&nbsp;</a>
                          </c:when>
                          <c:otherwise>
                              <a href="#"><fmt:message key="mobile.events.searchfacets.any"/> <c:out value="${facetvalue.name}"/></a></span>
                              <ul class="subsubfilter">
                                  <c:forEach items="${facetvalue.folders}" var="item">
                                      <hst:link var="link" hippobean="${item}" navigationStateful="true">
                                          <hst:sitemapitem preferPath="mobile/events"/> 
                                      </hst:link>
                                      <li><a href="${link}"><c:out value="${item.name}"/>&nbsp;(${item.count})</a></li>
                                  </c:forEach>
                              </ul>
                          </c:otherwise>
                      </c:choose>    
  
                      </li>
  
                  </c:if>
              </c:forEach>        
        
          </ul>
        </c:if>
    </li>
    <li id="sort-by" class="last"><span><span class="name"><fmt:message key="mobile.events.searchfacets.sortby"/></span>
    <a href="#">
        <c:choose>
            <c:when test="${requestScope.order != 'relevance'}"><fmt:message key="mobile.events.searchfacets.relevance"/></c:when>
            <c:when test="${requestScope.order == 'title'}"><fmt:message key="mobile.events.searchfacets.name"/></c:when>
            <c:when test="${requestScope.order == 'date'}"><fmt:message key="mobile.events.searchfacets.date"/></c:when>
            <c:when test="${requestScope.order == '-lastModificationDate'}"><fmt:message key="mobile.events.searchfacets.mostrecent"/></c:when>
            <c:otherwise><fmt:message key="mobile.events.searchfacets.relevance"/></c:otherwise>
        </c:choose>
    </a>
    </span>
        <ul class="subsubfilter">
            <c:if test="${requestScope.order != 'relevance'}"><li><a href="?query=${query}&amp;order=relevance"><fmt:message key="mobile.events.searchfacets.relevance"/></a></li></c:if>
            <c:if test="${requestScope.order != 'title'}"><li><a href="?query=${query}&amp;order=title"><fmt:message key="mobile.events.searchfacets.name"/></a></li></c:if>
            <c:if test="${requestScope.order != 'date'}"><li><a href="?query=${query}&amp;order=date"><fmt:message key="mobile.events.searchfacets.date"/></a></li></c:if>
            <c:if test="${requestScope.order != '-lastModificationDate'}"><li><a href="?query=${query}&amp;order=-lastModificationDate"><fmt:message key="mobile.events.searchfacets.mostrecent"/></a></li></c:if>
        </ul>
    </li>
</ul>
