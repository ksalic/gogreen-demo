<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

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
<hst:headContribution keyHint="mapsInit" element="${requestScope.googleMapsInit}" category="jsInternal">
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