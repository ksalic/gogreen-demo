/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */

$(document).ready(function(){
  $(".rate").children("li").click(
	function () {
	  $(this).addClass("on");
	  $(this).prevAll().addClass("on");
	  $(this).nextAll().removeClass("on");
	  $("#ratingField").val($(this).text());
	});
});