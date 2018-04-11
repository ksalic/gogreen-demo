<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<!-- search navigation -->
<ul id="filter-by">
  <li id="search">
    <hst:link var="searchLink" hippobean="${requestScope.facetnav}"/>
    <form id="searchform" method="get" action="${searchLink}">
      <p>
        <!--
            Let's enable x-webkit-speech so we can use Webkit's Speech recognition in this input field
            Currently works only in Chrome
        -->
        <input type="text" value="${requestScope.query}" name="query" id="query" class="search-field gray" x-webkit-speech=""/>
        <fmt:message key="mobile.products.searchfacets.submit.label" var="submitValue"/>
        <input type="submit" value="<c:out value="${submitValue}"/>" class="search-button"/>
        <!-- Begin: Design for clear search-->
        <!-- An hst link with any attribute other than var creates a link for the current matched sitemap item -->
        <hst:link var="removeLink"/>
        <fmt:message key="mobile.products.searchfacets.clear" var="searchFacetsClear"/>
        <c:set var="removeTitle"><c:out value="${searchFacetsClear}${requestScope.query}"/></c:set>
        <a class="clear" href="${removeLink}" title="${removeTitle}">&nbsp;</a>
        <!-- End: Design for clear search -->
      </p>
    </form>
  </li>

  <script type="text/javascript">
    // When speech input is ready, select result number 1 and submit the form
    function inputChange(e) {
      if (e.results) { // e.type == 'webkitspeechchange'
        for (var i = 0, result; result = e.results[i]; ++i) {
          console.log(result.utterance, result.confidence);
        }
        console.log('Best result: ' + this.value);
        // Put in the value manually because somehow Chrome doesn't clear the field automatically
        query.value = e.results[0].utterance;
        searchform.submit();
      }
    }

    var input = document.querySelector('[x-webkit-speech]');
    input.addEventListener('change', inputChange, false);
    input.addEventListener('webkitspeechchange', inputChange, false);
  </script>

  <li${requestScope.childNav ? ' class="expanded"' : ''}>

    <fmt:message key="mobile.products.searchfacets.results" var="searchFacetsResults"/>
    <span><span class="name"><c:out value="${requestScope.facetnav.count}${searchFacetsResults} "/><span class="separator"> | </span></span><a href="#"><fmt:message key="mobile.products.searchfacets.filterresults" var="searchfacetsfilterresults"/> <c:out value="searchfacetsfilterresults"/></a></span>


    <c:if test="${fn:length(facetnav.folders) gt 0}">
      <ul class="subfilter">
        <c:forEach var="facetvalue" items="${requestScope.facetnav.folders}">
          <c:if test="${facetvalue.count > 0}">

            <c:set var="selectedItem" scope="page" value="${null}"/>
            <c:forEach items="${facetvalue.folders}" var="item">
              <c:if test="${item.leaf and item.count gt 0}">
                <c:set var="selectedItem" scope="page" value="${item}"/>
              </c:if>
            </c:forEach>

            <li${selectedItem ne null ? ' class="clear"' : ''}>

              <span><span class="name"><c:out value="${facetvalue.name}"/>:</span>

              <c:choose>
                <c:when test="${selectedItem ne null}">
                  <hst:facetnavigationlink remove="${selectedItem}" current="${requestScope.facetnav}" var="removeLink"/>
                  <a class="filter" href="#">
                    <c:out value="${selectedItem.name}"/>&nbsp;(<c:out value="${selectedItem.count}"/>)
                  </a></span>
                  <fmt:message key="mobile.products.searchfacets.clearfilter" var="searchFacetsClearFilter"/>
                  <c:set var="clearTitle"><c:out value=" ${selectedItem.name}${searchFacetsClearFilter}"/></c:set>
                  <a class="clear" href="${removeLink}" title="${clearTitle}">&nbsp;</a>
                </c:when>
                <c:otherwise>
                  <fmt:message key="mobile.products.searchfacets.any" var="searchFacetsAny"/>
                  <a href="#"><c:out value=" ${searchFacetsAny}${facetvalue.name}"/></a></span>
                  <ul class="subsubfilter">
                    <c:forEach items="${facetvalue.folders}" var="item">
                      <hst:link var="link" hippobean="${item}" navigationStateful="true">
                        <hst:sitemapitem preferPath="mobile/products"/>
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
  <li id="sort-by" class="last"><span><span class="name"><fmt:message key="mobile.products.searchfacets.sortby" var="searchfacetssortby"/> <c:out value="searchfacetssortby"/></span>
  <a href="#">
    <c:choose>
      <c:when test="${requestScope.order == 'title'}"><fmt:message key="mobile.products.searchfacets.name" var="searchfacetsname"/> <c:out value="searchfacetsname"/></c:when>
      <c:when test="${requestScope.order == '-rating'}"><fmt:message key="mobile.products.searchfacets.mostpopular" var="searchfacetsmostpopular"/> <c:out value="searchfacetsmostpopular"/></c:when>
      <c:when test="${requestScope.order == '-lastModificationDate'}"><fmt:message key="mobile.products.searchfacets.mostrecent" var="searchfacetsmostrecent"/> <c:out value="searchfacetsmostrecent"/></c:when>
      <c:when test="${requestScope.order == '-price'}"><fmt:message key="mobile.products.searchfacets.pricehtl" var="searchfacetspricehtl"/> <c:out value="searchfacetspricehtl"/></c:when>
      <c:when test="${requestScope.order == 'price'}"><fmt:message key="mobile.products.searchfacets.pricelth" var="searchfacetspricelth"/> <c:out value="searchfacetspricelth"/></c:when>
      <c:otherwise><fmt:message key="mobile.products.searchfacets.relevance" var="searchfacetsrelevance"/> <c:out value="searchfacetsrelevance"/></c:otherwise>
    </c:choose>
  </a>
  </span>
    <ul class="subsubfilter">
      <c:if test="${requestScope.order ne 'relevance'}">
        <li><a href="?query=${requestScope.query}&amp;order=relevance"><fmt:message key="mobile.products.searchfacets.relevance" var="searchfacetsrelevance"/> <c:out value="searchfacetsrelevance"/></a></li>
      </c:if>
      <c:if test="${requestScope.order ne 'title'}">
        <li><a href="?query=${requestScope.query}&amp;order=title"><fmt:message key="mobile.products.searchfacets.name" var="searchfacetsname"/> <c:out value="searchfacetsname"/></a>
        </li>
      </c:if>
      <c:if test="${requestScope.order ne '-rating'}">
        <li><a href="?query=${requestScope.query}&amp;order=-rating"><fmt:message key="mobile.products.searchfacets.mostpopular" var="searchfacetsmostpopular"/> <c:out value="searchfacetsmostpopular"/></a></li>
      </c:if>
      <c:if test="${requestScope.order ne '-lastModificationDate'}">
        <li><a href="?query=${requestScope.query}&amp;order=-lastModificationDate"><fmt:message key="mobile.products.searchfacets.mostrecent" var="searchfacetsmostrecent"/> <c:out value="searchfacetsmostrecent"/></a></li>
      </c:if>
      <c:if test="${requestScope.order ne '-price'}">
        <li><a href="?query=${requestScope.query}&amp;order=-price"><fmt:message key="mobile.products.searchfacets.pricehtl" var="searchfacetspricehtl"/> <c:out value="searchfacetspricehtl"/></a></li>
      </c:if>
      <c:if test="${requestScope.order ne 'price'}">
        <li><a href="?query=${requestScope.query}&amp;order=price"><fmt:message key="mobile.products.searchfacets.pricelth" var="searchfacetspricelth"/> <c:out value="searchfacetspricelth"/></a></li>
      </c:if>
    </ul>
  </li>
</ul>
