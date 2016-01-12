<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<div id="canvas"></div> 
 
<script src="http://mrdoob.com/projects/chromeexperiments/ball_pool/js/protoclass.js"></script> 
<script src='http://mrdoob.com/projects/chromeexperiments/ball_pool/js/box2d.js'></script> 

<script type="text/javascript">

function createInstructions() {

	var size = 250;

	var element = document.createElement( 'div' );
	element.width = size;
	element.height = size;	
	element.style.position = 'absolute';
	element.style.left = -200 + 'px';
	element.style.top = -200 + 'px';
	element.style.cursor = "default";

	canvas.appendChild(element);
	elements.push( element );

	var circle = document.createElement( 'canvas' );
	circle.width = size;
	circle.height = size;

	var graphics = circle.getContext( '2d' );

	graphics.fillStyle = theme[ 3 ];
	graphics.beginPath();
	graphics.arc( size * .5, size * .5, size * .5, 0, PI2, true );
	graphics.closePath();
	graphics.fill();

	element.appendChild( circle );

	text = document.createElement( 'div' );
	text.onSelectStart = null;
	text.innerHTML = '<span style="color:' + theme[0] + ';font-size:28px;"><c:forEach items="${requestScope.feeds}" var="feed" varStatus="loop"><c:forEach items="${feed.entries}" var="entry" end="${entriesPerFeed - 1}"><fmt:formatDate value="${entry.publishedDate}" type="date" pattern="MMM d, yyyy"/><c:out value="- ${feed.author}"/><a href="${fn:escapeXml(entry.link)}"><c:out escapeXml="true" value="${entry.title}"/></a></c:forEach></c:forEach></span>';
	text.style.color = theme[1];
	text.style.position = 'absolute';
	text.style.left = '0px';
	text.style.top = '0px';
	text.style.fontFamily = 'Georgia';
	text.style.textAlign = 'center';
	element.appendChild(text);

	text.style.left = ((250 - text.clientWidth) / 2) +'px';
	text.style.top = ((250 - text.clientHeight) / 2) +'px';	

	var b2body = new b2BodyDef();

	var circle = new b2CircleDef();
	circle.radius = size / 2;
	circle.density = 1;
	circle.friction = 0.3;
	circle.restitution = 0.3;
	b2body.AddShape(circle);
	b2body.userData = {element: element};

	b2body.position.Set( Math.random() * stage[2], Math.random() * -200 );
	b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );
	bodies.push( world.CreateBody(b2body) );	
}
</script>

    <hst:link var="ballpool" path="/js/ball_pool.js"/>
    <script src="${ballpool}" type="text/javascript"></script>


