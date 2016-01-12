<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>
<c:if test="${requestScope.separatorBorderTop}">
    <c:set var="cssClass"> border-top</c:set>
</c:if>
<c:if test="${requestScope.separatorBorderBottom}">
    <c:set var="cssClass">${cssClass} border-bottom</c:set>
</c:if>
<div class="space-sep<c:out value="${requestScope.separatorMargin} ${cssClass}"/>"></div>