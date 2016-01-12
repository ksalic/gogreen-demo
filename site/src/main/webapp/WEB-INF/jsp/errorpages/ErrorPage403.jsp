<%--
  Copyright 2008-2013 Hippo B.V. (http://www.onehippo.com)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="org.hippoecm.hst.core.container.ContainerSecurityException" %>
<%@ page import="org.hippoecm.hst.core.container.ContainerSecurityNotAuthenticatedException" %>
<%@ page import="org.hippoecm.hst.core.container.ContainerSecurityNotAuthorizedException" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix="hst"%>

<fmt:setBundle basename="org.hippoecm.hst.security.servlet.LoginServlet" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>
         <fmt:message key="label.access.forbidden" />
    </title>
    <link rel="stylesheet" type="text/css" href="<hst:link path='/login/hst/security/skin/screen.css' mount='site'/>" />
  </head>
  <body class="hippo-root">
    <div>
      <div class="hippo-login-panel">
        <h2></h2>
        <div style="text-align: center;">
          <fmt:message key="label.access.forbidden" />
        </div>
        <div class="hippo-login-panel-copyright">
          &copy; 1999-2012 Hippo B.V.
        </div>
      </div>
    </div>
  </body>
</html>