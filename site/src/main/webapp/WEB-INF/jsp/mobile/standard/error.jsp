<%--

    Copyright 2011-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<!-- body / main -->
<div id="bd">
  <div id="content">
	  <p class="error">
      <fmt:message key="search.results.pagenotfound" var="resultspagenotfound"/> <c:out value="resultspagenotfound"/>
      <br/>
      <fmt:message key="search.results.notfounddescr" var="resultsnotfounddescr"/> <c:out value="resultsnotfounddescr"/>
    </p>
  </div>
</div>
