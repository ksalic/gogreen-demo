<%--
  Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../includes/tags.jspf" %>
<hst:defineObjects/>
<div class="hst-container">     
    <c:forEach var="childContentName" items="${hstResponse.childContentNames}">
           <hst:include ref="${childContentName}"/>
    </c:forEach>
</div>