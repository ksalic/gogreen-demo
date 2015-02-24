<%--
  Copyright 2011-2014 Hippo B.V. (http://www.onehippo.com)

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
  <div class="rev-slider-full">
    <div class="rev-slider-banner-full rev-slider-full">
      <ul>
        <c:forEach items="${banners}" var="banner" varStatus="index">
          <%--@elvariable id="banner" type="com.onehippo.gogreen.beans.Banner"--%>
          <li data-transition="fade" data-slotamount="2" data-masterspeed="300" >
            <img src="<hst:link hippobean="${banner.image.original}"/>"  alt="rev-full1" data-fullwidthcentering="on">
            <hst:cmseditlink hippobean="${banner}" />

            <div class="tp-caption big_white large_text sft" data-x="38" data-y="72" data-start="0" data-easing="easeOutBack" >
              <c:out value="${banner.title}"/>
            </div>
            <div class="tp-caption revolution-subtext sfb" data-x="38" data-y="136" data-start="0" data-easing="easeOutBack" >
              <c:out value="${banner.text}"/>
            </div>
            <div>
              <a href="<hst:link hippobean="${banner.docLink}"/>" class="link-overlay"></a>
            </div>
          </li>
        </c:forEach>

      </ul>
      <div class="tp-bannertimer tp-bottom"></div>
    </div>
  </div>
</c:if>
<c:if test="${empty banners and preview}">
  <h2 class="not-configured">Click to configure banner carousel</h2>
</c:if>