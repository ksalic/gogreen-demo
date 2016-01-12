<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#if Request.banners??>
<div class="rev-slider-full">
  <div class="rev-slider-banner-full rev-slider-full">
    <ul>
      <#list Request.banners as banner >

        <li data-transition="fade" data-slotamount="2" data-masterspeed="300">
          <img src="<@hst.link hippobean=banner.image.original/>" alt="rev-full1" data-fullwidthcentering="on">
          <@hst.cmseditlink hippobean=banner/>
          <div>
            <a href="<@hst.link hippobean=banner.docLink/>" class="link-overlay"></a>
          </div>
        </li>
      </#list>

    </ul>
    <div class="tp-bannertimer tp-bottom"></div>
  </div>
</div>
</#if>
<#if Request.banners?? && Request.preview??>
<h2 class="not-configured">Click to configure banner carousel</h2>
</#if>

<#if Request.preview??>
<script>
  // show slider again if component is reloaded in channel manager
  $(document).ready(function () {
    window.setTimeout(function () {
      // only call slider initialization if it is not yet initialised
      var $slider = $('.rev-slider-banner-full').not('.revslider-initialised');
      if ($slider.length > 0) {
        initializeSlider($slider);
      }
    }, 100)

  })
</script>
</#if>