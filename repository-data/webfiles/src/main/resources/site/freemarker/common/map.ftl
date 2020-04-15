<#include "../include/imports.ftl">
<#--
  Copyright 2016-2020 Hippo B.V. (http://www.onehippo.com)
-->

<@hst.setBundle basename="general.text"/>

<div class="map-comp">
  <div class="map-search form-wrapper">

    <div class="textfield">
        <@fmt.message key="map.address.placeholder" var="addressPlaceholder"/>
      <input type="text" name="store_address" class="store-address" placeholder="${addressPlaceholder?html}"/>
    </div>
    <div class="button">
      <i class="map-search-button btn btn-sm btn-default fa fa-search"></i>
    </div>
  </div>

<#assign zoom></#assign>
<#if Request.zoomlevel??>
  <#assign zoom>&zoom=${Request.zoomlevel}</#assign>
</#if>
<#assign gApiKey>no-key</#assign>
<#if Request.googleApiKey??>
  <#assign gApiKey>${Request.googleApiKey}</#assign>
</#if>
  <img class="map-image" src="https://maps.googleapis.com/maps/api/staticmap?key=${gApiKey?html}&center=${Request.address?html}${zoom?html}&size=237x300&maptype=roadmap&markers=color:green%7Clabel:G%7C52.3593826,4.9016225&markers=color:green%7Clabel:G%7C42.350294,-71.057129" alt="Google Maps"/>
</div>
<@hst.link path="/images/staticmap.png" var="staticMap"/>
<script type="text/javascript">

  var gmapsUrl = "https://maps.googleapis.com/maps/api/staticmap?key=${gApiKey?html}&center=[ADDRESS]${zoom?html}&size=237x300&maptype=roadmap&markers=color:green%7Clabel:G%7C52.3593826,4.9016225&markers=color:green%7Clabel:G%7C42.350294,-71.057129";

  $(".map-image")
    .error(function () {
      console.log("Showing static PNG because of error retrieving Google map from " + gmapsUrl);
      $(this).attr("src", "${staticMap}");
    });

  $(".map-search-button").click(function () {
    var newAddress = $(this).parentsUntil(".map-comp").find(".store-address").val();
    var newUrl = gmapsUrl.replace("[ADDRESS]", newAddress);
    $(this).parentsUntil(".map-comp").parent().find(".map-image").attr("src", newUrl);
  });

</script>
