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

<c:if test="${not empty banners}">

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
  <c:when test="${bannerBackground eq 'gradient' and bannerType ne 'horizontal1'}">
    <div class="section-content section-px white-text">
  </c:when>
  <c:when test="${bannerBackground eq 'gradient' and bannerType eq 'horizontal1'}">
    <div class="section-content section-px">
  </c:when>
  <c:when test="${bannerBackground eq 'gray'}">
    <div class="section-content no-padding top-body">
  </c:when>
  <c:when test="${bannerBackground eq 'blue'}">
    <div class="section-content section-color-dark-blue white-text">
  </c:when>
  <c:when test="${bannerType eq 'images'}">
    <div class="section-content no-padding">
  </c:when>
  <c:otherwise>
    <div class="section-content no-padding">
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${fn:length(banners) eq 1}">
    <c:set var="colSize" value="12"/>
  </c:when>
  <c:when test="${fn:length(banners) eq 2}">
    <c:set var="colSize" value="6"/>
  </c:when>
  <c:when test="${fn:length(banners) eq 3}">
    <c:set var="colSize" value="4"/>
  </c:when>
  <c:when test="${fn:length(banners) eq 4}">
    <c:set var="colSize" value="3"/>
  </c:when>
</c:choose>

<c:choose>
  <c:when test="${fn:length(banners) mod 2 eq 0}">
    <c:set var="bannerCount" value="${fn:length(banners) / 2.0}"/>
  </c:when>
  <c:otherwise>
    <c:set var="bannerCount" value="${(fn:length(banners) - 1.0 )/ 2.0}"/>
  </c:otherwise>
</c:choose>

<div class="container">
<div class="row">
<c:forEach items="${banners}" var="banner" varStatus="index">
<%--@elvariable id="banner" type="com.onehippo.gogreen.beans.Banner"--%>
<hst:setBundle basename="products.facet"/>
<c:set var="docLink" value=""/>
<c:if test="${not empty banner.docLink}">
  <c:choose>
    <c:when test="${banner.docLink.hippoFolderBean}">
      <fmt:message var="path" key="path"/>
      <fmt:message var="category" key="category"/>
      <hst:link var="docLink" path="${path}/${category}/${banner.docLink.localizedName}"/>
    </c:when>
    <c:otherwise>
      <hst:link var="docLink" hippobean="${banner.docLink}"/>
    </c:otherwise>
  </c:choose>
