<cfset getDefaultNumber = application.orgs.getDefaultNumber(session.orgid)>
<cfset getOrgNumbers = application.orgs.getNumbers(session.orgid)>

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

        <!--- Incoming messages --->
		<script type="text/javascript" charset="utf-8">
			/* Formating function for row details */
			function fnFormatDetails ( iTable, nTr )
			{
			    var aData = iTable.fnGetData( nTr );
			    var sOut = '<table cellpadding="5" cellspacing="0" border="0" cellpadding="0" style="padding-left:50px;" width="100%">';
			    sOut += '<tr><td><strong>Message</strong>:<br />'+aData[6]+'<br />Sid:('+aData[7]+')<br />Uri:('+aData[8]+')</td></tr>';
			    //sOut += '<tr><td><strong>Message</strong>:<br />'+aData[6]+'</td></tr>';			    
			    sOut += '</table>';
			     
			    return sOut;
			}

			$(document).ready(function() {

			    /*
			     * Initialse DataTables, with no sorting on the 'details' column
			     */

                /* Incoming table */
                  var iTable = $('#table_messages').dataTable({					
        			"aoColumnDefs": [
			            { "bSortable": false, "aTargets": [ 0 ] }
			        ],
			        "aaSorting": [[2, "desc"]],					
			        "bProcessing": true,
                    "bServerSide": false,
                    "bStateSave": false,	
                    "oLanguage": {
                        "sSearch": "Search all columns:"
                        },
                    "bSort": true,
                    "bPaginate": true,
                    "sPaginationType": "full_numbers",
          <cfoutput>"sAjaxSource": "/model/act_ajaxGetMessages.cfm?number=#getDefaultNumber#"</cfoutput>			        
			    });
			    
			    /* Add event listener for opening and closing details
			     * Note that the indicator for showing which row is open is not controlled by DataTables,
			     * rather it is done here
			     */
          $('#table_messages tbody td img').live('click', function () {			    	
			        var nTr = $(this).parents('tr')[0];
			        if ( iTable.fnIsOpen(nTr) )
			        {
			            /* This row is already open - close it */
			            this.src = "/images/details_open.png";
			            iTable.fnClose( nTr );
			        }
			        else
			        {
			            /* Open this row */
			            this.src = "/images/details_close.png";
			            iTable.fnOpen( nTr, fnFormatDetails(iTable, nTr), 'details' );
			        }
			    } );			    
				     			    
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
            <div id="techNotes" style="margin:10px 0px 0px 10px;">
				<strong>Tech note:</strong> 
	            <ul>
	                <li>Add popup modal? when chatting with an invidivual
	            </ul>
            </div>
            
			<!-- Begin one column tab content window -->
			<div class="onecolumn">
				<div class="header">
					<span>Messages <cfoutput>(#getDefaultNumber#)</cfoutput></span>
				</div>
				<br class="clear"/>
				<div class="content" style="display:block;">

                <!--- table start --->
				<table class="data" id="table_messages" width="100%" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<!---th style="width:5%"></th--->
							<th style="width:15%">From</th>
							<th style="width:43%">Message</th>                                     
							<th style="width:12%">Date</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
					<tfoot>
						<tr>
							<!---th style="width:5%"></th--->
							<th style="width:10%">From</th>
							<th style="width:43%">Message</th>                                     
							<th style="width:12%">Date</th>
						</tr>
					</tfoot>
				</table>
				<div id="chart_wrapper" class="chart_wrapper"></div>
				<!-- End bar chart table-->
	            <br class="clear"/>                    
                <!--- table end --->

				</div>
			</div>
			<!-- End one column tab content window -->

        </div>
    </div>
</div>        
        
    </body>
</html>