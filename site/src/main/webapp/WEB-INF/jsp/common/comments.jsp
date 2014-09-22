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

<c:if test="${not empty comments}">
    <div class="comments">
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
                <c:forEach items="${comments}" var="comment">
                    <li class="comment">
                        <div class="comment-content">
                            <%-- DISABLED FROM THEME: <div class="comment-author-avatar">
                                <img src="media/comment.jpg" alt="John Doe" class="img-responsive">
                            </div>--%>

                            <div class="comment-details">
                                <div class="comment-author-name">
                                    <span>
                                        <c:choose>
                                            <c:when test="${not empty comment.email}">
                                              <a href="mailto:${fn:escapeXml(comment.email)}"><c:out value="${comment.name}"/></a>
                                            </c:when>
                                            <c:otherwise>
                                              <c:out value="${comment.name}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="comment-date"><fmt:formatDate value="${comment.creationDate.time}" type="date" pattern="d MMMM, yyyy"/></span>
                                    <%-- DISABLED FROM THEME: <a class="comment-reply" href="">(reply)</a>--%>
                                </div>
                                <div class="comment-body">
                                    <c:out value="${comment.body}"/>
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
                <fmt:message key="common.comments.label"/>
            </h3>
            <div class="title-seperator"></div>
        </div>
    </div>
</div>

<hst:actionURL var="actionUrl"/>

<form action="${actionUrl}" class="form-wrapper" method="post" id="comment-form" role="form" novalidate="novalidate">

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <div class="msg"><fmt:message key="common.comments.thankyou"/></div>
            <a href="#" class="alert-remove"><i class="icon-trash"></i></a>
        </div>
    </c:if>

    <c:if test="${not empty errors}">
        <div class="alert alert-danger">
            <div class="msg">
                <c:forEach items="${errors}" var="error">
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
                <input type="text" id="name" name="name" value="${name}" class="form-control" data-errmsg="<fmt:message key="common.comments.name.error"/>" minlength="2" placeholder="Your Name" required="">
                <c:if test="${not empty errors}">
                    <c:forEach items="${errors}" var="error">
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
                <input type="text" id="email" name="email" value="${email}" class="form-control" data-errmsg="<fmt:message key="common.comments.email.error"/>" minlength="2" placeholder="Your Email" required="">
                <c:if test="${not empty errors}">
                    <c:forEach items="${errors}" var="error">
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
            <div class="col-xs-7">
                <label for="message&quot;">
                    <fmt:message key="common.comments.comment"/>
                </label>
                <textarea id="comment" name="comment" class="form-control" data-errmsg="<fmt:message key="common.comments.comment.error"/>"
                    placeholder="Your Message" rows="3" required=""><c:if test="${not empty comment}"><c:out value="${comment}"/></c:if></textarea>
                <c:if test="${not empty errors}">
                    <c:forEach items="${errors}" var="error">
                        <c:if test="${error eq 'invalid.comment-label'}">
                            <span for="comment" class="input_error"><fmt:message key="common.comments.comment.error"/></span><br/>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <c:if test="${not empty errors}">
        <c:forEach items="${errors}" var="error">
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