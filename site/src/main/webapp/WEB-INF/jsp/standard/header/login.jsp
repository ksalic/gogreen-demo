<%--

    Copyright 2010-2016 Hippo B.V. (http://www.onehippo.com)

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

<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst'%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<hst:setBundle basename="messages"/>
<hst:link var="destination" />
<div class="container">
<!-- login -->
<c:choose>
  <c:when test="${requestScope.loggedin}">
    <div id="login">
      <span class="username"><fmt:message key="standard.header.login.welcome"/>
        <c:if test="${not empty requestScope.user.firstname}">,&nbsp;${requestScope.user.firstname}</c:if>
        <c:if test="${not empty requestScope.user.lastname}">&nbsp;${requestScope.user.lastname}</c:if>
      </span>
      <hst:link var="logoutLink" path="/login/logout" />
      <span class="first">&nbsp;&nbsp;<a class="black" href="${logoutLink}?destination=${destination}"><fmt:message key="standard.header.login.logoutlink"/></a></span>
    </div>
  </c:when>
  <c:when test="${requestScope.login}">

    <hst:link var="loginLink" path="/login/proxy" />
    <div id="login-form">
      <form action="${loginLink}" method="post" role="form" class="form-inline">
          <input type="hidden" name="destination" value="${destination}" />
          <div class="form-group">
        <input class="form-control" type="text" name="username" value="<fmt:message key="standard.header.login.input.username"/>" onclick="this.value='';" />
        </div>
      <div class="form-group">
          <input class="form-control" type="password" name="password" value="<fmt:message key="standard.header.login.input.password"/>" onclick="this.value='';" />
      </div>
      <input type="submit" value="<fmt:message key="standard.header.login.submit.label"/>" id="login-button" class="btn-default"/>
      <c:if test="${requestScope.error}">
          <div class="alert alert-warning"><fmt:message key="standard.header.login.error"/></div>
      </c:if>
      </form>
    </div>
  </c:when>
  <c:otherwise>
    <div id="login">
      <span class="first"><a href="?login=true"><fmt:message key="standard.header.login.loginlink"/></a></span>
    </div>
  </c:otherwise>
</c:choose>
</div>