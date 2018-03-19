<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

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
    <fmt:message key="searchform.search" var="searchText"/>
    <div class="searchbox">
        <form action="${doSearch}" method="get" onsubmit="sanitizeRequestParam(document.forms['searchSubmit']['query'], '<c:out value="${searchText}"/>')">
            <input type="text" class="searchbox-inputtext" id="searchbox-inputtext" name="query" placeholder="<c:out value="${searchText}"/>"/>
            <label class="searchbox-icon" for="searchbox-inputtext"></label>
            <input type="submit" class="searchbox-submit" value="<c:out value="${searchText}"/>"/>
        </form>
    </div>

  <hst:setBundle basename="social.links"/>
  <div class="social-icons">
    <ul>
      <li>
        <a href="<fmt:message key="facebook.url" var="facebookUrl"/><c:out value="${facebookUrl}"/>" target="_blank" class="social-media-icon facebook-icon" data-original-title="facebook">facebook</a>
      </li>
      <li>
        <a href="<fmt:message key="twitter.url" var="twitterUrl"/><c:out value="${twitterUrl}"/>" target="_blank" class="social-media-icon twitter-icon" data-original-title="twitter">twitter</a>
      </li>
  </div>
</div>
