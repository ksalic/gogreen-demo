<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>


<c:set var="style">event-item</c:set>
<c:forEach items="${requestScope.docs.items}" var="item">
    <ul class="${style}">
        <li class="full-link"><a href="<hst:link hippobean="${item}"/>"></a></li>
        <li class="calendar"><img src="<hst:link path="/images/mobile/bg-calendar.png"/>" alt="" />
            <span class="month"><fmt:formatDate value="${item.date.time}" pattern="MMM"/></span>
            <span class="day"><fmt:formatDate value="${item.date.time}" pattern="dd"/></span>
        </li>
        <c:url var="linkUrl" value="http://maps.google.com/?q=${item.location.street} ${item.location.number}, ${item.location.city} ${item.location.postalCode} ${item.location.province}"/>
        <c:url var="imageUrl" value="http://maps.google.com/maps/api/staticmap?zoom=10&size=150x100&maptype=roadmap&markers=color:green|${item.location.street} ${item.location.number}, ${item.location.city} ${item.location.postalCode} ${item.location.province}&sensor=true"/>
        <li class="gmaps"><a href="${fn:escapeXml(linkUrl)}">
            <img src="${fn:escapeXml(imageUrl)}" alt="Google Maps" />
        </a></li>
        <li class="title"><a href="<hst:link hippobean="${item}"/>"><c:out value="${item.title}"/></a></li>
    </ul>
</c:forEach>
