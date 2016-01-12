<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <hst:setBundle basename="messages,typenames"/>

<footer>
    <div class="footer">

        <div class="container">
            <div class="footer-wrapper">
                <div class="row">


                    <!-- Footer Col. -->
                    <div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-content">
                            <div class="footer-content-logo">
                                <a href="http://www.onehippo.com" target="_blank">
                                      <img src="<hst:link path="/images/logo-hippo.png"/>" alt="<fmt:message key="standard.footer.onehippo"/>"/>
                                </a>
                            </div>
                            <div class="footer-content-text">
                                <p><fmt:message key="layout.webpage.disclaimer">
                                        <fmt:param><a href="http://www.onehippo.com/en/why-hippo-cms" target="_blank"></fmt:param>
                                        <fmt:param><a href="https://issues.onehippo.com/browse/GOGREEN" target="_blank"></fmt:param>
                                        <fmt:param></a></fmt:param>
                                    </fmt:message>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- //Footer Col.// -->


                    <!-- Footer Col. -->
                    <div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-title">
                            <fmt:message key="standard.footer.servicelabel"/>
                        </div>
                        <div class="footer-content footer-recent-tweets-container">
                            <hst:include ref="service"/>
                            <%--<ul class="tweetList footer-recent-tweets">
                                <li class="tweet_content item">
                                    <p>Grab a copy of the popular Boomerang theme for $10 until its next release! </p>
                                    <p class="timestamp">2 days ago</p>
                                </li>
                                <li class="tweet_content item">
                                    <p>Newest Blog Awesome post: Stacking Text and Icons <a href="http://t.co/1qRP8K1wjG">Check it</a></p>
                                    <p class="timestamp">4 days ago</p>
                                </li>
                            </ul>--%>
                        </div>
                    </div>
                    <!-- //Footer Col.// -->


                    <!-- Footer Col. -->
                    <div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-title">
                            <fmt:message key="standard.footer.sectionslabel"/>
                        </div>
                        <div class="footer-content">
                            <hst:include ref="sections"/>
                        </div>
                    </div>
                    <!-- //Footer Col.// -->


                    <!-- Footer Col. -->
                    <%--<div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-title">
                            Photostream
                        </div>
                        <div class="footer-content">
                            <div class="flickr_badge_wrapper">
                                <script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?count=9&amp;display=latest&amp;size=s&amp;layout=x&amp;source=all_tag&amp;tag=Sky,scrappers" id="flicker-images"></script>
                            </div>
                            <!-- //Footer Col.// -->

                        </div>
                    </div>--%>
                </div>
            </div>

        </div>
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 center-text">
                        <div class="copyright-text"><fmt:message key="standard.footer.copyright"/> | <hst:link var="termsLink" path="${requestScope.termsPath}" mount="site"/><a href="${termsLink}"><fmt:message key="standard.footer.termsandconditions"/></a></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</footer>