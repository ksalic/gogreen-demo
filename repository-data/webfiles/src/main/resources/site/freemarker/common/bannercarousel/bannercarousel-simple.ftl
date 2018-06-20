<#include "../../include/imports.ftl">
<#--
  Copyright 2016-2018 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.banners?? && (Request.banners?size > 0)>
<div class="rev-slider-full">
  <div class="revolution-carousel-${bannerIndex} rev-slider-banner-full rev-slider-full">
    <ul>
      <#list Request.banners as banner >

        <li data-transition="fade" data-slotamount="2" data-masterspeed="300">
          <img src="<@hst.link hippobean=banner.image.original/>" alt="rev-full1" data-fullwidthcentering="on">
          <@hst.manageContent hippobean=banner templateQuery="new-banner" defaultPath="common/banners" />
          <div>
            <a href="<@hst.link hippobean=banner.docLink/>" class="link-overlay"></a>
          </div>
        </li>
      </#list>

    </ul>
    <div class="tp-bannertimer tp-bottom"></div>
  </div>
</div>
<#elseif editMode>
    <div class="not-configured">
        <h2>Click to configure banner carousel</h2>
        <@hst.manageContent templateQuery="new-banner" defaultPath="common/banners" parameterName="banner1"/>
    </div>
</#if>

<script>
    // show slider again if component is reloaded in channel manager
    $(document).ready(function () {
        // only call slider initialization if it is not yet initialised
        var $slider = $('.revolution-carousel-${bannerIndex}').not('.revslider-initialised');
        if ($slider.length > 0) {
            initializeSlider($slider);
        }
    })
</script>
