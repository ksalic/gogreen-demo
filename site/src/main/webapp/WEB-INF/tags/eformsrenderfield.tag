<%--
  Copyright 2014 Hippo B.V. (http://www.onehippo.com)
--%>
<%@ tag description="render form field item" pageEncoding="UTF-8" %>
<%@ attribute name="field" type="com.onehippo.cms7.eforms.hst.model.AbstractField" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="hst" uri="http://www.hippoecm.org/jsp/hst/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<c:choose>
    <c:when test="${field.type eq 'simpletextfield'}">
        <div class="eforms-text" name="${field.formRelativeUniqueName}">
            <p class="${field.styleClass}"><c:out value='${field.label}'/></p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="eforms-field form-group">
            <div class="row">
    </c:otherwise>
</c:choose>

<c:if test="${not empty field.hint}">
    <c:set var="hint">
        <i class="fa fa-question-circle field-hint tool-tip" data-original-title="<c:out value='${field.hint}'/>"></i>
    </c:set>
</c:if>

<c:choose>
    <c:when test="${field.type eq 'textfield'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <input type="text" name="${field.formRelativeUniqueName}" class="${field.styleClass} form-control" value="${field.value}"
                   <c:if test='${field.length gt 0}'>size="${field.length}"</c:if> <c:if test='${field.maxLength gt 0}'>maxlength="${field.maxLength}"</c:if> />
         </div>
    </c:when>

    <c:when test="${field.type eq 'passwordfield'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <input type="password" name="${field.formRelativeUniqueName}" class="${field.styleClass} form-control"
                   <c:if test='${field.length gt 0}'>size="${field.length}"</c:if> <c:if test='${field.maxLength gt 0}'>maxlength="${field.maxLength}"</c:if> />
       </div>
    </c:when>

    <c:when test="${field.type eq 'textarea'}">
        <div class="col-xs-8">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <textarea name="${field.formRelativeUniqueName}" class="${field.styleClass} form-control"
                      cols="${field.cols}" rows="${field.rows}"
                      <c:if test='${field.minLength gt 0}'>minlength="${field.minLength}"</c:if> <c:if test='${field.maxLength gt 0}'>maxlength="${field.maxLength}"</c:if>>${field.value}</textarea>
        </div>
    </c:when>

    <c:when test="${field.type eq 'dropdown'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <select name="${field.formRelativeUniqueName}" class="${field.styleClass} form-control">
                <c:forEach var="option" items="${field.options}">
                    <option value="<c:out value='${option.value}'/>" <c:if test='${option.selected}'>selected="selected"</c:if>><c:out value="${option.text}"/></option>
                </c:forEach>
            </select>
        </div>
    </c:when>

    <c:when test="${field.type eq 'fileuploadfield'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <input type="file" name="${field.formRelativeUniqueName}" class="${field.styleClass} form-control" />
        </div>
    </c:when>

    <c:when test="${field.type eq 'datefield'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <i class="icon-calendar date-field-button btn btn-sm btn-default"></i><input type="text" name="${field.formRelativeUniqueName}" class="date ${field.styleClass} form-control" value="${field.value}" />
            <script>
                $(document).ready(function() {
                    $(function() {
                        $('input[class*="date"][name="${field.formRelativeUniqueName}"]').datepicker({
                          showOn : "focus",
                          changeMonth: true,
                          changeYear: true,
                          yearRange: "1900:c",
                          dateFormat : '${field.dateFormat}'.replace(/yyyy/g, 'yy').replace(/M/g, 'm'), // because java date format is different from jquery-ui date format
                          autoSize : true
                        });
                    });
                    $(".date-field-button").click(function() { $('input[class*="date"][name="${field.formRelativeUniqueName}"]').datepicker("show"); });
                });
            </script>
        </div>
    </c:when>

    <c:when test="${field.type eq 'radiogroup'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <c:forEach var="radio" items="${field.fields}">
                <p>
                    <input type="radio" name="${field.formRelativeUniqueName}" class="${radio.styleClass}" value="<c:out value='${radio.value}'/>"
                        <c:if test='${radio.checked}'>checked="true"</c:if> />
                    <c:out value='${radio.label}'/>
                </p>
            </c:forEach>
            <c:if test="${field.allowOther}">
                <p>
                    <input type="radio" name="${field.formRelativeUniqueName}" class="${field.styleClass}" value="-other"
                        <c:if test='${field.otherValue}'>checked="true"</c:if> />
                    Other:
                    <span>
                        <input type="text" name="${field.formRelativeUniqueName}-other" class="textfield-other"
                            <c:if test='${field.length gt 0}'>size="${field.length}"</c:if> <c:if test='${field.maxLength gt 0}'>maxlength="${field.maxLength}"</c:if> />
                    </span>
                </p>
            </c:if>
        </div>
    </c:when>

    <c:when test="${field.type eq 'checkboxgroup'}">
        <div class="col-xs-7">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <c:forEach var="checkbox" items="${field.fields}">
                <p>
                    <input type="checkbox" name="${checkbox.formRelativeUniqueName}" class="${checkbox.styleClass}" value="<c:out value='${checkbox.value}'/>"
                         <c:if test='${checkbox.checked}'>checked="true"</c:if> />
                    <c:out value='${checkbox.label}'/>
                </p>
            </c:forEach>
            <c:if test="${field.allowOther}">
                <input type="checkbox" name="${field.formRelativeUniqueName}" class="${field.styleClass}" value="-other"
                    <c:if test='${field.otherValue}'>checked="true"</c:if> />
                Other:
                <span>
                    <input type="text" name="${field.formRelativeUniqueName}-other" class="textfield-other"
                         <c:if test='${field.length gt 0}'>size="${field.length}"</c:if> <c:if test='${field.maxLength gt 0}'>maxlength="${field.maxLength}"</c:if> />
                </span>
            </c:if>
        </div>
    </c:when>

    <c:when test="${field.type eq 'likert'}">
        <div class="col-xs-9">
            <label><c:out value='${field.label}'/><span class="eforms-req"><c:out value='${field.requiredMarker}'/></span></label>
            ${hint}
            <table class="eforms-likert-table">
                <tr>
                    <td>&nbsp;</td>
                    <c:forEach var="option" items="${field.options}">
                        <td>
                            ${option}
                        </td>
                    </c:forEach>
                </tr>
                <c:forEach var="item" items="${field.optionsMap}">
                    <tr>
                        <td>${item.key.label}</td>
                        <c:forEach var="radio" items="${item.value}">
                            <td>
                                <input type="radio" name="${radio.formRelativeUniqueName}" class="${radio.styleClass}" value="${radio.value}"
                                     <c:if test='${radio.checked}'>checked="true"</c:if> />
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </c:when>
</c:choose>

<c:if test="${field.type ne 'simpletextfield'}">
        </div>
    </div>
</c:if>