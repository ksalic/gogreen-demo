<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.Product"--%>
<%@include file="../../includes/tags.jspf" %>

<c:set var="datePattern" value="dd-MM-yyyy"/>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<hst:headContribution keyHint="rateJs" category="headScripts">
    <hst:link path="/js/jquery.raty.js" var="rateJs"/>
    <script type="text/javascript" src="${rateJs}"></script>
</hst:headContribution>

<hst:headContribution keyHint="rateCss" category="css">
    <hst:link path="/css/jquery.raty.css" var="rateCss"/>
    <link rel="stylesheet" href="${rateCss}"/>
</hst:headContribution>

<div class="blog-post">

    <div class="blog-post-type">
        <i class="icon-shop"> </i>
    </div>

    <div class="blog-span">
        <hst:cmseditlink hippobean="${requestScope.document}" />
        <h2>
            <c:out value="${requestScope.document.title}"/>
        </h2>

        <c:if test="${not empty requestScope.document.images}">
            <div class="blog-post-featured-img img-overlay">
                <div class="cycle-slideshow frame1" data-cycle-slides="> .slider-img" data-cycle-swipe="true" data-cycle-prev=".cycle-prev" data-cycle-next=".cycle-next" data-cycle-overlay-fx-out="slideUp" data-cycle-overlay-fx-in="slideDown" data-cycle-timeout="0">
                    <c:if test="${fn:length(requestScope.document.images) > 1}">
                      <div class="fa fa-chevron-right cycle-next"></div>
                      <div class="fa fa-chevron-left cycle-prev"></div>
                      <div class="cycle-pager"></div>
                    </c:if>
                    <c:forEach items="${requestScope.document.images}" var="productImage">
                        <div class="slider-img">
                            <img src="<hst:link hippobean="${productImage.largeThumbnail}"/>" alt="${fn:escapeXml(productImage.alt)}">
                            <div class="item-img-overlay">
                                <a class="portfolio-zoom icon-zoom" href="<hst:link hippobean="${productImage.original}"/>" data-rel="prettyPhoto[portfolio]" title="${document.title}"></a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <hippo-gogreen:imagecopyright image="${requestScope.image}"/>
            </div>
        </c:if>

        <div class="blog-post-body">
            <p><c:out value="${requestScope.document.summary}"/></p>
            <hst:html hippohtml="${requestScope.document.description}"/>
            <hippo-gogreen:copyright document="${requestScope.document}"/>
        </div>

        <div class="blog-post-details">

            <div class="blog-post-details-item blog-post-details-item-left icon-banknote">
                <span class="${requestScope.reseller ? 'nonresellerprice' : 'price'}"><fmt:formatNumber value="${requestScope.document.price}" type="currency"/></span>
                <c:if test="${requestScope.reseller}">
                    <span class="resellerprice"><fmt:message key="products.resellerprice"/>: <fmt:formatNumber value="${requestScope.document.resellerPrice}" type="currency"/></span>
                </c:if>
            </div>

            <div class="blog-post-details-item blog-post-details-item-left rating-info">
                <span id="document-rating" data-score="<c:out value="${requestScope.document.rating}"/>"></span>&nbsp;(<c:out value="${requestScope.votes}"/>&nbsp;<fmt:message key="products.detail.reviews"/>)
            </div>

            <%--<div class="blog-post-details-item blog-post-details-item-left blog-post-details-tags icon-files">
                <a href="">
                    Business
                </a> ,
                <a href="">
                    Investment
                </a> ,
                <a href="">
                    Freelancing
                </a>
            </div>--%>

    </div>
        <!-- Display Tags -->
        <c:if test="${!empty requestScope.document.categories}">
            <hst:setBundle basename="messages"/>
            <div class="tags">
                <c:forEach items="${requestScope.document.categories}" var ="tag">

                    <hst:link siteMapItemRefId="search-faceted" var="link"/>
                    <fmt:message key="search.facet.category" var="tagname"/>
                    <a href="${link}/${tagname}/${tag}">${tag}</a>
                </c:forEach>

            </div>
        </c:if>

    </div>

 </div>


<c:if test="${not empty requestScope.reviews}">
    <div class="comments" id="comments">
        <div class="blog-span-bottom">

            <div class="title-block clearfix">
                <%-- TODO: get nr of comments from document <c:choose>
                    <c:when test="${commentsCountList[status.index] > 0}">
                        <h3 class="h3-body-title">${commentsCountList[status.index]} Repsonses To ${document.title}</h3>
                    </c:when>
                    <c:otherwise>
                        <h3 class="h3-body-title"><fmt:message key="news.overview.content.nocomments"/> for ${document.title}</h3>
                    </c:otherwise>
                </c:choose>--%>

                <h3 class="h3-body-title">Comments</h3>

                <div class="title-seperator"></div>
            </div>

            <ol class="comments-list">
                <c:forEach items="${requestScope.reviews}" var="review">
                    <li class="comment">
                        <div class="comment-content">
                            <%-- DISABLED FROM THEME: <div class="comment-author-avatar">
                                <img src="media/comment.jpg" alt="John Doe" class="img-responsive">
                            </div>--%>

                            <div class="comment-details">
                                <div class="comment-author-name">
                                    <span>
                                        <c:choose>
                                            <c:when test="${not empty review.email}">
                                              <a href="mailto:${fn:escapeXml(review.email)}"><c:out value="${review.name}"/></a>
                                            </c:when>
                                            <c:otherwise>
                                              <c:out value="${review.name}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="comment-date">
                                        <hst:setBundle basename="messages"/>
                                        <fmt:message key="standard.date.format" var="dateformat"/>
                                        <fmt:formatDate value="${review.creationDate.time}" type="date" pattern="${dateformat}"/>
                                    </span>
                                    <span class="comment-rating">
                                        <div data-score="${review.rating}">
                                        </div>
                                    </span>
                                    <%-- DISABLED FROM THEME: <a class="comment-reply" href="">(reply)</a>--%>
                                </div>
                                <div class="comment-body">
                                    <c:out value="${review.comment}"/>
                                </div>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ol>
        </div>
    </div>
