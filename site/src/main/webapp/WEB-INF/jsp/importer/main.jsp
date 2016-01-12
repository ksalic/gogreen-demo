<%--
  Copyright 2014-2015 Hippo B.V. (http://www.onehippo.com)
--%>

<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://www.hippoecm.org/jsp/hst/core" prefix='hst'%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<hst:headContribution keyHint="title"><title>ADD </title></hst:headContribution>

<div id="yui-u">
  <c:if test="${not empty requestScope.message}">
    <h2>${requestScope.message}</h2>
  </c:if>
  <h1>Add Wikipedia Documents</h1>
  <hr/>
  <br/>

  <form action="<hst:actionURL/>" method="get">
    <table>
      <tr>
        <td>Number: </td>
        <td><input type="text" name="number"/></td>
      </tr>
      <tr>
        <td>offset
        </td>
        <td><input type="text" name="offset"/></td>
      </tr>
      <tr>
        <td>Wiki location on filesystem:</td>
        <td><input type="text" name="filesystemLocation"/></td>
      </tr>
      <tr>
      <td>Type</td>
      <td>
        <input type="radio" name="type" value="news"/> News<br/>
        <input type="radio" name="type" value="products"/> Products
      </td>
    </tr>
      <tr>
        <td></td>
        <td><input type="submit" value="Add X wikipedia docs"/></td>
      </tr>
    </table>
  </form>
</div>