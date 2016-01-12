<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="hst" uri="http://www.hippoecm.org/jsp/hst/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="title" type="java.lang.String" required="true" rtexprvalue="true" %>

<hst:element var="head" name="title">
  <hst:defineObjects/>
  <c:set var="channelInfo" value="${hstRequest.requestContext.resolvedMount.mount.channelInfo}"/>
  <c:set var="separator" value=""/>
  <c:if test="${not empty channelInfo and not empty channelInfo.pageTitlePrefix}">
    <c:out value="${channelInfo.pageTitlePrefix}"/>
    <c:set var="separator" value=" - "/>
  </c:if>
  <c:if test="${not empty title}"><c:out value="${separator}${title}"/></c:if>
</hst:element>
<hst:headContribution keyHint="title" element="${head}" />
