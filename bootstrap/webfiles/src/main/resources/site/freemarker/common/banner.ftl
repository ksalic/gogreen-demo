<#include "../include/imports.ftl">
<#if  document??>

<#if  title??>
  <div class="row">
    <div class="col-md-12 col-sm-12">
      <h2 class="h2-section-title">
        ${title}
      </h2>
      <#if  icon??>
        <div class="i-section-title">
          <i class="fa  ${icon}"></i>
        </div>
      </#if>
    </div>
  </div>
</#if>

<#if bannerBackground??>
  <#if bannerBackground == 'blue'>
    <#assign cssClasses>section-color-dark-blue white-text</#assign>
  </#if>
  <#elseif bannerBackground == 'full'>
  <#assign imageSrc>
    <@hst.link hippobean=document.image.original/>
  </#assign>
  <div class="banner-component section-content full-banner no-padding" style="background-image: url('${imageSrc}')">
  <@hst.cmseditlink hippobean=document/>
  </div>
  <#else>
  <#assign  cssClasses>no-padding</#assign>
</#if>
  <#if bannerBackground??>

  <div class="banner-component section-content ${cssClasses}">
  <div class="container">
    <div class="row">
      <@hst.cmseditlink hippobean=document/>

      <c:choose>
        <c:when test="${bannerBackground == 'blue'}">
          <div class="col-md-6 col-sm-6 animated fadeInLeftBig animatedVisi" data-animtype="fadeInLeftBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <div class="space-sep100"></div>

              <#if  document.docLink??>
                <h2 class="h2-section-title"><a href="<@hst.link hippobean=document.docLink/>">
                  ${document.title}
                  </a></h2>
              <#else>
                <h2 class="h2-section-title">
                  {document.title}
                </h2>
              </#if>


            <h3 class="h3-section-info">
              ${document.text}
            </h3>
          </div>

          <div class="col-md-6 col-sm-6 animated fadeInRightBig animatedVisi" data-animtype="fadeInRightBig" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <div class="right-image-container">
              <img src="<@hst.link hippobean=document.image.banner/>" alt="" />
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <div class="col-md-12 col-sm-12 animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
            <c:choose>
              <c:when test="${not empty document.docLink}">
                <h2 class="h2-section-title"><a href="<@hst.link hippobean=document.docLink/>">
                  ${document.title}
                  </a></h2>
              </c:when>
              <c:otherwise>
                <h2 class="h2-section-title">
                  ${document.title}
                </h2>
              </c:otherwise>
            </c:choose>

            <c:if test="${not empty bannerIcon}">
              <div class="i-section-title">
                <i class="fa ${bannerIcon}">

                </i>
              </div>
            </c:if>

            <h3 class="h3-section-info">
              ${document.text}
            </h3>
          </div>
        </c:otherwise>
      </c:choose>

    </div>

    <c:if test="${bannerBackground == 'white'}">
      <div class="row">
        <div class="col-md-12 col-sm-12 no-bottom-margin animated fadeInUp animatedVisi" data-animtype="fadeInUp" data-animrepeat="0" data-animspeed="1s" data-animdelay="0.7s" style="-webkit-animation: 1s 0.7s;">
          <div class="align-center">
            <c:if test="${not empty document.image}">
              <img src="<@hst.link hippobean=document.image.banner/>" alt="
              <@fmt.message key="document.image.alt"/>" class="img-responsive"/>
            </c:if>
          </div>
        </div>
      </div>
    </c:if>

  </div>
</#if>

<c:if test="${separatorBorderTop}">
  <c:set var="cssClass"> border-top</c:set>
</c:if>
<c:if test="${separatorBorderBottom}">
  <c:set var="cssClass">${cssClass} border-bottom</c:set>
</c:if>
<c:if test="${not empty separatorMargin or not empty cssClass}">
  <div class="space-sep ${separatorMargin} ${cssClass}"/>"></div>
</c:if>
<#elseif preview??>
  <h2 class="not-configured">Click to configure banner</h2>
</#if>
