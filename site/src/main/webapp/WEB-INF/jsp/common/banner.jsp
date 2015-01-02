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
<%@include file="../includes/tags.jspf" %>
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.Banner"--%>

<!-- Banner -->
<c:choose>
<c:when test="${not empty document}">

<c:if test="${not empty title}">
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h2 class="h2-section-title"><c:out value="${title}"/></h2>
            <c:if test="${not empty icon}">
                <div class="i-section-title">
                    <i class="fa <c:out value="${icon}"/>"></i>
                </div>
            </c:if>
        </div>
    </div>
</c:if>

<c:choose>
    <c:when test="${bannerBackground == 'blue'}">
        <c:set var="cssClasses">section-color-dark-blue white-text</c:set>
    </c:when>
    <c:when test="${bannerBackground == 'full'}">
        <c:set var="imageSrc">
            <hst:link hippobean="${document.image.original}"/>
        </c:set>
    <div class="banner-component section-content full-banner no-padding" style="background-image: url('${imageSrc}')">
        <hst:cmseditlink hippobean="${document}" />
    </div>
    </c:when>
    <c:otherwise>
        <c:set var="cssClasses">no-padding</c:set>
    </c:otherwise>
</c:choose>

<c:if test="${bannerBackground ne 'full'}">
    <div class="banner-component section-content <c:out value="${cssClasses}"/>">
        <div class="container">
            <div class="row">
                <hst:cmseditlink hippobean="${document}" />

                <c:choose>
                    <c:when test="${bannerBackground == 'blue'}">
                        <div class="col-md-6 col-sm-6 animated fadeInLeftBig animatedVisi" data-animtype="fadeInLeftBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                            <div class="space-sep100"></div>

                            <c:choose>
                                <c:when test="${not empty document.docLink}">
                                    <h2 class="h2-section-title"><a href="<hst:link hippobean="${document.docLink}"/>"><c:out value="${document.title}"/></a></h2>
                                </c:when>
                                <c:otherwise>
                                    <h2 class="h2-section-title"><c:out value="${document.title}"/></h2>
                                </c:otherwise>
                            </c:choose>

                            <h3 class="h3-section-info"><c:out value="${document.text}"/></h3>
                        </div>

                        <div class="col-md-6 col-sm-6 animated fadeInRightBig animatedVisi" data-animtype="fadeInRightBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                            <div class="right-image-container">
                                <img src="<hst:link hippobean="${document.image.banner}"/>" alt="<fmt:message key="document.image.alt"/>" />
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-md-12 col-sm-12 animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                            <c:choose>
                                <c:when test="${not empty document.docLink}">
                                    <h2 class="h2-section-title"><a href="<hst:link hippobean="${document.docLink}"/>"><c:out value="${document.title}"/></a></h2>
                                </c:when>
                                <c:otherwise>
                                    <h2 class="h2-section-title"><c:out value="${document.title}"/></h2>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not empty bannerIcon}">
                                <div class="i-section-title">
                                    <i class="fa ${bannerIcon}">

                                    </i>
                                </div>
                            </c:if>

                            <h3 class="h3-section-info"><c:out value="${document.text}"/></h3>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <c:if test="${bannerBackground == 'white'}">
                <div class="row">
                    <div class="col-md-12 col-sm-12 no-bottom-margin animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.7s" style="-webkit-animation: 1s 0.7s;">
                        <div class="align-center">
                            <c:if test="${not empty document.image}">
                                <img src="<hst:link hippobean="${document.image.banner}"/>" alt="<fmt:message key="document.image.alt"/>" class="img-responsive"/>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</c:if>

<c:if test="${separatorBorderTop}">
    <c:set var="cssClass"> border-top</c:set>
</c:if>
<c:if test="${separatorBorderBottom}">
    <c:set var="cssClass">${cssClass} border-bottom</c:set>
</c:if>
<c:if test="${not empty separatorMargin or not empty cssClass}">
    <div class="space-sep<c:out value="${separatorMargin} ${cssClass}"/>"></div>
</c:if>

</c:when>
<c:otherwise>
  <div class="row">
    <div class="col-md-12 col-sm-12">
      <h2 class="h2-section-title">Click to configure banner</h2>
    </div>
  </div>
  <div class="banner-component section-content no-padding">
    <div class="container">
      <div class="row">
        <div class="col-md-12 col-sm-12 no-bottom-margin animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.7s" style="-webkit-animation: 1s 0.7s;">
          <div class="align-center">
            <p style="backround-color: grey; width: 100%; height: 100px;"></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</c:otherwise>
</c:choose>