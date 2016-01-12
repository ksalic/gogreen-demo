<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:include ref="boxes-top"/>

<c:set var="style">product-item</c:set>
<%--@elvariable id="docs" type="com.onehippo.gogreen.utils.PageableCollection"--%>
<c:forEach items="${requestScope.docs.items}" var="product">
    <hst:link var="prdlink" hippobean="${product}"/>
    <ul class="${style}">
        <li class="full-link"><a href="${prdlink}"></a></li>
        <c:choose>
            <c:when test="${not empty product.firstImage and not empty product.firstImage.mobileThumbnail}">
                <hst:link var="thumbnail" hippobean="${product.firstImage.mobileThumbnail}"/>
                <li class="image"><img src="${thumbnail}" alt="" /></li>
            </c:when>
            <c:when test="${not empty product.firstImage and not empty product.firstImage.smallThumbnail}">
                <hst:link var="thumbnail" hippobean="${product.firstImage.smallThumbnail}"/>
                <li class="image"><img src="${thumbnail}" width="40" height="40" alt="" /></li>
            </c:when>
            <c:otherwise>
                <li class="image"></li>
            </c:otherwise>
        </c:choose>
        <li class="title"><a href="${prdlink}"><c:out value="${product.title}"/></a></li>
        <li class="price"><span><fmt:formatNumber value="${product.price}" type="currency"/></span>|</li>
        <fmt:formatNumber value="${product.rating * 10}" var="ratingStyle" pattern="#0" />
        <li class="rating stars-${ratingStyle}"><span><c:out value="${product.rating}"/></span></li>
    </ul>
</c:forEach>
