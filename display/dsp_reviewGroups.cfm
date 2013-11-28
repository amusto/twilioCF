<cfset getGroups = application.contacts.getGroups(session.userId)>

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
<link href="/css/tipsy.css" rel="stylesheet" type="text/css" media="all">
<link href="/js/visualize/visualize.css" rel="stylesheet" type="text/css" media="all">
<link href="/js/jwysiwyg/jquery.wysiwyg.css" rel="stylesheet" type="text/css" media="all">
<link href="/js/fancybox/jquery.fancybox-1.3.0.css" rel="stylesheet" type="text/css" media="all">
<link href="/css/tipsy.css" rel="stylesheet" type="text/css" media="all">

<!--[if IE]>
	<link href="/css/ie.css" rel="stylesheet" type="text/css" media="all">
	<script type="text/javascript" src="js/excanvas.js"></script>
<![endif]-->

<!-- Jquery and plugins -->
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.img.preload.js"></script>
<script type="text/javascript" src="/js/hint.js"></script>
<script type="text/javascript" src="/js/visualize/jquery.visualize.js"></script>
<script type="text/javascript" src="/js/jwysiwyg/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="/js/fancybox/jquery.fancybox-1.3.0.js"></script>
<script type="text/javascript" src="/js/jquery.tipsy.js"></script>
<script type="text/javascript" src="/js/custom_blue.js"></script>

</head>
<body>
<div class="content_wrapper">
    <cfinclude template="/includes/include_pageHeader.cfm">

    <cfinclude template="/includes/include_leftNav.cfm">	

	<!-- Begin content -->
	<div id="content">
		<div class="inner">
			<h1>Groups</h1>
			
			<!-- Begin one column window -->
			<div class="onecolumn">
				<div class="header">
					<span>My Groups</span>
				</div>
				<br class="clear"/>
				<div class="content">
                <cfif getGroups.recordcount GT 0>
					<form id="form_data" name="form_data" action="" method="post">
						<table class="data" width="100%" cellpadding="0" cellspacing="0">
							<thead>
								<tr>
									<th style="width:10px">
										<input type="checkbox" id="check_all" name="check_all"/>
									</th>
									<th style="width:30%">Name</th>
									<th style="width:20%">Email</th>
									<th style="width:30%">Date</th>
									<th style="width:15%"></th>
								</tr>
							</thead>
							<tbody>
                                <cfoutput query="getGroups"> 
                                <CFSET MYDATETIME = #DateFormat("#Now()#", "mm/dd/yyyy")# & " " & #TimeFormat("#Now()#", "h:mm tt")#>                               
								<tr>
									<td>
										<input type="checkbox"/>
									</td>
									<td>#lastname#, #firstname# (#username#)</td>
									<td><a href="mailto:#email#">#email#</a></td>
									<td>#MYDATETIME#</td>
									<td>
										<a href="/modal_window.html" id="shortcutEdit" title="Click me to open modal window"><img src="/images/icon_edit.png" alt="edit" class="help" title="Edit"/></a>
										<a href=""><img src="/images/icon_delete.png" alt="delete" class="help" title="Delete"/></a>
									</td>
								</tr>
                                </cfoutput>
							</tbody>
						</table>
						<div id="chart_wrapper" class="chart_wrapper"></div>
					<!-- End bar chart table-->
					</form>
                <cfelse>
						<div class="alert_warning" style="margin-top:0">
							<p>
								<img src="/images/icon_warning.png" alt="success" class="mid_align"/>
								Currently you do not have any groups created, please create a group to get started.<br />
							</p>
						</div>
                            <div id="createAGroup" style="margin:5px 0px 0px 10px;"><strong><a href="dsp_createGroup.cfm">Create a group now!</a></strong></div>
                </cfif>
				</div>
			</div>
			<!-- End one column window -->
			<br class="clear"/>
		
	</div>
	<!-- End content -->
</div>
</body>
</html>