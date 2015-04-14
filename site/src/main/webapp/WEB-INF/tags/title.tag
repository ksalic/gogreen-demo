<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

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

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="hst" uri="http://www.hippoecm.org/jsp/hst/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="title" type="java.lang.String" required="true" rtexprvalue="true" %>
<hst:setBundle basename="messages,typenames"/>
<c:set var="metatitle" value=" - ${document.metaTitle}" />
<c:set var="dctitle" value="${document.metaTitle}" />
<hst:element var="head" name="title">
    <hst:defineObjects/>
    <c:set var="channelInfo" value="${hstRequest.requestContext.resolvedMount.mount.channelInfo}"/>
    <c:set var="separator" value=""/>
    <c:if test="${not empty channelInfo and not empty channelInfo.pageTitlePrefix}">
        <c:out value="${channelInfo.pageTitlePrefix}"/>
        <c:set var="separator" value=" - "/>
    </c:if>
    <c:if test="${empty metatitle}">
         <c:if test="${not empty title}">
        <c:set  var="metatitle" value="${separator}${title}"/>
        </c:if>
    </c:if>
    <c:out value="${metatitle}"/>
</hst:element>
<hst:headContribution keyHint="title" element="${head}" />
<c:set var="metadesc" value="${document.metaDescription}" />
<c:if test="${empty metadesc}">
    <fmt:message key="layout.webpage.metadescription" var="metadesc"/>
</c:if>
<hst:headContribution>
  <meta name="description" content="${metadesc}"/>
</hst:headContribution>
<c:if test="${empty dctitle}">
  <fmt:message key="layout.webpage.metadctitle" var="dctitle"/>
</c:if>
<hst:headContribution>
  <meta name="DC.keywords" content="<fmt:message key='layout.webpage.metadckeywords'/>"/>
</hst:headContribution>






