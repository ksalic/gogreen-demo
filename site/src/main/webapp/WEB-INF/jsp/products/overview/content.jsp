<%--

    Copyright 2010-2016 Hippo B.V. (http://www.onehippo.com)

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
<c:forEach items="${requestScope.docs.items}" var="product" varStatus="status">
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
                <a href="${link}"><c:out value="${product.title}"/></a>
            </h3>
            <p>
                <c:out value="${product.summary}"/>
            </p>
        </div>

        <div class="feature-details">
            <i class="icon-banknote"> </i>
            <span class="${requestScope.reseller ? 'nonresellerprice' : ''}"><fmt:formatNumber value="${product.price}" type="currency"/></span>
            <c:if test="${requestScope.reseller}">
                <span class="resellerprice"><fmt:formatNumber value="${product.resellerPrice}" type="currency"/></span>
            </c:if>
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
  <c:when test="${requestScope.docs.total eq 0}">
    <p id="results"><fmt:message key="search.results.noresults"/> '${requestScope.query}'</p>
  </c:when>
  <c:otherwise>
    <hippo-gogreen:pagination pageableResult="${requestScope.docs}" queryName="query" queryValue="${requestScope.query}"/>
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