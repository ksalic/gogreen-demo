<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<div class="container title-header">
    <c:if test="${not empty requestScope.title}">
        <div class="row">
            <div class="col-md-12 col-sm-12 animated" data-animtype="fadeInUp" data-animrepeat="0" data-speed="1s" data-delay="0.4s">
                <h2 class="h2-section-title"><c:out value="${requestScope.title}"/></h2>
                <c:if test="${not empty requestScope.icon}">
                    <div class="i-section-title">
                        <i class="fa <c:out value="${requestScope.icon}"/>"></i>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>
</div>