<cfcomponent name="Application" output="false" >
	
	<!--- set application name based on the directory path --->
	<cfset this.name = "SMS Management System" />
    <cfset this.applicationTimeout = createTimeSpan(0,4,0,0)>
    <cfset this.sessionManagement = true>
    <cfset This.loginstorage="session">     
	<cfset this.sessionTimeout = createTimeSpan(0,4,0,0)>

	<cfset REQUEST.AccountSid = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/>
	<cfset REQUEST.AuthToken = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/>
	<cfset REQUEST.ApiVersion = "2010-04-01"/>
	<cfset REQUEST.ApiEndpoint = "api.twilio.com"/>
    
	<cffunction name="OnApplicationStart">
	
        <cfset application.siteTitle = "SMS MGMT">
	    <cfset application.datasource = "smsmgmt"/>
                    
	    <cfset application.sms = createobject("component", "twilioClasses.sms")>                            
	    <cfset application.contacts = createobject("component", "twilioClasses.contacts")>
	    <cfset application.messages = createobject("component", "twilioClasses.messages")>                    
	    <cfset application.users = createobject("component", "twilioClasses.users")>                    
	    <cfset application.orgs = createobject("component", "twilioClasses.orgs")>                    

        <cfset application.loginAttemptsAllowed = 3>
        <cfset session.remainingLoginAttempts = application.loginAttemptsAllowed>        

        <!--- Create Twilio object --->
		<cfset left = "<" />
		<cfset right = ">" />
		
		<!--- Create a new instance of the Twilio Lib, this can be stored in the App scope or elsewhere as a singleton... --->
		<cfset application.TwilioLib = createObject("component", "twilio.TwilioLib").init(REQUEST.AccountSid, REQUEST.AuthToken, REQUEST.ApiVersion, REQUEST.ApiEndpoint) />        
        <cfset application.safeList = "1573,1577,1578,1579">

        <cfset application.checkMessagesTS = "">        
        
    </cffunction>

	<cffunction name="OnRequestStart">
	    <cfset application.sms = createobject("component", "twilioClasses.sms")>
	    <cfset application.contacts = createobject("component", "twilioClasses.contacts")>
	    <cfset application.messages = createobject("component", "twilioClasses.messages")>
	    <cfset application.users = createobject("component", "twilioClasses.users")>
	    <cfset application.orgs = createobject("component", "twilioClasses.orgs")>
                                        
		<!--- Create a new instance of the Twilio Lib, this can be stored in the App scope or elsewhere as a singleton... --->
		<!---cfset application.TwilioLib = createObject("component", "twilio.TwilioLib").init(REQUEST.AccountSid, REQUEST.AuthToken, REQUEST.ApiVersion, REQUEST.ApiEndpoint) /--->
        <cfset application.smsAppMode = "Production">
        <cfset application.safeList = "1573,1577,1578,1579">

	    <script src="http://code.jquery.com/jquery-1.8.0.js" type="text/javascript"></script>
	    <script src="/js/bootstrap.js" type="text/javascript"></script>
	    <script src="/js/jquery-ui.js" type="text/javascript"></script>
	    <script src="/js/jquery.tinysort.js" type="text/javascript"></script>
	    <script src="/js/jquery.quicksearch.js" type="text/javascript"></script>
	    <script src="/js/jquery.multi-select.js" type="text/javascript"></script>
	    <script src="/js/rainbow.js" type="text/javascript"></script>
	    <script src="/js/application.js" type="text/javascript"></script>
                                                                     
	    <cfargument name = "request" required="true"/> 
	    <cfif IsDefined("url.logout")> 
	        <cflogout> 
	    </cfif> 


		<!--- Allow access if this is the checkMessagesTask --->
		<cfif cgi.script_name NEQ "/scheduled/checkMessages.cfm">

			<!--- Run normal login check --->     
		    <cflogin>
		        <cfif NOT IsDefined("cflogin")> 
		            <cfinclude template="index.cfm"> 
		            <cfabort> 
		        <cfelse>
		            <cfif cflogin.name IS "" OR cflogin.password IS ""> 
	                    <cfset errorMessage = "You must enter text in both the User Name and Password fields.">                                                        
		                <cfinclude template="index.cfm"> 
		                <cfabort> 
		            <cfelse> 
		                <!---cfquery name="updateUsersPasswordHash" dataSource="#application.datasource#"> 
			                update users
	                            set passwordHash = <cfqueryparam cfsqltype="cf_sql_varchar" value="#passwordHash#"> 
			                    WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.j_username#">
		                </cfquery---> 
	                    <!--- User Status
	                        0 = inactive
	                        1 = active
	                     --->
		                <cfquery name="loginQuery" dataSource="#application.datasource#"> 
							SELECT u.id, u.firstname, u.username, u.email, o.safe_list, u.orgId, u.role, u.status, o.name orgName from users u
							join organizations o on o.id=u.orgId
			                WHERE u.username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.j_username#">
	                        and u.passwordHash = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(form.j_password)#">
		                </cfquery> 
	
	                    <!--- User NOT logged in --->
		                <cfif loginQuery.recordcount LT 1 OR loginQuery.status EQ 0>
	                        <cfif not isdefined("session.remainingLoginAttempts")>
	                            <cfset session.remainingLoginAttempts = application.loginAttemptsAllowed-1>
	                        <cfelse>
	                            <cfif loginQuery.status EQ 0>
		        	                    <cfset errorMessage = "Your account is disabled.">                                
	                            <cfelse>
		                            <cfif session.remainingLoginAttempts NEQ 0>
		                                <cfset session.remainingLoginAttempts = session.remainingLoginAttempts-1>
		        	                    <cfset errorMessage = "Your username and password combination is incorrect. You have #session.remainingLoginAttempts# more tries before you are locked out.">                                
		                            <cfelse>
		        	                    <cfset errorMessage = "Your account is locked.">                            
		                            </cfif>                            
	                            </cfif>                        
	                        </cfif>                                                                        
			                <cfinclude template="index.cfm"> 
			                <cfabort>	                
	                    <cfelse>
	                    <!--- User logged in --->
	                        <cfset StructDelete(Session, "remainingLoginAttempts")>
	                        <cfset session.userId = loginQuery.id>
	                        <cfset session.orgId = loginQuery.orgId>
	                        <cfset session.orgName = loginQuery.orgName>
	                        <cfset session.firstname = loginQuery.firstname>                        
	                        <cfset session.roleId = loginQuery.role>                                                
	                        <cfset session.safelist = loginQuery.safe_list>                        
	    	                <cfloginuser name="armando" Password = "#hash(form.j_password)#" roles="0">
	                    </cfif>
		            </cfif>     
		        </cfif> 
		    </cflogin> 

        </cfif>
	 
	</cffunction> 

	
</cfcomponent>
