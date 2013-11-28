<cfset getUser = application.users.getUser(session.userId)>
<cfset getOrgNumbers = application.orgs.getNumbers(getUser.orgid)>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 

<script>
	$(document).ready(function() {
	
	    $('.internal').hide();
	
	    $('.slider').click(function() {
	        $(this).next('.internal').slideToggle();
	    }).toggle(function() {
	        $(this).children("span").text("[-]");
	    }, function() {
	        $(this).children("span").text("[+]");
	    });
	
	});
</script>
 
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
<script type="text/javascript" src="/js/drilldownselect/jquery.cookie.js"></script>

</head>
<body>
<div class="content_wrapper">
    <cfinclude template="/includes/include_pageHeader.cfm">	
    <cfinclude template="/includes/include_leftNav.cfm">	

	<!-- Begin content -->
	<div id="content">
		<div class="inner">
	
   			<!-- Begin one column tab content window -->
			<div class="onecolumn">
				<div class="header">
					<span>My Settings</span>
					<div class="switch" style="width:150px">
						<table width="150px" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td>
									<input type="button" id="tab1" name="tab1" class="left_switch active" value="General" style="width:70px"/>
								</td>
								<td>
									<input type="button" id="tab2" name="tab2" class="middle_switch" value="Global" style="width:50px"/>
								</td>
								<td>
									<input type="button" id="tab3" name="tab3" class="right_switch" value="Tab3" style="width:50px"/>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
				</div>
				<br class="clear"/>
				<div class="content">
					<div id="tab1_content" class="tab_content">
						<h4>Org: <cfoutput>#getUser.organizationName#</cfoutput></h4>
                       
                        <form action="/model/act_settingsGeneral.cfm" method="post">
            			<div style="float:left; width:100%; margin:0px 0px 10px 0px;">                            
	            			<div style="float:left;">
								<strong>First name</strong><br />
                                <cfoutput>
	                            <input type="text" name="firstname" id="firstname" value="#getUser.firstname#" style="width:265px;">
                                </cfoutput>                                                                                      
							</div>
	
	            			<div style="float:left; margin:0px 0px 0px 20px;">
								<strong>Last name</strong><br />
                                <cfoutput>
	                            <input type="text" name="lastname" id="lastname" value="#getUser.lastname#" style="width:265px;">
                                </cfoutput>                                                                                      
							</div>
                        </div>
                        
            			<div style="float:left; width:100%; margin:0px 0px 10px 0px;">                            
	            			<div style="float:left;">
								<strong>Username</strong><br />
                                <cfoutput>
	                            <input type="text" name="username" id="username" value="#getUser.username#" style="width:265px;">
                                </cfoutput>                                                                                                                    
							</div>
	
	            			<div style="float:left; margin:0px 0px 0px 20px;">
								<strong>Email</strong><br />
                                <cfoutput>
	                            <input type="text" name="email" id="email" value="#getUser.email#" style="width:265px;">
                                </cfoutput>
							</div>
                        </div>

						<div class="slider"><span>+</span><a href="#"> <strong>Change Password</strong></a></div>
						<div class="internal" style="float:left; width:100%; margin:0px 0px 10px 0px;">
	            			<div style="float:left;">
								<strong>New Password</strong><br />
	                            <input type="password" name="newPassword" id="newPassword" value="" style="width:265px;">
							</div>
	
	            			<div style="float:left; margin:0px 0px 0px 20px;">
								<strong>Confirm Password</strong><br />
	                            <input type="password" name="confirmPassword" id="confirmPassword" value="" style="width:265px;">
							</div>
						</div>

            			<div style="float:left; width:100%; margin:0px 0px 10px 0px;">                            
	            			<div style="float:left;">
								<strong>Phone</strong><br />
                                <cfoutput>
	                            <input type="text" name="phone" id="phone" value="#getUser.phone#" style="width:265px;">
                                </cfoutput>                                                                                      
							</div>
    
	            			<div style="float:left; margin:0px 0px 0px 20px;">
								<strong>Default number</strong><br />
                                <select name="defaultNumber">
                                    <cfoutput query="getOrgNumbers">
                                    <option value="#id#" <cfif active EQ 1>selected</cfif>>#number#
                                    </cfoutput>                                
                                </select>
							</div>
                        </div>                        

            			<div style="float:left; width:100%; margin:0px 0px 10px 0px;">                            
	            			<div style="float:left;">
	                            <input type="submit" value="Update">
    						</div>
                        </div>                        
                        </form>
                        
                        <br class="clear"/>                        
					</div>
					<div id="tab2_content" class="tab_content hide">
						<h4>Global</h4>
            			<p>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in porta lectus. Maecenas dignissim enim quis ipsum 
							mattis aliquet. Maecenas id velit et elit gravida bibendum. Duis nec rutrum lorem. Donec egestas metus a risus 
							euismod ultricies. Maecenas lacinia orci at neque commodo commodo. Donec egestas metus a risus 
							euismod ultricies. 
						</p>
	  					<br class="clear"/>
					</div>
					<div id="tab3_content" class="tab_content hide">
						<div class="alert_success">
							<p>
								<img src="/images/icon_accept.png" alt="success" class="mid_align"/>
								Successfully display tab 3
							</p>
						</div>
            			<p>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in porta lectus. Maecenas dignissim enim quis ipsum 
							mattis aliquet. Maecenas id velit et elit gravida bibendum. Duis nec rutrum lorem. Donec egestas metus a risus 
							euismod ultricies. Maecenas lacinia orci at neque commodo commodo. Donec egestas metus a risus 
							euismod ultricies. 
						</p>
					</div>
				</div>
			</div>
			<!-- End one column tab content window -->
    
	<!-- End content -->
</div>
</body>
</html>