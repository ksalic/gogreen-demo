/*
 * Copyright 2012-2022 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";
$(document).ready(function() {
  var location = window.location;
  var path  = location.protocol + "//" + location.host + location.pathname;
  path = path.replace("console/","");
  var randomAuthor = "author" + randomWithZeros(20);
  var randomEditor = "editor" + randomWithZeros(20);
  var randomAdmin = "admin" + randomWithZeros(20);
  $("#RandomAuthor").append(randomAuthor + " - " + randomAuthor);
  $("#RandomEditor").append(randomEditor + " - " + randomEditor);
  $("#RandomAdmin").append(randomAdmin + " - " + randomAdmin);
});

function randomWithZeros(upperLimit) {
    var randomNumber = Math.ceil(Math.random() * upperLimit);
    return (randomNumber < 10) ? "0" + randomNumber : "" + randomNumber;
}