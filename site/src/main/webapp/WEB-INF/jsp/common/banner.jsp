<%--
  Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)
--%>
<%@include file="../includes/tags.jspf" %>
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.Banner"--%>

<!-- Banner -->
<c:choose>
<c:when test="${not empty requestScope.document}">

<c:if test="${not empty requestScope.title}">
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h2 class="h2-section-title"><c:out value="${requestScope.title}"/></h2>
            <c:if test="${not empty requestScope.icon}">
                <div class="i-section-title">
                    <i class="fa <c:out value="${requestScope.icon}"/>"></i>
                </div>
            </c:if>
        </div>
    </div>
</c:if>

<c:choose>
    <c:when test="${requestScope.bannerBackground == 'blue'}">
        <c:set var="cssClasses">section-color-dark-blue white-text</c:set>
    </c:when>
    <c:when test="${requestScope.bannerBackground == 'full'}">
        <c:set var="imageSrc">
            <hst:link hippobean="${requestScope.document.image.original}"/>
        </c:set>
    <div class="banner-component section-content full-banner no-padding" style="background-image: url('${imageSrc}')">
        <hst:cmseditlink hippobean="${requestScope.document}" />
    </div>
    </c:when>
    <c:otherwise>
        <c:set var="cssClasses">no-padding</c:set>
    </c:otherwise>
</c:choose>

<c:if test="${requestScope.bannerBackground ne 'full'}">
    <div class="banner-component section-content <c:out value="${cssClasses}"/>">
        <div class="container">
            <div class="row">
                <hst:cmseditlink hippobean="${requestScope.document}" />

                <c:choose>
                    <c:when test="${requestScope.bannerBackground == 'blue'}">
                        <div class="col-md-6 col-sm-6 animated fadeInLeftBig animatedVisi" data-animtype="fadeInLeftBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                            <div class="space-sep100"></div>

                            <c:choose>
                                <c:when test="${not empty requestScope.document.docLink}">
                                    <h2 class="h2-section-title"><a href="<hst:link hippobean="${requestScope.document.docLink}"/>"><c:out value="${requestScope.document.title}"/></a></h2>
                                </c:when>
                                <c:otherwise>
                                    <h2 class="h2-section-title"><c:out value="${requestScope.document.title}"/></h2>
                                </c:otherwise>
                            </c:choose>

                            <h3 class="h3-section-info"><c:out value="${requestScope.document.text}"/></h3>
                        </div>

                        <div class="col-md-6 col-sm-6 animated fadeInRightBig animatedVisi" data-animtype="fadeInRightBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                            <div class="right-image-container">
                                <img src="<hst:link hippobean="${requestScope.document.image}"/>" height="300" alt="" />
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-md-12 col-sm-12 animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                            <c:choose>
                                <c:when test="${not empty requestScope.document.docLink}">
                                    <h2 class="h2-section-title"><a href="<hst:link hippobean="${requestScope.document.docLink}"/>"><c:out value="${requestScope.document.title}"/></a></h2>
                                </c:when>
                                <c:otherwise>
                                    <h2 class="h2-section-title"><c:out value="${requestScope.document.title}"/></h2>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not empty requestScope.bannerIcon}">
                                <div class="i-section-title">
                                    <i class="fa ${requestScope.bannerIcon}">

                                    </i>
                                </div>
                            </c:if>

                            <h3 class="h3-section-info"><c:out value="${requestScope.document.text}"/></h3>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <c:if test="${requestScope.bannerBackground == 'white'}">
                <div class="row">
                    <div class="col-md-12 col-sm-12 no-bottom-margin animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.7s" style="-webkit-animation: 1s 0.7s;">
                        <div class="align-center">
                            <c:if test="${not empty requestScope.document.image}">
                                <img src="<hst:link hippobean="${requestScope.document.image.banner}"/>" alt="<fmt:message key="document.image.alt"/>" class="img-responsive"/>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</c:if>

<c:if test="${requestScope.separatorBorderTop}">
    <c:set var="cssClass"> border-top</c:set>
</c:if>
<c:if test="${requestScope.separatorBorderBottom}">
    <c:set var="cssClass">${cssClass} border-bottom</c:set>
</c:if>
<c:if test="${not empty requestScope.separatorMargin or not empty cssClass}">
    <div class="space-sep<c:out value="${requestScope.separatorMargin} ${cssClass}"/>"></div>
</c:if>

</c:when>
<c:otherwise>
    <c:if test="${requestScope.preview}">
        <h2 class="not-configured">Click to configure banner</h2>
    </c:if>
</c:otherwise>
</c:choose>