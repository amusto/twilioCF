<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
 
<!-- Website Title --> 
<cfoutput>
<title>#application.siteTitle#</title>
</cfoutput>

<!-- Meta data for SEO -->
<meta name="description" content="">
<meta name="keywords" content="">

<!-- Template stylesheet -->
<link href="css/blue/screen.css" rel="stylesheet" type="text/css" media="all">
<link href="css/blue/datepicker.css" rel="stylesheet" type="text/css" media="all">
<link href="css/tipsy.css" rel="stylesheet" type="text/css" media="all">
<link href="js/visualize/visualize.css" rel="stylesheet" type="text/css" media="all">
<link href="js/jwysiwyg/jquery.wysiwyg.css" rel="stylesheet" type="text/css" media="all">
<link href="js/fancybox/jquery.fancybox-1.3.0.css" rel="stylesheet" type="text/css" media="all">
<link href="css/tipsy.css" rel="stylesheet" type="text/css" media="all">

<!--[if IE]>
	<link href="css/ie.css" rel="stylesheet" type="text/css" media="all">
	<script type="text/javascript" src="js/excanvas.js"></script>
<![endif]-->

<!-- Jquery and plugins -->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery.img.preload.js"></script>
<script type="text/javascript" src="js/hint.js"></script>
<script type="text/javascript" src="js/visualize/jquery.visualize.js"></script>
<script type="text/javascript" src="js/jwysiwyg/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/fancybox/jquery.fancybox-1.3.0.js"></script>
<script type="text/javascript" src="js/jquery.tipsy.js"></script>
<script type="text/javascript" src="js/custom_blue.js"></script>

</head>
<body>
<div class="content_wrapper">
    <cfinclude template="/includes/include_pageHeader.cfm">	
    <cfinclude template="/includes/include_leftNav.cfm">
	
	<!-- Begin content -->
	<div id="content">
        <cfoutput>
        <div style="margin:10px 0px 0px 20px;"><strong>Last check: </strong>#dateformat(application.checkMessagesTS, "m/d/yyyy")# #timeformat(application.checkMessagesTS, "h:mm tt")#</div>
        <div style="margin:10px 0px 0px 20px;">(0) New messages</div>
		</cfoutput>
		<br class="clear"/><br class="clear"/>
		
		
		
	</div>
	<!-- End content -->
</div>
</body>
</html>