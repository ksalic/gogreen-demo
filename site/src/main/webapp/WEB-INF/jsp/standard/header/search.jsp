<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst'%>
<%@include file="../../includes/tags.jspf" %>

<div class="col-sm-6" id="top-search">

    <hst:include ref="login"/>

    <hst:link siteMapItemRefId="search" var="doSearch" />
    <c:set var="searchText"><fmt:message key="searchform.search" /></c:set>
    <div class="searchbox">
        <form action="${doSearch}" method="get" onsubmit="sanitizeRequestParam(document.forms['searchSubmit']['query'], '${searchText}')">
            <input type="text" class="searchbox-inputtext" id="searchbox-inputtext" name="query" placeholder="<fmt:message key="searchform.search" />"/>
            <label class="searchbox-icon" for="searchbox-inputtext"></label>
            <input type="submit" class="searchbox-submit" value="${searchText}"/>
        </form>
    </div>

  <hst:setBundle basename="social.links"/>
  <div class="social-icons">
    <ul>
      <li>
        <a href="<fmt:message key="facebook.url" />" target="_blank" class="social-media-icon facebook-icon" data-original-title="facebook">facebook</a>
      </li>
      <li>
        <a href="<fmt:message key="twitter.url" />" target="_blank" class="social-media-icon twitter-icon" data-original-title="twitter">twitter</a>
      </li>
  </div>
</div>
