<%--

    Copyright 2010-2014 Hippo B.V. (http://www.onehippo.com)

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
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<c:if test="${not empty form.title}">
  <h2><c:out value="${form.title}" /></h2>
  <hippo-gogreen:title title="${form.title}"/>
</c:if>

<c:if test="${not empty formIntro}">
  <p><c:out value="${formIntro}" /></p>
</c:if>

<c:set var="style">
  <c:if test="${empty eforms_errors}">display:none;</c:if>
</c:set>
<div id="feedbackPanel" class="alert alert-danger" style="${style}">
    <ul>
        <c:forEach items="${eforms_errors}" var="error">
            <li><c:out value="${error.value.localizedMessage}"/></li>
        </c:forEach>
    </ul>
</div>

<c:if test="${maxFormSubmissionsReached}">
    <div class="alert alert-danger">
        <div class="msg">
            <c:choose>
                <c:when test="${not empty maxFormSubmissionsReachedText}">
                    <p><c:out value="${maxFormSubmissionsReachedText}" /></p>
                </c:when>
                <c:otherwise>
                    <p>The maximum number of submission for this form has been reached</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:if>

<c:if test="${not maxFormSubmissionsReached}">

  <form class="form form-wrapper" action="<hst:actionURL />" method="post" name="${form.name}" <c:if test="${form.multipart}">enctype="multipart/form-data"</c:if>>

    <c:set var="formPages" value="${form.pages}" />

    <c:if test="${fn:length(formPages) gt 1}">
      <div class="pagination-container">
        <ul id="pagesTab" class="pagination" style="DISPLAY: none">
          <c:forEach var="page" items="${formPages}" varStatus="status">
            <c:choose>
              <c:when test="${status.index eq 0}">
                <li class="conditionally-visible selected"><span class="current"><c:out value="${page.label}" /></span></li>
              </c:when>
              <c:otherwise>
                <li class="conditionally-visible"><span><c:out value="${page.label}" /></span></li>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </ul>
      </div>
    </c:if>

    <c:forEach var="page" items="${formPages}" varStatus="status">

      <div id="page${status.index}" class="eforms-page conditionally-visible">

        <c:forEach var="fieldItem" items="${page.fields}">
          <c:choose>
            <c:when test="${fieldItem.type eq 'fieldgroup'}">
              <c:set var="groupCssClassName" value="eforms-fieldgroup" />
              <c:if test="${fieldItem.oneline}">
                <c:set var="groupCssClassName" value="eforms-fieldgroup oneline" />
              </c:if>
              <fieldset name="${fieldItem.fieldNamePrefix}" class="${groupCssClassName} col-xs-7">
                <c:if test="${not empty fieldItem.label}">
                  <legend class="eforms-fieldgroupname"><c:out value="${fieldItem.label}"/></legend>
                </c:if>
                <c:forEach var="fieldItemInGroup" items="${fieldItem.fields}">
                  <tag:eformsrenderfield field="${fieldItemInGroup}"/>
                </c:forEach>
                <span class="eforms-hint"><c:out value="${fieldItem.hint}"/></span>
              </fieldset>
            </c:when>
            <c:otherwise>
              <tag:eformsrenderfield field="${fieldItem}"/>
            </c:otherwise>
          </c:choose>

        </c:forEach>

      </div>

    </c:forEach>

    <div class="eforms-buttons">
      <input id="previousPageButton" type="button" name="previousPageButton" value="Previous" style="DISPLAY: none" />
      <input id="nextPageButton" type="button" name="nextPageButton" value="Next" style="DISPLAY: none" />
      <c:forEach var="button" items="${form.buttons}">
        <c:choose>
          <c:when test="${button.type eq 'resetbutton'}">
            <input type="reset" name="${button.formRelativeUniqueName}" class="${button.styleClass}"
                   value="<c:choose><c:when test='${empty button.value}'><c:out value='${button.name}'/></c:when><c:otherwise><c:out value='${button.value}'/></c:otherwise></c:choose>" />
          </c:when>
          <c:when test="${button.type eq 'submitbutton'}">
            <input type="submit" name="${button.formRelativeUniqueName}" class="${button.styleClass}"
                   value="<c:choose><c:when test='${empty button.value}'><c:out value='${button.name}'/></c:when><c:otherwise><c:out value='${button.value}'/></c:otherwise></c:choose>" />
          </c:when>
          <c:otherwise>
            <input type="button" name="${button.formRelativeUniqueName}" class="${button.styleClass}"
                   value="<c:choose><c:when test='${empty button.value}'><c:out value='${button.name}'/></c:when><c:otherwise><c:out value='${button.value}'/></c:otherwise></c:choose>" />
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>

  </form>

</c:if>

<%--
    //########################################################################
    //  HEADER CONTRIBUTIONS
    //########################################################################
--%>

<hst:headContribution keyHint="formValidationCss" category="css">
  <link rel="stylesheet" href="<hst:link path="/js/formcheck/theme/blue/formcheck.css"/>" type="text/css" />
</hst:headContribution>

<hst:headContribution keyHint="jqueryUICss" category="css">
  <link rel="stylesheet" href="<hst:link path="/css/jquery-ui-1.10.2.custom.min.css"/>" type="text/css" />
</hst:headContribution>

<hst:headContribution keyHint="jquery-datepicker" category="jsExternal">
  <script type="text/javascript" src="<hst:link path="/js/jquery-ui-1.10.2.custom.min.js"/>"></script>
</hst:headContribution>

<hst:headContribution keyHint="formJsValidation" category="jsExternal">
  <script type="text/javascript" src="<hst:link path="/js/jquery-validate-1.1.2.min.js"/>"></script>
</hst:headContribution>

<hst:headContribution keyHint="formCss" category="css">
  <link rel="stylesheet" href="<hst:link path="/css/eforms.css"/>" type="text/css" />
</hst:headContribution>

<script type="text/javascript">
$(document).ready(function() {

  $('form[name="${form.name}"]').validate({errorElement:'div'});

  var resetPagesVisible = function() {
    var allPages = $('.eforms-page.conditionally-visible');
    var curPage = $('.eforms-page.conditionally-visible:visible:first');
    var curIndex = -1;

    for (var i = 0; i < allPages.length; i++) {
      if (allPages[i].id == curPage.attr('id')) {
        curIndex = i;
      }
    }

    if (curIndex > 0) {
      $('#previousPageButton').show();
    }

    if (curIndex < allPages.length - 1) {
      $('#nextPageButton').show();
      $('.eforms-buttons input[type="submit"]').each(function() {
        $(this).hide();
      });
    } else if (curIndex == allPages.length - 1) {
      $('#nextPageButton').hide();
      $('.eforms-buttons input[type="submit"]').each(function() {
        $(this).show();
      });
    }

    $('#pagesTab li').hide();
    $('#pagesTab li.conditionally-visible').show();
  };


  <%--
    Function used to create parameters object containing form fields name/value pairs.
    The params object can be posted through ajax for validation.
    --%>
  function addFormFieldsToParameters(fields, params) {
    fields.each(function() {
      if ($(this).attr('type') == 'checkbox') {
        if (!params[$(this).attr('name')]) {
          var checked = $('.eforms-page.conditionally-visible:visible .eforms-field *:input[name="' + $(this).attr('name') + '"]:checked');
          if (checked.length > 0) {
            var values = [];
            checked.each(function(index) {
              values[index] = $(this).val();
            });
            params[$(this).attr('name')] = values;
          } else {
            params[$(this).attr('name')] = '';
          }
        }
      } else if ($(this).attr('type') == 'radio') {
        if (!params[$(this).attr('name')]) {
          var checked = $('.eforms-page.conditionally-visible:visible .eforms-field *:input[name="' + $(this).attr('name') + '"]:checked');
          if (checked.length > 0) {
            params[$(this).attr('name')] = $('.eforms-page.conditionally-visible:visible .eforms-field *:input[name="' + $(this).attr('name') + '"]:checked').val();
          } else {
            params[$(this).attr('name')] = '';
          }
        }
      } else {
        params[$(this).attr('name')] = $(this).val();
      }
    });
  }


  <%-- real-time ajax-based single field validation --%>
  var fields = $('.eforms-field *:input');
  var ajaxValidationUrl = '<hst:resourceURL resourceId="validation"/>';

  $('.eforms-field *:input').blur(function() {
    // on leaving form field, post field name/value for ajax validation
    var params = {};
    params[$(this).attr('name')] = $(this).val();
    $.post(ajaxValidationUrl, params,
      function(data) {
        var feedbackPanel = $('#feedbackPanel');
        var count = 0;
        if (data) {
          for (var fieldName in data) {
            // get the error message
            var errorMessage = data[fieldName];
            // remove previous error messages from feedback panel
            var messagesList = $('#feedbackPanel > ul');
            messagesList.empty();
            if (errorMessage) {
              // add error message to feedback panel
              messagesList.append('<li>' + errorMessage.localizedMessage + '</li>');
              count++;
            }
          }
        }
        if (count > 0) {
          // make feedback panel visible
          feedbackPanel.show();
        } else {
          // make feedback panel invisible
          feedbackPanel.hide();
        }
      }, "json");
  });


  <%-- real-time ajax based validation of field groups --%>
  var lastElementFocused = null;
  var currentElementFocused = null;
  $('.eforms-field *:input').focus(function(e) {
    if (e.target) {
      var el = $(e.target);
      if (el && el.length > 0 && $(el[0]).attr('name')) {
        lastElementFocused = currentElementFocused; // save last focused element
        currentElementFocused = $(el[0]);

        if (lastElementFocused) {
          var params = {};

          // post the last focused field (otherwise the field group validation may remove the error
          // message set by the single-field validation)
          addFormFieldsToParameters($().add(lastElementFocused), params);

          // did the user leave a field group? if so, also post containing group and its other fields
          var oldGroup = null;
          var newGroup = null;

          var list = lastElementFocused.closest('.eforms-fieldgroup');
          if (list && list.length > 0) {
            oldGroup = $(list[0]);
          }

          if (oldGroup) {
            var newFocusElement = null;
            if (currentElementFocused != null) {
              list = $('.eforms-page.conditionally-visible:visible .eforms-field:visible *:input[name="' + currentElementFocused .attr('name') + '"]');
              if (list && list.length > 0) {
                newFocusElement = $(list[0]);
              }
            }

            if (newFocusElement) {
              var list = newFocusElement.closest('.eforms-fieldgroup');
              if (list && list.length > 0) {
                newGroup = $(list[0]);
              }

              if (!newGroup || (newGroup && newGroup.attr('name') && oldGroup.attr('name') && oldGroup.attr('name') != newGroup.attr('name'))) {

                var fieldsInGroup = $('.eforms-page.conditionally-visible:visible .eforms-fieldgroup:visible[name="' + oldGroup.attr('name') + '"] .eforms-field:visible *:input');
                addFormFieldsToParameters(fieldsInGroup, params);

                // add an empty parameter for the old group on the current page
                params[oldGroup.attr('name')] = '';
              }
            }
          }

          $.post(ajaxValidationUrl, params,
            function(data){
              var feedbackPanel = $('#feedbackPanel');
              var count = 0;
              if (data) {
                // remove previous error messages from feedback panel
                var messagesList = $('#feedbackPanel > ul');
                messagesList.empty();

                for (var fieldName in data) {
                  // get the error message
                  var errorMessage = data[fieldName];
                  if (errorMessage) {
                    // add error message to feedback panel
                    messagesList.append('<li>' + errorMessage.localizedMessage + '</li>');
                    count++;
                  }
                }
              }
              if (count > 0) {
                  // make feedback panel visible
                  feedbackPanel.show();
              } else {
                // make feedback panel invisible
                feedbackPanel.hide();
              }
            }, "json");

        }

      }
    }
  });



  <%-- Write JSON of field condition infos --%>
  var conditions = ${form.conditionsAsJson};
  var condFieldNames = {};

  if (conditions) {
    var items = [];
    if (conditions['fields']) {
      items = items.concat(conditions['fields']);
    }
    if (conditions['pages']) {
      items = items.concat(conditions['pages']);
    }
    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      var condFieldName = item['condname'];
      if (!condFieldNames[condFieldName]) {
        condFieldNames[condFieldName] = true;
      }
    }
  }

  for (var condFieldName in condFieldNames) {
    var condField = $('.eforms-field *[name="' + condFieldName + '"]');
    if (condField.length == 0) continue;
    var eventType = 'change';

    condField.bind(eventType, function() {
      if (conditions && conditions['fields']) {
        var fields = conditions['fields'];

        for (var i = 0; i < fields.length; i++) {
          var field = fields[i];
          var condFieldName = field['condname'];
          if ($(this).attr('name') != condFieldName) continue;

          var name = field['name'];
          var targetField = $('.eforms-field *[name="' + name + '"]');
          if (targetField.length == 0) {
              targetField = $('.eforms-fieldgroup[name="' + name + '"]');
          }
          if (targetField.length == 0) {
              targetField = $('.eforms-text[name="' + name + '"]');
          }
          if (targetField.length == 0) continue;

          var targetContainer = targetField.parents('.eforms-field');
          if (targetContainer.length == 0) {
              targetContainer = targetField;
          }

          var type = field['condtype'];
          var condFieldValue = field['condvalue'];
          var curSelectedValue = $(this).val();
          if ($(this).is('input') && $(this).attr('type') == 'radio') {
            curSelectedValue = $('.eforms-field *[name="' + condFieldName + '"]:radio:checked').val();
          }

          if (type == 'visibility') {
            if (condFieldValue == curSelectedValue) {
              targetContainer.show();
            } else {
              targetContainer.hide();
            }
          }
        }

        var pages = conditions['pages'];
        for (var i = 0; i < pages.length; i++) {
          var page = pages[i];
          var condFieldName = page['condname'];
          if ($(this).attr('name') != condFieldName) continue;

          var pageIndex = page['index'];
          var targetPage = $('#page' + pageIndex);
          var type = page['condtype'];
          var condFieldValue = page['condvalue'];
          var curSelectedValue = $(this).val();
          if ($(this).is('input') && $(this).attr('type') == 'radio') {
            curSelectedValue = $('.eforms-field *[name="' + condFieldName + '"]:radio:checked').val();
          }

          if (type == 'visibility') {
            if (condFieldValue == curSelectedValue) {
              targetPage.addClass('conditionally-visible');
              $('#pagesTab li:nth-child(' + (pageIndex + 1) + ')').addClass('conditionally-visible');
            } else {
              targetPage.removeClass('conditionally-visible');
              $('#pagesTab li:nth-child(' + (pageIndex + 1) + ')').removeClass('conditionally-visible');
            }
            resetPagesVisible();
          }
        }
      }
    });

    condField.trigger(eventType);
  }

  <%-- In order not to show page tab for script-disabled clients, show the tabs by script if exits. --%>
  if ($('#pagesTab')) {
    $('#pagesTab').show();
  }
  <%-- Hide all the pages except of the first page --%>
  $('.eforms-page').each(function() {
    $(this).hide();
  });
  if ($('.eforms-page.conditionally-visible').length) {
    $('.eforms-page.conditionally-visible:first').show();
  }

  resetPagesVisible();

  $('#previousPageButton').click(function() {
    var curPage = $('.eforms-page.conditionally-visible:visible');
    var prevPage = curPage.prevAll('.eforms-page.conditionally-visible:first');
    prevPage.show();
    curPage.hide();

    var curIndex = parseInt(curPage.attr('id').replace(/^page/, ''));
    var prevIndex = parseInt(prevPage.attr('id').replace(/^page/, ''));
    $('#pagesTab li:nth-child(' + (curIndex + 1) + ')').removeClass('selected').find('span').removeClass('current');;
    $('#pagesTab li:nth-child(' + (prevIndex + 1) + ')').addClass('selected').find('span').addClass('current');;

    if (prevPage.prevAll('.eforms-page.conditionally-visible:first').length == 0) {
      $('#previousPageButton').hide();
    }
    $('#nextPageButton').show();
    $('.eforms-buttons input[type="submit"]').each(function() {
        $(this).hide();
      });

    // remove error messages from feedback panel
    var messagesList = $('#feedbackPanel > ul');
    messagesList.empty();

    // hide feedbackPanel
    var feedbackPanel = $('#feedbackPanel');
    feedbackPanel.hide();

  });

  $('#nextPageButton').click(function() {
    var curPage = $('.eforms-page.conditionally-visible:visible');

    // ajax based validation
    // validate all fields on current page before going to the next
    var params = {};
    var fieldsOnPage = $('.eforms-page.conditionally-visible:visible .eforms-field *:input');
    addFormFieldsToParameters(fieldsOnPage, params);

    // add an empty parameter for any group on the current page
    var groupsOnPage = $('.eforms-page.conditionally-visible:visible .eforms-fieldgroup');
    groupsOnPage.each(function() {
      params[$(this).attr('name')] = '';
    });

    // add current page index to parameters
    params['currentPage'] = curPage.attr('id').replace(/^page/, '');

    $.post(ajaxValidationUrl, params,
      function(data){

        // remove previous error messages from feedback panel
        var messagesList = $('#feedbackPanel > ul');
        messagesList.empty();

        var count = 0;
        if (data) {
          for (var fieldName in data) {
            // get the error message
            var errorMessage = data[fieldName];
            if (errorMessage) {
              // add error message to feedback panel
              messagesList.append('<li>' + errorMessage.localizedMessage + '</li>');
              count++;
            }
          }
        }
        var feedbackPanel = $('#feedbackPanel');
        if (count > 0) {
            // there are validation errors
            // make feedback panel visible
            feedbackPanel.show();
        } else {
          // no error messages
          // make feedback panel invisible
          feedbackPanel.hide();

          // go to the next page
          var nextPage = curPage.nextAll('.eforms-page.conditionally-visible:first');
          nextPage.show();
          curPage.hide();

          var curIndex = parseInt(curPage.attr('id').replace(/^page/, ''));
          var nextIndex = parseInt(nextPage.attr('id').replace(/^page/, ''));
          $('#pagesTab li:nth-child(' + (curIndex + 1) + ')').removeClass('selected').find('span').removeClass('current');
          $('#pagesTab li:nth-child(' + (nextIndex + 1) + ')').addClass('selected').find('span').addClass('current');

          $('#previousPageButton').show();
          if (nextPage.nextAll('.eforms-page.conditionally-visible:first').length == 0) {
            $('#nextPageButton').hide();
            $('.eforms-buttons input[type="submit"]').each(function() {
              $(this).show();
            });
          }

        }

      }, "json");


  });


  var valid = false;

  // ajax page validation in case of last (or only) page
  $('form[name="${form.name}"]').submit(function(event) {

    var curPage = $('.eforms-page.conditionally-visible:visible');

    // if valid flag is set, page was validated and form can be submitted
    if (valid) {
        return true;
    }

    var params = {};
    var fieldsOnPage = $('.eforms-page.conditionally-visible:visible .eforms-field:visible *:input');
    addFormFieldsToParameters(fieldsOnPage, params);

    // add an empty parameter for any visible group on the current page
    var groupsOnPage = $('.eforms-page.conditionally-visible:visible .eforms-fieldgroup:visible');
    groupsOnPage.each(function() {
        params[$(this).attr('name')] = '';
    });

    // add current page index to parameters
    params['currentPage'] = curPage.attr('id').replace(/^page/, '');

    // prevent form submission as we want to do ajax validation first
    event.preventDefault();

    $.post(ajaxValidationUrl, params,
      function(data){

        // remove previous error messages from feedback panel
        var messagesList = $('#feedbackPanel > ul');
        messagesList.empty();

        var count = 0;
        if (data) {
          for (var fieldName in data) {
            // get the error message
            var errorMessage = data[fieldName];
            if (errorMessage) {
              // add error message to feedback panel
              messagesList.append('<li>' + errorMessage.localizedMessage + '</li>');
              count++;
            }
          }
        }
        var feedbackPanel = $('#feedbackPanel');
        if (count > 0) {
            // there are validation errors
            // make feedback panel visible
            feedbackPanel.show();

        } else {
          // no error messages
          // make feedback panel invisible
          feedbackPanel.hide();

          // set valid flag and resubmit form
          valid = true;
          $('form[name="${form.name}"] input:submit').click();
        }

      }, "json");

  });

});
</script>
