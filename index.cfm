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
<link href="/css/blue/screen.css" rel="stylesheet" type="text/css" media="all">
<link href="/css/blue/datepicker.css" rel="stylesheet" type="text/css" media="all">
<link href="/js/visualize/visualize.css" rel="stylesheet" type="text/css" media="all">
<link href="/js/jwysiwyg/jquery.wysiwyg.css" rel="stylesheet" type="text/css" media="all">
<link href="/js/fancybox/jquery.fancybox-1.3.0.css" rel="stylesheet" type="text/css" media="all">

<!--[if IE]>
	<link href="css/ie.css" rel="stylesheet" type="text/css" media="all">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<![endif]-->

<!-- Jquery and plugins -->
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.img.preload.js"></script>
<script type="text/javascript" src="/js/hint.js"></script>
<script type="text/javascript" src="/js/visualize/jquery.visualize.js"></script>
<script type="text/javascript" src="/js/jwysiwyg/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="/js/fancybox/jquery.fancybox-1.3.0.js"></script>
<script type="text/javascript" charset="utf-8"> 
$(function(){ 
    // find all the input elements with title attributes
    $('input[title!=""]').hint();
    $('#login_info').click(function(){
		$(this).fadeOut('fast');
	});
});
</script>

<!---script>
	function updateShouts(){
	    // Assuming we have #shoutbox
	    //$('#shoutbox').load('latestShouts.php');
	    alert('Shout');
	}
	setInterval( "updateShouts()", 10000 );
</script--->


</head>
<body class="login">





	<!-- Begin login window -->
	<div id="login_wrapper">
        <cfif isdefined("errorMessage")>
        <cfoutput>            
		<div id="login_info" class="alert_warning noshadow" style="width:350px;margin:auto;padding:auto;text-align:center;">
			<p>#errorMessage#</p>
			<br class="clear"/><br/>
		</div>
        </cfoutput>
        </cfif>    
		<br class="clear"/>
        <!---cfif isdefined("session.remainingLoginAttempts") and session.remainingLoginAttempts NEQ 0--->        
		<div id="login_top_window">
			<img src="/images/blue/top_login_window.png" alt="top window"/>
		</div>
		<!-- Begin content -->
		<div id="login_body_window">
			<div class="inner">
				<form action="/dashboard.cfm" method="post" id="form_login" name="form_login">
					<p>
						<input type="text" id="username" name="j_username" style="width:285px" title="Username"/>
					</p>
					<p>
						<input type="password" id="password" name="j_password" style="width:285px" title="******"/>
					</p>
					<p style="margin-top:50px">
						<input type="submit" id="submit" name="submit" value="Login" class="Login" style="margin-right:5px"/>
						<!---input type="checkbox" id="remember" name="remember"/>Remember my password--->
					</p>
				</form>
			</div>
		</div>
		<!-- End content -->
		
		<div id="login_footer_window">
			<img src="/images/blue/footer_login_window.png" alt="footer window"/>
		</div>
		<div id="login_reflect">
			<img src="/images/blue/reflect.png" alt="window reflect"/>
		</div>
        <!---/cfif--->        
	</div>
	<!-- End login window -->
	
</body>
</html>
