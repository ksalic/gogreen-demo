<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>
<%@include file="../includes/tags.jspf" %>

<hst:defineObjects/>

<hst:link var="productSearchUrl" path="/topproducts" mount="restapi" fullyQualified="true">
  <hst:param name="_type" value="json" />
</hst:link>

<hst:link var="json" path="/js/json2.js"/>
<script src="${json}" type="text/javascript"></script>

<hst:link var="sh" path="/js/syntaxhighlighter_3.0.83" />
<script type="text/javascript" src="${sh}/scripts/shCore.js"></script> 
<script type="text/javascript" src="${sh}/scripts/shBrushJScript.js"></script>

<hst:headContribution category="css">
  <link type="text/css" rel="stylesheet" href="${sh}/styles/shCoreDefault.css"/>
</hst:headContribution>

<hst:headContribution>
  <title><fmt:message key="standard.header.title"/> - <c:out value="${requestScope.document.title}"/></title>
</hst:headContribution>

<script type="text/javascript">
  //<![CDATA[
$(document).ready(function() {
  var state = {
    shown: "top-product"
  };

  var showSelectedForm = function() {
    var current = $("#rest-call-uri option:selected").val();
    if (current != state.shown) {
      $("#" + state.shown).hide();
      $("#" + current).show();
      state.shown = current;
    }
  };

  showSelectedForm();

  $("#rest-call-uri").change(function() {
    showSelectedForm();

    $('#rest-url').empty();
    $('#rest-output').empty();
  });

  $("#rest-clear").click(function() {
    $("#rest-output").empty();
  });

  $("#rest-submit").click(function() {
    $("#" + state.shown + " form").submit();
  });

  var formatXml = function(xml) {
    var formatted = '';
    var reg = /(>)(<)(\/*)/g;
    xml = xml.replace(reg, '$1\r\n$2$3');
    var pad = 0;
    $.each(xml.split('\r\n'), function(index, node) {
        var indent = 0;
        if (node.match( /.+<\/\w[^>]*>$/ )) {
            indent = 0;
        } else if (node.match( /^<\/\w/ )) {
            if (pad != 0) {
                pad -= 1;
            }
        } else if (node.match( /^<\w[^>]*[^\/]>.*$/ )) {
            indent = 1;
        } else {
            indent = 0;
        }

        var padding = '';
        for (var i = 0; i < pad; i++) {
            padding += '  ';
        }

        formatted += padding + node + '\r\n';
        pad += indent;
    });

    return formatted;
  };

  var updateOutput = function(url) {
    $.ajax({ 
      url: url, 
      success:
        function(data, textStatus, xmlHttp) {
          $('#rest-url').empty();
          $('#rest-url').append('<a href="' + url + '">' + url + '</a>');

          var text = xmlHttp.responseText;
          var contentType = xmlHttp.getResponseHeader("Content-Type");
          if (contentType.match(/application\/json/)) {
            text = JSON.stringify(JSON.parse(xmlHttp.responseText), null, " ").replace(/\\n/g, '\n');
          } else if (contentType.match(/application\/xml/)) {
            text = formatXml(xmlHttp.responseText).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
          }
          $('#rest-output').empty();
          $('#rest-output').append('<pre class="brush: js">' + text + '\n</pre>');
          SyntaxHighlighter.highlight();
        }
    });
  };

  var encodeParams = function(restUrl, form) {
    var params = $(form).serializeArray();
    $.each(params, function(idx, param) {
      if (!idx && restUrl.indexOf('?') == -1) {
        restUrl += '?';
      } else {
        restUrl += '&';
      }
      restUrl += encodeURIComponent(param.name) + '=' + encodeURIComponent(param.value);
    });
    return restUrl;
  };

  $("#top-product form").submit(function() {
    var restUrl = encodeParams('${productSearchUrl}', this);
    updateOutput(restUrl);
    return false;
  });

  $("#product-detail form").submit(function() {
    var restUrl = encodeParams($("#productDetailDropdownList option:selected").val(), this);
    updateOutput(restUrl);
    return false;
  });

  $.ajax({
    url: '${productSearchUrl}',
    success:
      function(data, textStatus, xmlHttp) {
        $.each(data, function(i, item) {
          $("#productDetailDropdownList").append(
            "<option value='" + item.productLink + "'>" + item.localizedName + "</option>\n");
        });
        $("#productDetailDropdownList select:first").select();
      }
  });
});
  //]]>
</script>

    <h2 class="h2-section-title"><c:out value="${requestScope.document.title}"/></h2>
    <div class="i-section-title"></div>
    <p><hst:html hippohtml="${requestScope.document.description}" /></p>
    <div class="space-sep40"></div>

    <div class="title-block clearfix">
        <h3 class="h3-body-title">REST Call URI</h3><div class="title-seperator"></div>
    </div>
    <p>
        <select name="rest-call-uri" id="rest-call-uri">
          <option value="top-product" selected="selected">Top Products</option>
          <option value="product-detail">Product detail</option>
        </select>
    </p>

    <div id="top-product">
        <p>Retrieve the top products through the REST API.</p>
        <form action="">
            <%--<h4>Required Parameters</h4>
            <div class="body">None</div>--%>
            <h4>Optional Parameters</h4>
            <div class="params">
                <p class="field-description">Order products by rating or price.</p>
                <p>
                    <label for="sortby">Sort by</label>
                    <select name="sortby" id="sortby">
                        <option value="hippogogreen:rating" selected="selected">Rating</option>
                        <option value="hippogogreen:price">Price</option>
                    </select>
                </p>
                <p class="field-description">Sort ascending (low to high) or descending.</p>
                <p>
                    <label for="sortdir">Sort direction</label>
                    <select name="sortdir" id="sortdir">
                        <option value="descending" selected="selected">Descending</option>
                        <option value="ascending">Ascending</option>
                    </select>
                </p>
                <p class="field-description">Maximum number of results.</p>
                <p>
                    <label for="max">Max</label>
                    <input type="text" id="max" name="max" value="10" />
                </p>
            </div>
        </form>
    </div>

    <div id="product-detail" style="display: none;">
        <p>Retrieve product details through the REST API.</p>
        <form action="">
            <h4>Required Parameters</h4>
            <div class="params">
                <p>Show details of the selected product type.</p>
                <p>
                    <label>Product</label>
                    <select id="productDetailDropdownList"></select>
                 </p>
            </div>
            <div class="space-sep20"></div>
            <h4>Optional Parameters</h4>
            <div class="params">
                <p>Format the response as JSON or XML.</p>
                <p>
                    <label for="_type">Response Type</label>

                    <select id="_type" name="_type">
                        <option value="json" selected="selected">JSON</option>
                        <option value="xml">XML</option>
                    </select>
                </p>
            </div>
        </form>
    </div>

    <button class="btn btn-sm btn-default" id="rest-submit">Execute REST Call</button>
    <input type="reset" class="btn btn-sm btn-default" value="Clear REST Call" id="rest-clear" />
    <div class="space-sep40"></div>

    <div class="title-block clearfix">
        <h3 class="h3-body-title">REST URL</h3><div class="title-seperator"></div>
    </div>
    <p id="rest-url"></p>
    <div class="space-sep40"></div>

    <div class="title-block clearfix">
        <h3 class="h3-body-title">REST Call Output</h3><div class="title-seperator"></div>
    </div>
    <div id="rest-output">
    </div>

    </div>
  </div>
</div>
