<cfset getUsers = application.users.getUsers()>
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
            <div id="contactsHeader" style="float:left; width:100%;">
            <a href="/display/dsp_createGroup.cfm"><input type="button" value="Create a group"/></a>
            </div>

		<div class="inner">
			<!-- Begin one column window -->
			<div class="onecolumn">
				<div class="header">
					<span>Current groups</span>
				</div>
				<br class="clear"/>
				<div class="content">
					<form id="form_data" name="form_data" action="" method="post">
						<table class="data" width="100%" cellpadding="0" cellspacing="0">
							<thead>
								<tr>
									<th style="width:55%">Name</th>
									<th style="width:10%" align="left">Date</th>
									<th style="width:5%" align="right">Action</th>
								</tr>
							</thead>
							<tbody>
                                <cfoutput query="getGroups"> 
                                <CFSET MYDATETIME = #DateFormat("#ts#", "mm/dd/yyyy")# & " " & #TimeFormat("#ts#", "h:mm tt")#>                               
								<tr>
									<td><a href="/display/DSP_reviewGroup.cfm?groupId=#id#"> #groupName#</a></td>
									<td align="center">#MYDATETIME#</td>
									<td align="right"><a href="/model/act_updateGroup.cfm?action=deleteGroup&groupId=#id#"><img src="/images/icon_delete.png" alt="delete" class="help" title="Delete"/></a></td>
								</tr>
                                </cfoutput>
							</tbody>
						</table>
						<div id="chart_wrapper" class="chart_wrapper"></div>
					<!-- End bar chart table-->
					</form>
					
					
				</div>
			</div>
			<!-- End one column window -->
			<br class="clear"/>
		
	</div>
	<!-- End content -->
</div>
</body>
</html>