<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hst:defineObjects/>
<div class="hst-container">
    <c:forEach items="${hstResponseChildContentNames}" var="childContentName">
        <div class="hst-container-item">
            <hst:include ref="${childContentName}"/>
        </div>
    </c:forEach>
</div>