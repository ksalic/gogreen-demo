<%--

    Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@ taglib prefix='hst' uri="http://www.hippoecm.org/jsp/hst/core" %>

<hst:link var="redirectUrl" path="/">
  <hst:param name="login" value="true"/>
  <hst:param name="error" value="true"/>
</hst:link>
<html>
  <head>
    <meta http-equiv="refresh" content="0;URL=${redirectUrl}" />
  </head>
<body>
</body>
</html>
