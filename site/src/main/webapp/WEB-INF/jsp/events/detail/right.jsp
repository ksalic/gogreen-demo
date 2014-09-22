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

<%@include file="../../includes/tags.jspf" %>

<c:set var="lang" value="${pageContext.request.locale.language}"/>
<hst:element var="googleMapsApiSensor" name="script">
	<hst:attribute name="type">text/javascript</hst:attribute>
	<hst:attribute name="src">http://maps.google.com/maps/api/js?sensor=true&language=${lang}</hst:attribute>
</hst:element>
<hst:element var="googleMaps" name="script">
	<hst:attribute name="type">text/javascript</hst:attribute>
	<hst:attribute name="src">
		<hst:link path="/js/google_maps.js" />
	</hst:attribute>
</hst:element>

<hst:headContribution keyHint="api" element="${googleMapsApiSensor}" category="jsInternal"/>
<hst:headContribution keyHint="maps" element="${googleMaps}" category="jsInternal"/>
<hst:headContribution keyHint="mapsInit" element="${googleMapsInit}" category="jsInternal">
     <script type="text/javascript">
       initialize();
       codeAddress();
     </script>
</hst:headContribution>

<div class="sidebar-block">
  <div id="map_canvas" class="sidebar-content map"></div>
</div>

<hst:include ref="relatedblogs"/>
<hst:include ref="relatedevents"/>
<hst:include ref="relatedproducts"/>

<hst:include ref="boxes-right"/>