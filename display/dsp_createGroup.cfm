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

<!--- Datatable code --->
		<style type="text/css" title="currentStyle">
			@import "/css/datatables/demo_table.css";
		</style>
		<script type="text/javascript" language="javascript" src="/js/datatables/jquery.dataTables.js"></script>
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				var oTable = $('#table_contacts').dataTable({
					"aoColumns": [
					      { "bSortable": false },
					      null,
					      null,
					      null,
					      null,					      
					      null
					    ],					
			        "bProcessing": true,
                    "bServerSide": false,
                    "bStateSave": true,	
                    "oLanguage": {
                        "sSearch": "Search all columns:"
                        },
                    "sDom":'lf<"top">rtp<"bottom">',                        
                    "bSort": true,
                    "bPaginate": true,
                    "sPaginationType": "full_numbers",
			        "sAjaxSource": "/model/act_ajaxGetContacts.cfm"			        
			    });
			} );
		</script>

</head>
<body>
<div class="content_wrapper">
    <cfinclude template="/includes/include_pageHeader.cfm">
    <cfinclude template="/includes/include_leftNav.cfm">	

	<!-- Begin content -->
	<div id="content">
		<div class="inner">    

			<!-- Begin one column window -->
			<div class="onecolumn">
				<div class="header">
					<span>Create a group</span>
				</div>
				<br class="clear"/>
				<div class="content">
                
					<form id="form_data" name="form_data" action="/model/act_createGroup.cfm" method="post">

						<div id="groupName" style="margin:10px">
							<label>1. Enter a name for this group</label><br/>
							<input type="text" id="groupName" name="groupName" style="width:300px" value=""/>
						</div>

						<div id="groupContacts" style="margin:10px">
							<label>2. Select contacts for this group</label><br/>
							<table id="table_contacts" class="data" width="100%" cellpadding="0" cellspacing="0">
								<thead>
									<tr>
										<th style="width:10px">
											<input type="checkbox" id="check_all" name="check_all"/>
										</th>
										<th style="width:250px;">Name</th>
										<th style="width:50px;">Unit</th>
										<th style="width:30%">Cell</th>
										<th style="width:15%">Email</th>
										<th style="width:15%">Created</th>                                    
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
                        </div>

						<div id="tableFooterRow" style="margin:10px">
							<input type="submit" value="Submit"/>
						</div>
                    
					</form>
					
					<!-- Begin pagination -->
						<!---div class="pagination">
							<a href="#">«</a>
							<a href="#" class="active">1</a>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>
							<a href="#">5</a>
							<a href="#">6</a>
							<a href="#">»</a>
						</div--->
					<!-- End pagination -->
					
				</div>
			</div>
			<!-- End one column window -->




		<!---div class="inner">
			<h1>Groups</h1>
			
			<!-- Begin one column window -->
			<div class="onecolumn">
				<div class="header">
					<span>Create a group</span>
				</div>
				<br class="clear"/>
				<div class="content">

                    <form action="" method="post">
						<div id="groupName" style="margin:10px">
							<label>1. Enter a name for this group</label><br/>
							<input type="text" id="groupName" style="width:300px" value=""/>
						</div>

                        <div id="contactsTable" style="margin:30px 0px 0px 0px;">
                            <strong>2. Select contacts for your group</strong>
							<table class="data" id="table_groups" width="100%" cellpadding="0" cellspacing="0">
								<thead>
									<tr>
										<th style="width:10px">
											<input type="checkbox" id="check_all" name="check_all"/>
										</th>
										<th style="width:60%">Name</th>
										<th style="width:20%">Unit</th>
										<th style="width:20%">Cell</th>                                        
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>                            
                        </div>

						<p>
							<input type="button" id="btn_submit" value="Create group"/>
						</p>
                    
                    </form>                    
                    
                    
				</div>
			</div>
			<!-- End one column window -->
			<br class="clear"/--->
		
	</div>
	<!-- End content -->
</div>
</body>
</html>