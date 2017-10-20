<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->

<@hst.setBundle basename="general.text"/>

<div class="map-comp">
  <div class="map-search form-wrapper">

    <div class="textfield">
      <input type="text" name="store_address" class="store-address" placeholder="<@fmt.message key="map.address.placeholder" />"/>
    </div>
    <div class="button">
      <i class="map-search-button btn btn-sm btn-default fa fa-search"></i>
    </div>
  </div>

<#if Request.zoomlevel??>
  <#assign zoom>&zoom=${Request.zoomlevel}</#assign>
</#if>

  <img class="map-image" src="https://maps.googleapis.com/maps/api/staticmap?center=${Request.address}${zoom}&size=237x300&maptype=terrain&markers=color:green%7Clabel:G%7C52.3593826,4.9016225&markers=color:green%7Clabel:G%7C42.350294,-71.057129" alt="Google Maps"/>
</div>
<@hst.link path="/images/terrain.png" var="staticMap"/>
<script type="text/javascript">

  var gmapsUrl = "https://maps.googleapis.com/maps/api/staticmap?center=[ADDRESS]${zoom}&size=237x300&maptype=terrain&markers=color:green%7Clabel:G%7C52.3593826,4.9016225&markers=color:green%7Clabel:G%7C42.350294,-71.057129";

  $(".map-image")
    .error(function () {
      $(this).attr("src", "${staticMap}");
    });

  $(".map-search-button").click(function () {
    var newAddress = $(this).parentsUntil(".map-comp").find(".store-address").val();
    var newUrl = gmapsUrl.replace("[ADDRESS]", newAddress);
    $(this).parentsUntil(".map-comp").parent().find(".map-image").attr("src", newUrl);
  });

</script>
