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
<%--@elvariable id="images" type="com.onehippo.gogreen.beans.ImageDocument"--%>

<!-- Images -->
<c:if test="${not empty images}">

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
        <c:when test="${background eq 'gradient'}">
            <div class="section-content section-px">
        </c:when>
        <c:when test="${background eq 'gray'}">
            <div class="section-content top-body">
        </c:when>
        <c:when test="${background eq 'blue'}">
            <div class="section-content section-color-dark-blue white-text">
        </c:when>
        <c:otherwise>
            <div class="section-content">
        </c:otherwise>
    </c:choose>

    <div class="container images-component">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <ul class="section-clients">
                    <c:forEach items="${images}" var="doc">
                        <li class="animated bounceIn animatedVisi" data-animtype="bounceIn" data-animrepeat="0" data-animdelay="0.2s" style="-webkit-animation: 0.2s;">
                            <c:set var="image" value="${doc.firstImage}"/>
                            <a href="<hst:link hippobean="${doc}"/>">
                                <img src="<hst:link hippobean="${image.largeThumbnail}"/>" alt="${image.alt}">
                            </a>
                            <hst:cmseditlink hippobean="${doc}" />
                        </li>
                    </c:forEach>
                </ul>
            </div>
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

<c:if test="${empty images and preview}">
    <h2 class="not-configured">Click to configure Image component</h2>
</c:if>