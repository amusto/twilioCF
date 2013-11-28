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
			/*@import "/css/datatables/demo_page.css";*/
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
    
            <!---div id="contactsHeader" style="float:left; width:100%;">
            <input type="button" id="btn_modalNewContact" value="Create a contact"/>
            </div--->
            <div id="contactsHeader" style="float:left; width:100%;">
            <a href="/display/dsp_createContact.cfm"><input type="button" id="btn_createContact" value="Create a contact"/></a>
            </div>            
    
		<div class="inner">
            
			<!-- Begin one column window -->
			<div class="onecolumn">
				<div class="header">
					<span>Contacts</span>
				</div>
				<br class="clear"/>
				<div class="content">

					<form id="form_data" name="form_data" action="" method="post">
						<table class="data" id="table_contacts" width="100%" cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<th style="width:5%;"><input type="checkbox" id="check_all" name="check_all"/></th>
								<th style="width:20%;">Name</th>
								<th style="width:5%;">PropID</th>
								<th style="width:5%;">Bldg/Section</th>
								<th style="width:5%;">Unit</th> 
								<th style="width:10%;">Phone</th>                                                                       
								<th style="width:20%;">Email</th>
								<th style="width:10%;">Date</th>
							</tr>
						</thead>
						<tbody>
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