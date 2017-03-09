<%@page import="gov.usgs.wma.PropertyLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%

String applicationName = PropertyLoader.getProperty("redirect.application.name", "The Application");
String applicationUrl = PropertyLoader.getProperty("redirect.application.url", "/redirectUrl");
Integer redirectSeconds = null;
String redirectSecondsString = PropertyLoader.getProperty("redirect.auto.seconds", null);
if(redirectSecondsString != null) {
	try {
		redirectSeconds = Integer.parseInt(redirectSecondsString);
	} catch(Exception e) {}
}

%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=9" />
		
		<title><%=applicationName%> Has Moved</title>

		<%-- Libs CSS--%>
		<link rel="stylesheet" type="text/css" href="webjars/font-awesome/4.3.0/css/font-awesome.min.css" />

		<%-- USGS CSS --%>
		<link rel="stylesheet" href="css/usgs_style_main.css" />
		
		<%-- Libs Javascript --%>
		<script type="text/javascript" src="webjars/jquery/2.1.4/jquery.min.js"></script>
		
		
		<script type="text/javascript">

		var timeLeft;
		var redirectCountdown = function() {
			if(timeLeft > 0) {
				$("#redirect-time").html(timeLeft--);
			} else {
				window.location="<%=applicationUrl%>"
			}
		}
		

		<% if(redirectSeconds != null) {%>
		timeLeft = <%=redirectSeconds%>;
		setInterval(redirectCountdown, 1000);
		<%}%>
		</script>
		
	</head>
	<body>
		<jsp:include page="jsp/header.jsp"></jsp:include>
		
		<div class="body-content">
		<b><%=applicationName%></b> has moved to <a href="<%=applicationUrl%>"><%=applicationUrl%></a>. Please update your bookmarks.
		
		<% if(redirectSeconds != null) {%>
			<br/><br/>
			<i>You will be redirected in <span id="redirect-time"></span> seconds...</i>
		<%}%>
		</div>
		<%-- USGS VisID compliant footer --%>
		<jsp:include page="jsp/footer.jsp"></jsp:include>
	</body>
	
</html>
