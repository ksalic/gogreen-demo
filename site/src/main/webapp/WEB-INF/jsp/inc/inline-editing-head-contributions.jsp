<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst' %>

<hst:link var="yuiLoaderSrc" path="/javascript/yui/yuiloader/yuiloader-min.js"/>
<hst:link var="inlineEditingSrc" path="/js/inline-editing/inline-editing.js"/>
<hst:element var="yuiLoader" name="script">
    <hst:attribute name="id" value="yuiloader" />
    <hst:attribute name="type" value="text/javascript" />
    <hst:attribute name="src" value="${yuiLoaderSrc}" />
</hst:element>
<hst:headContribution keyHint="yuiLoader" element="${yuiLoader}" category="jsInHead"/>
<hst:element var="inlineEditing" name="script">
    <hst:attribute name="id" value="inlineEditing" />
    <hst:attribute name="type" value="text/javascript" />
    <hst:attribute name="src" value="${inlineEditingSrc}" />
</hst:element>
<hst:headContribution keyHint="inlineEditing" element="${inlineEditing}" category="jsInHead"/>
