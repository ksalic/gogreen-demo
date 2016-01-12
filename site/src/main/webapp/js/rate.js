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
	}),
  $(".rate").children("li").hover(
	function () {
	  $(this).addClass("hover");
	  $(this).prevAll().addClass("hover-on");
	  $(this).nextAll().addClass("hover-off");
	},
	function () {
	  $(this).siblings().add(this).removeClass("hover hover-on hover-off");
	});
});