<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<!-- right -->
<div id="right" class="yui-b">
  <ul class="box-general" id="search-options">
    <li class="title"><fmt:message key="search.errorright.title"/></li>
    <li class="text">
      <p><fmt:message key="search.errorright.checkaddress"/></p>
      <span><fmt:message key="search.errorright.goto"/></span>
      <ul class="bullet-points">
        <hst:link var="home" siteMapItemRefId="home" />
        <li><a href="${home}"><fmt:message key="search.errorright.homepagelink"/></a></li>
        <c:if test="${requestScope.parentpage ne '' and requestScope.parentpage ne 'home'}" >
          <li><a href="<hst:link path="${requestScope.parentpage}"/>"><fmt:message key="search.errorright.parentlink"/></li>
        </c:if>
        <hst:link var="sitemap" siteMapItemRefId="sitemap" />
        <li><a href="${sitemap}"><fmt:message key="search.errorright.sitemaplink"/></a></li>
      </ul>
      
      <p><fmt:message key="search.errorright.startsearch"/></p>
      <%-- TODO: search form --%> search form
    </li>
  </ul>
</div>
