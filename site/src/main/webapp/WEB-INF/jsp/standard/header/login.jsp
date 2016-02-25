<%--

    Copyright 2010-2016 Hippo B.V. (http://www.onehippo.com)

--%>

<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst'%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<hst:defineObjects />

<hst:setBundle basename="messages"/>
<hst:link var="destination" />
<!-- login -->
<c:choose>
  <c:when test="${requestScope.loggedin}">
    <div id="login" class="logged-in">
      <i class="fa fa-user"></i>
      <span class="username">
        <c:if test="${not empty requestScope.user.firstname}">${requestScope.user.firstname}</c:if>
        <c:if test="${not empty requestScope.user.lastname}">&nbsp;${requestScope.user.lastname}</c:if>
      </span>
      <hst:link var="logoutLink" path="/login/logout" />
      <c:choose>
        <c:when test="${hstRequestContext.resolvedSiteMapItem.hstSiteMapItem.authenticated}">
          <span class="first">&nbsp;&nbsp;<a class="black" href="${logoutLink}"><i class="fa fa-times"></i></a></span>
        </c:when>
        <c:otherwise>
          <span class="first">&nbsp;&nbsp;<a class="black" href="${logoutLink}?destination=${destination}"><i class="fa fa-times"></i></a></span>
        </c:otherwise>
      </c:choose>
    </div>
  </c:when>
  <c:otherwise>
    <hst:link var="loginLink" path="/login/proxy" />
    <div id="login">
      <a href="#" onClick="return false;"><i class="fa fa-unlock-alt default"></i><i class="fa fa-unlock hover"></i></a>
    </div>
    <div id="login-form" style="display: none;" class="accordion">
      <form action="${loginLink}" method="post" role="form" class="form-inline accordion-row">
        <input type="hidden" name="destination" value="${destination}" />
        <c:if test="${requestScope.error}">
          <div class="alert alert-warning login-alert">
            <fmt:message key="standard.header.login.error"/>
          </div>
          <script type="text/javascript">
            $("#login").toggle();
            $("#login-form").toggle();
          </script>
        </c:if>
        <div class="open-icon close-icon"></div>
        <div class="form-group">
          <input class="form-control" type="text" name="username" placeholder="<fmt:message key="standard.header.login.input.username"/>"/>
        </div>
        <div class="form-group">
          <input class="form-control" type="password" name="password" placeholder="<fmt:message key="standard.header.login.input.password"/>" />
        </div>
        <input type="submit" value="<fmt:message key="standard.header.login.submit.label"/>" id="login-button" class="btn-default"/>
      </form>
    </div>
    <script type="text/javascript">
      $("#login a").click(function() {
        $("#login").toggle();
        $("#login-form").toggle();
      });
      $("#login-form .close-icon").click(function() {
        $("#login").toggle();
        $("#login-form").toggle();
      });
    </script>
  </c:otherwise>
</c:choose>
