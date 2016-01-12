<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<!-- search results -->
<div id="content">
    <div id="events" class="results">
        <c:set var="style">event-item</c:set>
        <c:forEach items="${requestScope.docs.items}" var="event">
            <ul class="${style}">
                <li class="full-link"><a href="<hst:link hippobean="${event}"/>"></a></li>
                <li class="calendar"><img src="<hst:link path="/images/mobile/bg-calendar.png"/>" alt="" />
                    <span class="month"><fmt:formatDate value="${event.date.time}" pattern="MMM"/></span>
                    <span class="day"><fmt:formatDate value="${event.date.time}" pattern="dd"/></span>
                </li>
                <c:url var="linkUrl" value="http://maps.google.com/?q=${event.location.street} ${event.location.number}, ${event.location.city} ${event.location.postalCode} ${event.location.province}"/>
                <c:url var="imageUrl" value="http://maps.google.com/maps/api/staticmap?zoom=10&size=150x100&maptype=roadmap&markers=color:green|${event.location.street} ${event.location.number}, ${event.location.city} ${event.location.postalCode} ${event.location.province}&sensor=true"/>
                <li class="gmaps"><a href="${fn:escapeXml(linkUrl)}">
                    <img src="${fn:escapeXml(imageUrl)}" alt="Google Maps"/>
                </a></li>
                <li class="title"><a href="<hst:link hippobean="${event}"/>"><c:out value="${event.title}"/></a></li>
            </ul>
        </c:forEach>

    </div>
    
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
                <img id="load" style="float:right;display:none;" src=" <hst:link path="/images/mobile/spinner.gif"/>" alt="<fmt:message key="mobile.events.searchresults.loading"/>" />
                <a class="more" href="?jsEnabled=false&amp;pageSize=${requestScope.pageSize + 25}&amp;from=${requestScope.pageSize}&amp;count=${requestScope.count}">
                  <fmt:message key="mobile.events.searchresults.showmore">
            		<fmt:param value="${howMany}"/>            		
            	  </fmt:message>  
                </a>
            </div>
    </c:if>
</div>