</c:if>
<fmt:setBundle basename="messages" />
<c:choose>
  <c:when test="${bannerType eq 'vertical'}">
    <c:if test="${index.first}">
      <div class="col-md-6 col-sm-6 right-text">
      <ul class="icon-content-list-container">
    </c:if>
    <c:if test="${bannerCount ne 0 and index.index eq bannerCount}">
      </ul>
      </div>
      <div class="col-md-6 col-sm-6">
      <ul class="icon-content-list-container">
    </c:if>

    <li class="icon-content-single">
      <div class="content-box style5 animated fadeIn animatedVisi" data-animtype="fadeIn" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.2s" style="-webkit-animation: 1s 0.2s;">
        <h4 class="h4-body-title">
          <c:if test="${not empty docLink}">
          <a href="${docLink}">
            </c:if>
            <c:out value="${banner.title}"/>
            <c:choose>
              <c:when test="${not empty banner.icon}">
                <i class="${banner.icon}"></i>
              </c:when>
              <c:otherwise>
                <img src="<hst:link hippobean="${banner.image.thumbnail}"/>" class="icon-replacement">
              </c:otherwise>
            </c:choose>
            <c:if test="${not empty docLink}">
          </a>
          </c:if>
        </h4>
        <div class="content-box-text">
          <p>
            <c:out value="${banner.text}"/>
            <hst:cmseditlink hippobean="${banner}"/>
          </p>
        </div>
      </div>
    </li>

    <c:if test="${index.last}">
      </ul>
      </div>
    </c:if>
  </c:when>

  <c:when test="${bannerType eq 'horizontal1'}">
    <div class="col-md-${colSize} col-sm-${colSize}">
      <div class="content-box content-style3">
        <c:choose>
          <c:when test="${not empty banner.icon}">
            <div class="content-style3-icon ${banner.icon}"></div>
          </c:when>
          <c:otherwise>
            <div class="content-style3-icon">
              <img src="<hst:link hippobean="${banner.image.thumbnail}"/>" class="icon-replacement">
            </div>
          </c:otherwise>
        </c:choose>

        <div class="content-style3-title">
          <h4 class="h4-body-title"><c:out value="${banner.title}"/></h4>
        </div>
        <div class="content-style3-text">
          <c:out value="${banner.text}"/>
          <hst:cmseditlink hippobean="${banner}"/>
          <c:if test="${not empty docLink}">
            <div class="banner-button">
              <a href="${docLink}" class=" btn btn-sm">
                <span><fmt:message key="common.read.more"/></span>
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </c:when>

  <c:when test="${bannerType eq 'horizontal2'}">
    <div class="col-md-${colSize} col-sm-${colSize}">
      <div class="content-box content-style4 medium animated fadeIn animatedVisi" data-animtype="fadeIn" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.2s" style="-webkit-animation: 1s 0.2s;">
        <h4 class="h4-body-title">
          <c:choose>
            <c:when test="${not empty banner.icon}">
              <i class="${banner.icon}"></i>
            </c:when>
            <c:otherwise>
              <img src="<hst:link hippobean="${banner.image.thumbnail}"/>" class="icon-replacement">
            </c:otherwise>
          </c:choose>
          <c:out value="${banner.title}"/>
        </h4>
        <div class="content-box-text">
          <c:out value="${banner.text}"/>
          <hst:cmseditlink hippobean="${banner}"/>
          <c:if test="${not empty docLink}">
            <div>
              <a href="${docLink}" class=" btn btn-sm">
                <span><fmt:message key="common.read.more"/></span>
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </c:when>

  <c:when test="${bannerType eq 'horizontal3'}">
    <div class="col-md-${colSize} col-sm-${colSize}">
      <div class="content-box style5 small  animated fadeIn animatedVisi" data-animtype="fadeIn" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.2s" style="-webkit-animation: 1s 0.2s;">
        <h4 class="h4-body-title">
          <c:choose>
            <c:when test="${not empty banner.icon}">
              <i class="${banner.icon}"></i>
            </c:when>
            <c:otherwise>
              <img src="<hst:link hippobean="${banner.image.thumbnail}"/>" class="icon-replacement">
            </c:otherwise>
          </c:choose>
            <c:out value="${banner.title}"/>
        </h4>
        <div class="content-box-text">
            <c:out value="${banner.text}"/>
          <hst:cmseditlink hippobean="${banner}"/>
          <c:if test="${not empty docLink}">
            <a href="${docLink}" class="read-more">
              <span><fmt:message key="common.read.more"/></span>
            </a>
          </c:if>
        </div>
      </div>
    </div>
  </c:when>

  <c:when test="${bannerType eq 'images'}">
    <div class="col-md-${colSize} col-sm-${colSize}">
      <div class="feature product-category">
        <div class="feature-content">
          <c:choose>
            <c:when test="${not empty docLink}">
              <h3 class="h3-body-title"><a href="${docLink}">
                <c:out value="${banner.title}"/></a>
              </h3>
            </c:when>
            <c:otherwise>
              <h3 class="h3-body-title">
                <c:out value="${banner.title}"/>
              </h3>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="feature-image">
          <hst:cmseditlink hippobean="${banner}"/>
          <c:if test="${not empty banner.image}">
            <c:choose>
              <c:when test="${not empty docLink}">
                <a href="${docLink}">
                  <img src="<hst:link hippobean="${banner.image.largeThumbnail}"/>" alt="${banner.image.alt}"/>
                </a>
              </c:when>
              <c:otherwise>
                <img src="<hst:link hippobean="${banner.image.largeThumbnail}"/>" alt="${banner.image.alt}"/>
              </c:otherwise>
            </c:choose>
          </c:if>

        </div>
      </div>
    </div>
  </c:when>

  <c:otherwise>
    <div class="col-md-${colSize} col-sm-${colSize}">
      <div class="content-box content-style2 anim-opacity animated fadeIn animatedVisi" data-animtype="fadeIn" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.2s" style="-webkit-animation: 1s 0.2s;">
        <h4 class="h4-body-title">
          <c:choose>
            <c:when test="${not empty banner.icon}">
              <i class="fa ${banner.icon}"></i>
            </c:when>
            <c:otherwise>
              <img src="<hst:link hippobean="${banner.image.thumbnail}"/>" class="icon-replacement">
            </c:otherwise>
          </c:choose>
          <c:out value="${banner.title}"/>
        </h4>
        <div class="content-box-text">
          <c:out value="${banner.text}"/>
          <hst:cmseditlink hippobean="${banner}"/>
          <c:if test="${not empty docLink}">
            <div>
              <a href="${docLink}" class="read-more">
                <span><fmt:message key="common.read.more"/></span>
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </c:otherwise>
</c:choose>
</c:forEach>
</div>
</div>
</div>

<c:if test="${separatorBorderTop}">
  <c:set var="cssClass"> border-top</c:set>
</c:if>
<c:if test="${separatorBorderBottom}">
  <c:set var="cssClass">${cssClass} border-bottom</c:set>
</c:if>
<c:if test="${not empty separatorMargin or not empty cssClass}">
  <div class="space-sep<c:out value="${separatorMargin} ${cssClass}"/>"></div>
</c:if>


</c:if>
<c:if test="${empty banners and preview}">
  <h2 class="not-configured">Click to configure banner collection</h2>
</c:if>