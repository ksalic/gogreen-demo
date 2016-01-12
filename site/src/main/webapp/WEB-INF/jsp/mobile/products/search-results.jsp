<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<!-- search results -->
<div id="content">
    <div id="products" class="results">

            <c:set var="style">product-item</c:set>
            <%--@elvariable id="docs" type="com.onehippo.gogreen.utils.PageableCollection"--%>
            <c:forEach items="${requestScope.docs.items}" var="product"  varStatus="status">
                <hst:link var="prdlink" hippobean="${product}"/>
                <ul class="${style}">
                    <li class="full-link"><a href="${fn:escapeXml(prdlink)}"></a></li>
                    <c:choose>
                        <c:when test="${not empty product.firstImage and not empty product.firstImage.mobileThumbnail}">
                            <hst:link var="thumbnail" hippobean="${product.firstImage.mobileThumbnail}"/>
                            <li class="image"><img src="${thumbnail}" alt="" /></li>
                        </c:when>
                        <c:when test="${not empty product.firstImage and not empty product.firstImage.smallThumbnail}">
                            <hst:link var="thumbnail" hippobean="${product.firstImage.smallThumbnail}"/>
                            <li class="image"><img src="${thumbnail}" alt="" width="40" height="40" /></li>
                        </c:when>
                        <c:otherwise>
                            <li class="image"></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="title"><a href="${fn:escapeXml(prdlink)}"><c:out value="${product.title}"/></a></li>
                    <li class="price"><span><fmt:formatNumber value="${product.price}" type="currency"/></span>|</li>
                    <fmt:formatNumber value="${product.rating * 10}" var="ratingStyle" pattern="#0" />
                    <li class="rating stars-${ratingStyle}"><span><c:out value="${product.rating}"/></span></li>
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
                <img id="load" style="float:right;display:none;" src=" <hst:link path="/images/mobile/spinner.gif"/>" alt="<fmt:message key="mobile.products.searchresults.loading"/>" />
                <a class="more" href="?jsEnabled=false&amp;pageSize=${requestScope.pageSize + 25}&amp;from=${requestScope.pageSize}&amp;count=${requestScope.count}">
                  <fmt:message key="mobile.products.searchresults.showmore">
                    <fmt:param value="${howMany}"/>                 
                  </fmt:message> 
                </a>
            </div>
    </c:if>
</div>
