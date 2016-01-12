<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<c:set var="mobileeventstitle"><fmt:message key="mobile.events.overview.title"/></c:set>
<hippo-gogreen:title title="${mobileeventstitle}"/>

<!-- body / main -->
<div id="bd">

    <!-- search results -->
    <div id="content">
        <div id="events" class="results">

            <hst:include ref="boxes-top"/>
            <c:set var="style">event-item</c:set>
            <c:forEach items="${requestScope.docs.items}" var="item">

                <ul class="${style}">
                    <li class="full-link"><a href="<hst:link hippobean="${item}"/>"></a></li>
                    <li class="calendar"><img src="<hst:link path="/images/mobile/bg-calendar.png"/>" alt=""/>
                        <span class="month"><fmt:formatDate value="${item.date.time}" pattern="MMM"/></span>
                        <span class="day"><fmt:formatDate value="${item.date.time}" pattern="dd"/></span>
                    </li>
                    <c:set var="test" value="${fn:escapeXml(item.location.street)}"/>
                    <c:url var="linkUrl" value="http://maps.google.com/?q=${item.location.street} ${item.location.number}, ${item.location.city} ${item.location.postalCode} ${item.location.province}"/>
                    <c:url var="imageUrl" value="http://maps.google.com/maps/api/staticmap?zoom=10&size=150x100&maptype=roadmap&markers=color:green|${item.location.street} ${item.location.number}, ${item.location.city} ${item.location.postalCode} ${item.location.province}&sensor=true"/>
                    <li class="gmaps"><a href="${fn:escapeXml(linkUrl)}">
                        <img src="${fn:escapeXml(imageUrl)}" alt="Google Maps"/>
                    </a></li>
                    <li class="title"><a href="<hst:link hippobean="${item}"/>"><c:out value="${item.title}"/></a></li>
                </ul>
            </c:forEach>

        <c:if test="${requestScope.count > requestScope.pageSize}">
            <div id="show-more">
                <c:choose>
                  <c:when test="${requestScope.count - requestScope.pageSize > requestScope.defaultShowMore}">
                      <c:set var="howMany" value="${requestScope.defaultShowMore}" />
                  </c:when>
                  <c:otherwise>
                      <c:set var="howMany" value="${requestScope.count - requestScope.pageSize}" />
                  </c:otherwise>
                </c:choose>
                <img id="load" style="float:right;display:none;" src=" <hst:link path="/images/mobile/spinner.gif"/>" alt="<fmt:message key="mobile.events.overview.loading"/>" />
                <a class="more" href="?jsEnabled=false&amp;pageSize=${requestScope.pageSize + 25}&amp;from=${requestScope.pageSize}&amp;lcount=${requestScope.count}">
                  <fmt:message key="mobile.events.overview.showmore">
            		<fmt:param value="${howMany}"/>            		
            	  </fmt:message>   
                </a>
            </div>
        </c:if>
    </div>
    <div id="extra">
        <a href="layar://gogreenevents"><fmt:message key="mobile.events.overview.viewinlayar"/></a>
    </div>
  </div>
</div>