<cfset queryParameters = structnew()>
<cfset queryParameters.iDisplayLength = 0>
<cfset getContacts = application.contacts.getContacts(queryparameters:queryParameters)>
<cfset getGroups = application.contacts.getGroups(session.userId)>

<cfset getUser = application.users.getUser(session.userId)>
<cfset getNumbers = application.orgs.getNumbers(getUser.orgid)>
<cfset getDefaultNumber = application.orgs.getDefaultNumber(getUser.orgid)>

<cfset ApiVersion = REQUEST.ApiVersion/>
<!--- get these 3 values from you twilio account --->
<cfset AccountSid = REQUEST.AccountSid/>
<cfset AuthToken = REQUEST.AuthToken/>

<cffile action="read" file="/model/api.twilio.com.xml" variable="wadl" />
<cfset wadl = XmlParse(wadl) />

<cfset categories = StructNew() />

<cfset resource = wadl.application.resources.resource[8]/>
<cfoutput>
	<cfset id = createUUID() />
</cfoutput>

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
<link rel="stylesheet" href="/css/formValidationStyle.css" type="text/css" media="screen">
<!---link href="/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/css/multi-select.css" media="screen" rel="stylesheet" type="text/css" /--->

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
<script src="/js/characterCount/jquery.textareaCounter.plugin.js" type="text/javascript"></script>
<script type="text/javascript">
	var info;
    var counter = 2;
	$(document).ready(function(){
		var options = {
				'maxCharacterSize': 160,
				'originalStyle': 'originalTextareaInfo',
				'warningStyle' : 'warningTextareaInfo',
				'warningNumber': 20,
				'displayFormat' : '#left Characters Left / #max'
		};
		$('#textAreaMessage').textareaCount(options, function(data){
   		$('#showData').html(data.input + " characters input. | " + data.left + " characters left.");
			if(data.input > 159 && !$('textarea#textMessage'+counter).is('*')){
    			addNewBox('test');

			}
			else if(data.input > 159 && $('textarea#textMessage'+counter-1).is('*')){
    			alert('Check box for count');
			}	    						    		
			
		});
	});
	
 
	function addNewBox(){
		
		var newTextBoxDiv = $(document.createElement('div'))
			     .attr("id", 'TextBoxDiv' + counter);
		 
			newTextBoxDiv.after().html('<label>Message '+ counter + '/x: </label><br />' +
			      '<textarea name="textMessage' + counter + 
			      '" id="textMessage' + counter + '" cols="250" rows="4" style="width:600px" ></textarea>');
		 
			newTextBoxDiv.appendTo("#TextBoxesGroup");
            $('textarea#textMessage'+counter).focus();
	
            counter++;	
	
	}

</script>

	<cfscript>
		timeStruct = structNew();
		timeStruct.startDate = dateformat(now(), "mm/dd/yy");
	</cfscript>
</head>
<body>