</c:if>


<div class="row">
    <div class="blog-span-bottom">
        <div class="title-block clearfix">
            <h3 class="h3-body-title">
                <fmt:message key="products.detail.review"/>
            </h3>
            <div class="title-seperator"></div>
        </div>
    </div>
</div>

<hst:actionURL var="actionUrl"/>

<form action="${actionUrl}" class="form-wrapper" method="post" id="comment-form" role="form" novalidate="novalidate">

    <c:if test="${not empty requestScope.success}">
        <div class="alert alert-success">
            <div class="msg"><fmt:message key="common.comments.thankyou"/></div>
            <a href="#" class="alert-remove"><i class="icon-trash"></i></a>
        </div>
    </c:if>

    <c:if test="${not empty requestScope.errors}">
        <div class="alert alert-danger">
            <div class="msg">
                <c:forEach items="${requestScope.errors}" var="error">
                    <c:if test="${error eq 'invalid.name-label'}">
                        <span for="name" class="input_error"><fmt:message key="common.comments.name.error"/></span><br/>
                    </c:if>
                    <c:if test="${error eq 'invalid.email-label'}">
                        <span for="email" class="input_error"><fmt:message key="common.comments.email.error"/></span><br/>
                    </c:if>
                    <c:if test="${error eq 'invalid.comment-label'}">
                        <span for="comment" class="input_error"><fmt:message key="common.comments.comment.error"/></span><br/>
                    </c:if>
                </c:forEach>
            </div>
            <a href="#" class="alert-remove"><i class="icon-trash"></i></a>
        </div>
    </c:if>

    <div class="form-group">
        <div class="row">
            <div class="col-xs-6">
                <label for="name">
                    <fmt:message key="common.comments.name"/> *
                </label>
                <input type="text" id="name" name="name" value="${requestScope.name}" class="form-control" data-errmsg="<fmt:message key="common.comments.name.error"/>" minlength="2" placeholder="Your Name" required="">
                <c:if test="${not empty requestScope.errors}">
                    <c:forEach items="${requestScope.errors}" var="error">
                        <c:if test="${error eq 'invalid.name-label'}">
                            <span for="name" class="input_error"><fmt:message key="common.comments.name.error"/></span><br/>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="row">
            <div class="col-xs-6">
                <label for="email">
                    <fmt:message key="common.comments.email"/> *
                </label>
                <input type="text" id="email" name="email" value="${requestScope.email}" class="form-control" data-errmsg="<fmt:message key="common.comments.email.error"/>" minlength="2" placeholder="Your Email" required="">
                <c:if test="${not empty requestScope.errors}">
                    <c:forEach items="${requestScope.errors}" var="error">
                        <c:if test="${error eq 'invalid.email-label'}">
                            <span for="email" class="input_error"><fmt:message key="common.comments.email.error"/></span><br/>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="row">
            <div class="col-xs-6">
                <label for="email">
                    <fmt:message key="products.detail.score"/>
                </label>
                <input type="hidden" id="rating" name="rating" value="0" class="form-control">
                <div id="rating-field">
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="row">
            <div class="col-xs-7">
                <label for="message&quot;">
                    <fmt:message key="common.comments.comment"/>
                </label>
                <textarea id="comment" name="comment" class="form-control" data-errmsg="<fmt:message key="common.comments.comment.error"/>"
                    placeholder="Your Message" rows="3" required=""><c:if test="${not empty requestScope.comment}"><c:out value="${requestScope.comment}"/></c:if></textarea>
                <c:if test="${not empty requestScope.errors}">
                    <c:forEach items="${requestScope.errors}" var="error">
                        <c:if test="${error eq 'invalid.comment-label'}">
                            <span for="comment" class="input_error"><fmt:message key="common.comments.comment.error"/></span><br/>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <c:if test="${not empty requestScope.errors}">
        <c:forEach items="${requestScope.errors}" var="error">
            <c:if test="${error eq 'invalid.spam-label'}">
                <span class="form-error"><fmt:message key="common.spam.error"/></span><br/>
            </c:if>
        </c:forEach>
    </c:if>

    <div id="confirmation">
        <div class="form-group">
            <div class="row">
                <div class="col-xs-6">
                    <label for="name">
                        <fmt:message key="common.spamfield.label"/>
                    </label>
                    <input type="text" name="confirmation"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <div class="col-xs-6">
                    <label for="name">
                        <fmt:message key="common.spamfield.label"/>
                    </label>
                    <textarea name="feedback" rows="8" cols="50"></textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2 col-sm-2 offset2">
            <input type="submit" value="<fmt:message key="common.comments.submit.label"/>" class="button large">
        </div>
    </div>

</form>

<script type="text/javascript">
    $('#comments .comment-rating > div, #document-rating').raty({
        score: function() {
            return $(this).attr('data-score');
        },
        readOnly: true,
        half: true,
        starType :  'i'
    });
    $('#rating-field').raty({targetText: 0, target: '#rating', targetType : 'score', targetKeep: true, starType : 'i'});
</script>

<ga:trackDocument hippoDocumentBean="${requestScope.document}"/>