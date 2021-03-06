<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<!doctype html>

<!-- Most of this code comes from the original PugPig.com book -->

<html dir="ltr" lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title></title>
	<meta name="description" content="PugPig example">
	<meta name="author" content="Andrew Keats - Steakeye.com">
	<meta name="delaySnapshotUntilReady" content="YES" />

	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

	<link rel="shortcut icon" href="http://kaldorgroup.com/Books/BOOKPUGPIG/assets/images/favicon.ico">
	<link rel="apple-touch-icon" href="http://kaldorgroup.com/Books/BOOKPUGPIG/assets/images/apple-touch-icon.png">

	<link rel="stylesheet" href="http://kaldorgroup.com/Books/BOOKPUGPIG/assets/css/base.css?v=0">
	<link rel="stylesheet" href="http://kaldorgroup.com/Books/BOOKPUGPIG/assets/css/site.css?v=0">

    <style>
        body { -webkit-tap-highlight-color:rgba(0,0,0,0); -webkit-user-select: none; }

        #overlay { background: rgba(0,0,0,0.7); width: 100%; height: 100%; position: absolute; top: 0; left: 0; z-index: 9000; display: none }
        #overlay p { -webkit-box-sizing: border-box; font: 30px/35px 'Chalkduster', 'ChalkboardSE-Regular', 'Comic Sans MS', sans-serif; color: #fff; position: absolute; top: 50%; left: 50%; width: 650px; height: 396px; margin: -198px 0 0 -325px;
            background: url(http://kaldorgroup.com/Books/BOOKPUGPIG/images/overlay.png) no-repeat 0 0; padding: 50px  65px;
        }
        #overlay #text {   }
        @media all and (orientation:landscape) {
             #overlay #pig { position: absolute; top: 56px; right: 64px; }
        }
        @media all and (orientation:portrait) {
            #overlay #pig { position: absolute; top: 48px; right: 58px; }
        }

    </style>
</head>
<body>          

	<hst:include ref="home-boxes-promo"/>

	<div id="container">
		<header>
			<h1><span class="daily">Go Green</span> events</h1>
		</header>
		<div id="main" role="main">
			<article>
				<hgroup>
					<h1>
						<strong>
							<hst:setBundle basename="messages"/>
							<fmt:message key="standard.date.format" var="dateformat"/>
							<fmt:formatDate value="${requestScope.document.date.time}" pattern="${dateformat}"/>: <c:out value="${requestScope.document.title}"/>
						</strong>
					</h1>
				</hgroup>
				<section class="video-content">
					<c:set var="image" value="${requestScope.document.firstImage}"/>
            		<c:if test="${image != null}">
		                <hst:link var="src" hippobean="${image.largeThumbnail}"/>
		                <img class="image" src="${src}" alt="${fn:escapeXml(image.alt)}"/>
		                <hippo-gogreen:imagecopyright image="${image}"/>
		            </c:if>
				</section>
				<div class="wrap">
				<p class="author"><span class="hidden">By </span>Arnold Ziffel</p>

				<hst:html hippohtml="${requestScope.document.description}"/>

				<aside id="anatomy">
					<h2>Location</h2>
					<figure>
						<c:url var="url" value="https://maps.google.com/?q=${requestScope.document.location.street} ${requestScope.document.location.number}, ${requestScope.document.location.city} ${requestScope.document.location.postalCode} ${requestScope.document.location.province}"/>
				        <c:if test="${not empty requestScope.document.location}">
				            <input id="address" type="hidden"
				                   value="Sofia"/>
				        </c:if>

						<figcaption><c:out value="${requestScope.document.location.street}"/>&nbsp;<c:out value="${requestScope.document.location.number}"/>,&nbsp;<c:out value="${requestScope.document.location.city}"/>&nbsp;<c:out value="${requestScope.document.location.postalCode}"/>&nbsp;<c:out value="${requestScope.document.location.province}"/></figcaption>
					</figure>
				</aside>

				</div>
			</article>
		</div>
		<footer>
			<!-- I imagine you would use this for page number data and any other high-level information -->
		</footer>

        <div id="overlay" onclick="hideOverlay();">
            <p>This page uses CSS3 columns for text layout, HTML5 video for my screencast, and CSS transitions when interacting with the anatomy image. The Tweet and Share buttons really work. Please use them.</p>
            <img id="pig" src="http://kaldorgroup.com/Books/BOOKPUGPIG/images/prod2.png" alt="">
        </div>

	</div>
</body>
</html>


