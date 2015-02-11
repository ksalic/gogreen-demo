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

<%@include file="../../includes/tags.jspf" %>

<hst:include ref="boxes-top"/>

<c:set var="style">product-item</c:set>
<%--@elvariable id="docs" type="com.onehippo.gogreen.utils.PageableCollection"--%>
<c:forEach items="${docs.items}" var="product">
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
