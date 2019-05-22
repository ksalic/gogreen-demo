<%--

    Copyright 2010-2019 Hippo B.V. (http://www.onehippo.com)

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
                    <div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-content">
                            <div class="footer-content-logo">
                                <a href="https://documentation.bloomreach.com" target="_blank">
                                      <img src="<hst:link path="/images/logo-hippo.png"/>" alt="<fmt:message key="standard.footer.onehippo" var="standardFooter"/><c:out value="${standardFooter}"/> "/>
                                </a>
                            </div>
                            <div class="footer-content-text">
                                <p><fmt:message key="layout.webpage.disclaimer" var="disclaimer"><c:out value="${disclaimer}"/>
                                        <fmt:param><a href="https://www.bloomreach.com/en/products/experience/hippo-cms" target="_blank"></fmt:param>
                                        <fmt:param><a href="https://groups.google.com/forum/#!forum/hippo-community" target="_blank"></fmt:param>
                                        <fmt:param></a></fmt:param>
                                    </fmt:message>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-title">
                            <fmt:message key="standard.footer.servicelabel" var="serviceLabel"/><c:out value="${serviceLabel}"/>
                        </div>
                        <div class="footer-content footer-recent-tweets-container">
                            <hst:include ref="service"/>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-3 footer-col">
                        <div class="footer-title">
                            <fmt:message key="standard.footer.sectionslabel" var="sectionsLabel"/><c:out value="${sectionsLabel}"/>
                        </div>
                        <div class="footer-content">
                            <hst:include ref="sections"/>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 center-text">
                        <div class="copyright-text"><fmt:message key="standard.footer.copyright" var="copyright"/><c:out value="${copyright}"/> | <hst:link var="termsLink" path="${requestScope.termsPath}" mount="site"/><a href="${termsLink}"><fmt:message key="standard.footer.termsandconditions" var="termsAndConditions"/><c:out value="${termsAndConditions}"/></a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>