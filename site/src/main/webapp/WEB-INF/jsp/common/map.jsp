<%--
  Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)

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
<hst:setBundle basename="general.text"/>

<div class="map-comp">
  <div class="map-search form-wrapper">

    <div class="textfield">
      <input type="text" name="store_address" class="store-address" placeholder="<fmt:message key="map.address.placeholder" />"/>
    </div>
    <div class="button">
      <i class="map-search-button btn btn-sm btn-default fa fa-search"></i>
    </div>
  </div>

  <c:if test="${not empty zoomlevel}">
    <c:set var="zoom" value="&zoom=${zoomlevel}"/>
  </c:if>

  <img class="map-image" src="https://maps.googleapis.com/maps/api/staticmap?center=${address}${zoom}&size=237x300&maptype=roadmap
  &markers=color:green%7Clabel:G%7C52.3593826,4.9016225&markers=color:green%7Clabel:G%7C42.350294,-71.057129" alt="Google Maps"/>
</div>


<hst:link path="/images/staticmap.png" var="staticMap"/>
<script type="text/javascript">

  var gmapsUrl = "https://maps.googleapis.com/maps/api/staticmap?center=[ADDRESS]${zoom}&size=237x300&maptype=roadmap&markers=color:green%7Clabel:G%7C52.3593826,4.9016225&markers=color:green%7Clabel:G%7C42.350294,-71.057129";

  <%-- Show static map when there is no internet connection --%>
  $(".map-image")
    .error(function() {
      $(this).attr("src", "${staticMap}");
    });

  <%-- Change address --%>
  $(".map-search-button").click(function() {
    var newAddress = $(this).parentsUntil(".map-comp").find(".store-address").val();
    var newUrl = gmapsUrl.replace("[ADDRESS]", newAddress);
    $(this).parentsUntil(".map-comp").parent().find(".map-image").attr("src", newUrl);
  });

</script>
