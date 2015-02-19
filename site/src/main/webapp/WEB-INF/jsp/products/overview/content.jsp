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

<hst:headContribution keyHint="rateJs" category="headScripts">
    <hst:link path="/js/jquery.raty.js" var="rateJs"/>
    <script type="text/javascript" src="${rateJs}"></script>
</hst:headContribution>

<hst:headContribution keyHint="rateCss" category="css">
    <hst:link path="/css/jquery.raty.css" var="rateCss"/>
    <link rel="stylesheet" href="${rateCss}"/>
</hst:headContribution>

<hst:include ref="productnav"/>

<div class="isotope" id="masonry-elements">
<%--@elvariable id="docs" type="com.onehippo.gogreen.utils.PageableCollection"--%>
<c:forEach items="${docs.items}" var="product" varStatus="status">
    <%--@elvariable id="product" type="com.onehippo.gogreen.beans.Product"--%>
    <hst:link var="link" hippobean="${product}"/>
    <div class="feature blog-masonry isotope-item">

        <hst:cmseditlink hippobean="${product}" />
        <c:set var="image" value="${product.firstImage}"/>
        <c:if test="${image != null and image.largeThumbnail != null}">
            <div class="feature-image img-overlay">
                <hst:link var="src" hippobean="${image.largeThumbnail}"/>
                <img src="${src}" alt="${fn:escapeXml(image.alt)}" />
                <div class="item-img-overlay">
                    <div class="item_img_overlay_link">
                      <a href="${link}" title="${product.title}"> </a>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="feature-content">
            <h3 class="h3-body-title blog-title">
                <a href="${link}">${product.title}</a>
            </h3>
            <p>
                ${product.summary}
            </p>
        </div>

        <div class="feature-details">
            <i class="icon-banknote"> </i>
            <span><fmt:formatNumber value="${product.price}" type="currency"/></span>
            <div class="feature-share">
                <c:if test="${product.rating ne 0}">
                    <span data-score="${product.rating}" class="product-rating"/>
                </c:if>
            </div>
        </div>

    </div>
</c:forEach>
</div>

<c:choose>
  <c:when test="${docs.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults"/> '${query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${docs}" queryName="query" queryValue="${query}"/>
  </c:otherwise>
</c:choose>

<script type="text/javascript">
    $('#masonry-elements .product-rating').raty({
        score: function() {
            return $(this).attr('data-score');
        },
        readOnly: true,
        half: true,
        starType :  'i'
    });
</script>