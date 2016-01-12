/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 */
sfHover = function() {
	var sfEls = document.getElementById("main-nav").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	};
	document.getElementById("org").onmouseover=function() {
		this.className+="sfhover";
	};
	document.getElementById("org").onmouseout=function() {
		this.className=this.className.replace(new RegExp("sfhover\\b"), "");
	};
}
if (window.attachEvent) window.attachEvent("onload", sfHover);