<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<div id="ft">
  
  <div id="ft-info">
    <p>
      <fmt:message key="mobile.standard.footer.disclaimer" var="footerDisclaimer">
        <fmt:param><a href="https://www.bloomreach.com/en/products/experience/hippo-cms" target="_blank"></fmt:param>
        <fmt:param><a href="https://groups.google.com/forum/#!forum/hippo-community" target="_blank"></fmt:param>
        <fmt:param></a></fmt:param>
      </fmt:message>
      <c:out value="${footerDisclaimer}"/>
    </p>
  </div>
</div>
