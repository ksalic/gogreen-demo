<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>


<div id="left" class="yui-b">
  <c:if test="${fn:length(requestScope.facets) gt 0}">
    <ul id="left-nav">
        <%--@elvariable id="facets" type="java.util.List<org.hippoecm.hst.content.beans.standard.HippoFolder>"--%>
        <c:forEach items="${facets}" var="facet">
            <li><a href="<hst:link hippobean="${facet}"/>"><c:out value="${facet.name}"/></a></li>
        </c:forEach>
    </ul>
  </c:if>
  <!-- components container -->
  <hst:include ref="boxes-left"/>
</div>

