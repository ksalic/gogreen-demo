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
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.RichTextSnippet"--%>

<!-- RichTextSnippet -->
<c:choose>
  <c:when test="${not empty document}">

    <div class="richtextsnippet-component">
      <div class="container">
        <div class="row">
          <div class="col-md-12 col-sm-12">
            <hst:cmseditlink hippobean="${document}" />
            <hst:html hippohtml="${document.richText}"/>
          </div>
        </div>
      </div>
    </div>

  </c:when>
  <c:otherwise>
    <c:if test="${preview}">
      <h2 class="not-configured">Click to configure Rich text snippet</h2>
    </c:if>
  </c:otherwise>
</c:choose>