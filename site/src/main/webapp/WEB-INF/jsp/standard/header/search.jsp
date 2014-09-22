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

<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst'%>
<%@include file="../../includes/tags.jspf" %>

<div class="col-sm-5" id="top-search">

    <hst:link siteMapItemRefId="search" var="doSearch" />
    <c:set var="searchText"><fmt:message key="searchform.search" /></c:set>
    <div class="searchbox">
        <form action="${doSearch}" method="get" onsubmit="sanitizeRequestParam(document.forms['searchSubmit']['query'], '${searchText}')">
            <input type="text" class="searchbox-inputtext" id="searchbox-inputtext" name="query" placeholder="<fmt:message key="searchform.search" />"/>
            <label class="searchbox-icon" for="searchbox-inputtext"></label>
            <input type="submit" class="searchbox-submit" value="${searchText}"/>
        </form>
    </div>
    <div class="social-icons">
        <ul>
            <li>
                <a href="#" target="_blank" class="social-media-icon facebook-icon" data-original-title="facebook">facebook</a>
            </li>
            <li>
                <a href="#" target="_blank" class="social-media-icon twitter-icon" data-original-title="twitter">twitter</a>
            </li>
            <li>
                <a href="#" target="_blank" class="social-media-icon googleplus-icon" data-original-title="googleplus">googleplus</a>
            </li>
            <li>
                <a href="#" target="_blank" class="social-media-icon pininterest-icon" data-original-title="pininterest">pininterest</a>
            </li>
            <li>
                <a href="#" target="_blank" class="social-media-icon dribble-icon" data-original-title="dribble">dribble</a>
            </li>
        </ul>

    </div>
</div>