<div class="content_wrapper">
    <cfinclude template="/includes/include_pageHeader.cfm">	
    <cfinclude template="/includes/include_leftNav.cfm">	

	<!-- Begin content -->
	<div id="content">
		<div class="inner">
			
			<!-- Begin Send Message window -->
			<div class="onecolumn">
					<div class="header">
						<span>Send a Message</span>
					</div>
                    
					<br class="clear"/>
					<div class="content">
                        <cfif isdefined("application.smsAppMode") and application.smsAppMode EQ "Development">
	                        <div id="devModeMessage" style="float:right; color:red;">
	                            <strong>Development mode</strong>
	                            (Safe list only)          
	                        </div>
                        <cfelse>
	                        <div id="devModeMessage" style="float:right; color:green;">
	                            <strong>Production mode</strong>
	                        </div>                        
                        </cfif>
				        <form action="/model/act_sendMessage.cfm" method="post" id="form_sendMessage" name="form_sendMessage">
                                                    
                        <!---div id="sendMessageName" style="float:left; width:100%; padding:0px 0px 30px 0px;">
							<label><strong>Name</strong></label><br />
                               <input type="text" id="messagename" name="messagename" value="" size="100" style="width:350px; height:30px;"/>
                        </div--->

                        <script>
                            function activateFrom(target) {
								var t = document.getElementById("contactList_group");
								var selectedText = t.options[t.selectedIndex].text;
                                alert("Sending to "+selectedText.toUpperCase()+" Group");								                                
                            }
                        </script>

                        <div id="sendToGroup" style="float:left; width:100%; padding:0px 0px 30px 0px;">
                            <div id="sendToNotes">
                                <strong>1. Select a group or enter a list of numbers (eg: 202-222-2222, 202-111-1111)</strong>                                
                            </div>
  
                            <div style="float:left; margin:0px 0px 0px 10px;">                            
							<label><strong>Group</strong></label><br />
	                        <select id="contactList_group" name="contactList_group" onChange="activateFrom();">
                                   <option value="0">Select a group
	                            <cfoutput query="getGroups">
	                                <option value="#id#">#groupName#                                
	                            </cfoutput>        
	                        </select>
                            </div>

                            <div id="OR" style="float:left; width:50px; margin:25px 0px 0px 0px; text-align:center;"><strong>OR</strong></div>

                            <div style="float:left;">                            
							<label><strong>Single</strong></label><br />
                               <input type="text" id="messageTo" name="messageTo" value="" size="100" style="width:350px; height:30px;"/>
                            </div>                            
                            
                        </div>                                                    

                        <!---div id="sendToSingle" style="float:left; width:100%; padding:0px 0px 30px 0px;">
                            <!---div style="float:left;">
                            <input type="radio" id="fromType" name="fromType" value="single" checked>
                            </div--->
                            <div style="float:left;">                            
							<label><strong>Single</strong></label><br />
                               <input type="text" id="messageTo" name="messageTo" value="" size="100" style="width:350px; height:30px;"/>
                            </div>
                        </div---->                                                    
                                                    
                        <!---div id="selectSendTo" style="float:left; width:100%; padding:0px 0px 30px 0px;">                                                    

	                        <div id="sendMessageName" style="float:left; width:400px;">
								<label><strong>Name</strong></label><br />
                                <input type="text" id="messageName" name="messageName" value="" size="100" style="width:350px; height:30px;"/>
	                        </div>

	                        <div id="sendToGroup" style="float:left;">
								<label><strong>Group</strong></label><br />
		                        <select name="contactList_group">
                                    <option value="0">Select a group
		                            <cfoutput query="getGroups">
		                                <option value="#id#">#groupName#                                
		                            </cfoutput>        
		                        </select>
	                        </div>

	                        <!---div id="OR" style="float:left; margin:0px 0px 0px 20px;">
                                <strong>- OR -</strong>
                            </div>

	                        <div id="sendToSingle" style="float:left; margin:0px 0px 0px 20px;">                            
								<label><strong>Send to single number</strong></label> 
								<input type="text" id="messageSendNumber" name="contactList_single" value="" style="width:200px; height:30px;"/>
                            </div>

	                        <div id="OR" style="float:left; margin:0px 0px 0px 20px;">
                                <strong>- OR -</strong>
                            </div--->
                          
                        </div--->

						<div style="float:left; width:100%; padding:0px 0px 30px 0px;">
							<label><strong>2.</strong>Send from number</label><br /> 
	                        <select name="from" style="margin:0px 0px 0px 10px;">
                                <cfoutput query="getNumbers">
	                            <option value="#number#" <cfif number EQ getDefaultNumber>selected</cfif>>+1 #number#
                                </cfoutput>
	                        </select>
						</div>                                                                            						


						<div style="float:left; width:100%; padding:0px 0px 0px 0px;">
							<div id='TextBoxesGroup' style="float:left; width:100%; padding:0px 0px 0px 0px;">
							    <!---div id="showData"></div--->                            
								<label><strong>3. Message</strong></label><br />
			      				<textarea name="body" id="textAreaMessage" cols="250" rows="4" style="width:600px; margin:0px 0px 0px 10px;"></textarea>                            
								<div id="TextBoxDiv1">                                   
								</div>
							</div>                                                
						</div>
                        
                        <p>
                            <input type="submit" value="Send message now" class="Login"/>
                        </p>
                            
                        </form>                                                
                        
<!---
				        <form action="/model/act_sendMessage.cfm" method="post" id="form_sendMessage" name="form_sendMessage">
                                                   
                        <strong>1. SELECT GROUP</strong><br /><br />                                                    

                        <div id="selectGroup">
                            <cfoutput query="getGroups">
                                <option value="#id#">#groupName#                                
                            </cfoutput>          
                        </div>

                       <!---div id="section_selectContacts">
				        <div class='span12'>
				          <select multiple id="searchable" name="searchable[]">
				              <cfoutput query="getContacts">
				                  <option value="#id#">#lastName#, #firstName#
				              </cfoutput>
				          </select>
				        </div--->
                    
                    <div id="section_message" style="float:left; width:80%; margin:20px 0px 0px 0px;">
                    <strong>2. CREATE MESSAGE</strong><br /><br />	
					<p>
						<label>From:</label> 
                        <select name="from">
                            <option value="+12024997430">+12024997430
                        </select>
					</p>                                                                            						
					<!---p>
						<label>To: (Send to single number)</label> 
						<input type="text" id="messageSendNumber" name="to" value="2029976078" style="width:300px"/>
					</p>
					<br/--->
					<p>
						<label>Message:</label>
	      					<textarea name="body" cols="250" rows="10" style="width:600px"></textarea>
					</p>
					<p>
						<label>Status Callback: (optional)</label><br/>
						<input type="text" id="StatusCallback" name="StatusCallback" value="" style="width:300px"/>
					</p>
                    <div id="formActionRow" style="margin-top:10px; float:left;">
                        <input type="submit" value="Send Now" class="Login" style="margin-right:5px; float:left"/><br /><br /><br />
						<!---input type="submit" value="Save Message" class="Login" style="margin-right:5px; float:left"/--->
                        <br /><br /><br />
                        <!---
                        Schedule a date<br />
                        <cfoutput>
                        <input type="text" name="scheduleDate" class="datepicker" value="#timeStruct.startDate#" style="width:100px; height:30px;"><input type="text" name="scheduleTime" value="" style="width:100px; height:30px;"><br />
                        </cfoutput> 
                        <input type="submit" value="Schedule" class="Login" style="margin-right:5px;"/>
						<script type="text/javascript">
						    $(document).ready(function(){
						        $('input[name="scheduleTime"]').ptTimeSelect();						        
						    });
						</script>
                        </--->                        
                                                
                    </div>

                </form>
				<!-- End left column window -->
			<br class="clear"/--->
                

	</div>
	<!-- End content -->
</div>

<script type="text/javascript" src="/js/jqueryFormValidate.js" charset="utf-8"></script>


</body>
</html>