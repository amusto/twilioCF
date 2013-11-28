<cfif form.body EQ "">
    Please go back (Use browser button) and correct errors
    <cfabort>
</cfif>

<!--- Do some prep if the contactList is sent - has more then a 0 recordcount --->
<cfset aContactList = arrayNew(1)>
<cfset aSendLog = arrayNew(1)>
<cfset session.sendMessageStatus = "">

<cfdump var="#form#">
<cfdump var="#session.userId#">


<!--- TODO: Change to a class --->
<!---cfquery name="dupeCheck" datasource="#application.datasource#">
    select count(id) messageCount from messages where message_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageName#">
</cfquery--->

<!---cfif dupeCheck.messageCount EQ 0>
	<cfquery name="addMessage" datasource="#application.datasource#">
	    insert into messages(message_name, message_body, message_sent_date, createdByUserId)
	        values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#messageName#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#body#">, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userId#">)
	</cfquery>
</cfif--->

<!--- Create a new structure that will hold the request parameters ---> 
<cfset rData = StructNew() /> 

<cfparam name="form.contactList_group" default="">
<cfparam name="form.messageTo" default="">

<cfif isdefined("form.contactList_group") and form.contactList_group NEQ 0>
    <cfset form.fromType = "group">
<cfelseif isdefined("form.messageTo") and form.messageTo NEQ "" and form.contactList_group EQ 0>
    <cfset form.fromType = "single">
</cfif>

<!--- Temp for now but allows us to send to single PHONE NUMBERS  --->
<cfif form.fromType EQ "single">

	<cfloop item="i" list="#form.messageTo#">                        
	    <cfset messageDetails = structNew()>
	    <cfset messageDetails.phone_cell = i>                        
	    <cfset arrayAppend(aSendLog, messageDetails)>        
	</cfloop>

<cfelseif form.fromType EQ "group">
	<!--- If we are in development mode, you can only sent to these users --->
	<cfif application.smsAppMode EQ "Development">
	    <!--- Check to make sure on Safelist --->
	    <!--- TODO: Change it so I can create safelist from a list, add into DB --->
		    <!---cfloop item="i" list="#application.safelist#"--->
		    <cfloop item="i" list="#application.users.getUser(session.userId).safe_list#">                        
		        <cfset qGetContact= application.contacts.getContactById(i)>
		
		        <cfset messageDetails = structNew()>
		        <cfset messageDetails.id = qGetContact.id>        
		        <cfset messageDetails.firstName = qGetContact.firstname>        
		        <cfset messageDetails.lastName = qGetContact.lastName>
		        <cfset messageDetails.email = qGetContact.email>
		        <cfset messageDetails.phone_cell = qGetContact.phone_cell>                        
		        <cfset messageDetails.property_id = qGetContact.property_id>        
		        <cfset messageDetails.building_id = qGetContact.building_id>
		        <cfset messageDetails.unit_id = qGetContact.unit_id>
		        <cfif not isValid("telephone", qGetContact.phone_cell)>
		            <cfset messageDetails.status = "Not valid">
		            <cfset messageDetails.statusDetails = "Missing or invalid cell number">
		        <cfelse>
			        <cfset messageDetails.status = "validContact">        
			        <cfset messageDetails.statusDetails = "Ready to send">                               
		        </cfif>        
		        <cfset arrayAppend(aSendLog, messageDetails)>        
		    </cfloop>
	<cfelse>
		<cfif isdefined("form.contactList_group") and form.contactList_group NEQ 0>
		    <cfset getGroupContacts = application.contacts.getGroup(session.userId,form.contactList_group)>
		    <cfloop item="i" list="#getGroupContacts.contactList#">
		        <cfset qGetContact= application.contacts.getContactById(i)>
		
		        <cfset messageDetails = structNew()>
		        <cfset messageDetails.id = qGetContact.id>        
		        <cfset messageDetails.firstName = qGetContact.firstname>        
		        <cfset messageDetails.lastName = qGetContact.lastName>
		        <cfset messageDetails.email = qGetContact.email>
		        <cfset messageDetails.phone_cell = qGetContact.phone_cell>                        
		        <cfset messageDetails.property_id = qGetContact.property_id>        
		        <cfset messageDetails.building_id = qGetContact.building_id>
		        <cfset messageDetails.unit_id = qGetContact.unit_id>
		        <cfif not isValid("telephone", qGetContact.phone_cell)>
		            <cfset messageDetails.status = "Not valid">
		            <cfset messageDetails.statusDetails = "Missing or invalid cell number">
		        <cfelse>
			        <cfset messageDetails.status = "validContact">        
			        <cfset messageDetails.statusDetails = "Ready to send">                               
		        </cfif>        
		        <cfset arrayAppend(aSendLog, messageDetails)>        
		    </cfloop>
		</cfif>
	</cfif>
</cfif>

<!--- Add all the parameters to the structure --->
<!---cfset rData.To =  2029976078/>
<cfset rData.Body = "test message Yo" />
<cfset rData.from =  "+1-202-803-7050"/>

<cfdump var="#rData#">
<cfset REQUEST.AccountSid = "AC56a6aae00ce4fff35e94bcc0d89ebee2"/>
<cfset requestObj = application.TwilioLib.newRequest("Accounts/#REQUEST.AccountSid#/SMS/Messages.xml", "POST", rData) /--->

<!---cffile action="read" file="/model/api.twilio.com.xml" variable="wadl" />
<cfset wadl = XmlParse(wadl) />

<cfset categories = StructNew() />
<cfset resource = wadl.application.resources.resource[8]/>

<cfset _accountsid = REQUEST.AccountSid />
<cfset _authtoken = request.authtoken />
<cfset left = "<" />
<cfset right = ">" />
<cfset FORM.format = "xml" />

<!--- Create a new instance of the Twilio Lib, this can be stored in the App scope or elsewhere as a singleton... --->
<cfset REQUEST.TwilioLib = createObject("component", "twilio.TwilioLib").init(_accountsid, _authtoken, REQUEST.ApiVersion, REQUEST.ApiEndpoint) />

<!--- Delete the fieldnames key from the struct... --->
<cfset StructDelete(FORM, "FieldNames") />
<cfset StructDelete(FORM, "accountsid") />
<cfset StructDelete(FORM, "authtoken") />
<cfset StructDelete(FORM, "resourceid") />
<cfset StructDelete(FORM, "defaultformat") />

<cfset resourceMethod = resource.method.XmlAttributes.Name/>
<cfset resourceUri = resource.XmlAttributes.Path/>

<cfif left(resourceUri, 1) EQ "/">
	<cfset resourceUri = "Accounts" & resourceUri/>
</cfif--->

<!--- First loop the resource replacing any of the placeholders with the correct values... --->
<!---cfloop collection="#form#" item="f">
	<cfif FindNoCase("{#f#}", resourceUri) AND len(trim(FORM[f]))>
		<cfset resourceUri = ReplaceNoCase(resourceUri, "{#f#}", FORM[f]) />
		<!--- Now remove the value from the FORM struct to clean it up so it can be passed directly into the newRequst() method... --->
		<cfset StructDelete(FORM, f) />
	</cfif>
	<!--- Now, if any of the parameters are blank, delete them... --->
	<cfif StructKeyExists(FORM, f) AND NOT len(trim(FORM[f]))>
		<cfset StructDelete(FORM, f) />
	</cfif>
</cfloop--->

<cfscript>
    function CleanedPhoneNumber(number)
        {
            // The first thing we need to do is just have the numbers, this command removes anything that is not shown between the [ ] brackets.
            current_phone = #ReReplaceNoCase(number, '[^0123456789]', '', 'ALL')#;
            //Define the area code, this takes the left 3 characters and specifies them as area code.
            areacode = left(current_phone, 3);
            //Define The First Three, this takes the middle three values starting at position 4 and defines them at the first three numbers of the phone number.
            firstthree = mid(current_phone, 4, 3);
            //Define The Last Three, this takes the last four numbers and defines them as the last four digits of the phone number.
            lastfour = right(current_phone, 4);
            //Define the actual One, this is the final variable that you can customize to export the look you want for the displaying of the phone number.
            phone_number = "+1 #areacode#-#firstthree#-#lastfour#";
            return phone_number;
        }
</cfscript>

<!--- Add all the parameters to the structure --->
<cfset rData.Body = form.body />
<cfset rData.from = CleanedPhoneNumber(form.from)>

<!--- Send to a group of numbers --->
	<cfif arrayLen(aSendLog) GT 0>
        <cfloop index="i"  array="#aSendLog#">    
		    <!---cfset formStruct.to = CleanedPhoneNumber(i.phone_cell)--->
		    <cfset rData.to = CleanedPhoneNumber(i.phone_cell)>                        

            <cfset requestObj = application.TwilioLib.newRequest("Accounts/#REQUEST.AccountSid#/SMS/Messages.xml", "POST", rData) />
            
			<cfif requestObj.getResponse().wasSuccessful()>
			    <!---cfset messageDetails = structNew()>
			    <cfset messageDetails.Sid = myxmldoc.TwilioResponse.SMSMessage.sid>    
			    <cfset messageDetails.DateCreated = myxmldoc.TwilioResponse.SMSMessage.DateCreated>    
			    <cfset messageDetails.DateUpdated = myxmldoc.TwilioResponse.SMSMessage.DateUpdated>    
			    <cfset messageDetails.AccountSid = myxmldoc.TwilioResponse.SMSMessage.AccountSid>
			    <cfset messageDetails.To = myxmldoc.TwilioResponse.SMSMessage.To>
			    <cfset messageDetails.From = myxmldoc.TwilioResponse.SMSMessage.From>        
			    <cfset messageDetails.Body = myxmldoc.TwilioResponse.SMSMessage.Body>
			    <cfset messageDetails.Status = myxmldoc.TwilioResponse.SMSMessage.Status>
			    <cfset messageDetails.Direction = myxmldoc.TwilioResponse.SMSMessage.Direction>
			    <cfset messageDetails.From = myxmldoc.TwilioResponse.SMSMessage.ApiVersion>        
			        
			    <cfdump var="#myxmldoc.TwilioResponse.SMSMessage#"--->
                <!--- TODO: add a status update here to message/contact table --->
                <cfset session.sendMessage.Status = "Success">
                <cfset session.sendMessage.message = requestObj.getResponse().output()>
			<cfelse>
                <cfset session.sendMessage.Status = "Fail">
                <cfset session.sendMessage.message = requestObj.getResponse().output()>
			</cfif>
		</cfloop>
	<!---cfelse>
		<!--- Send from the forms select list --->
		<cfloop index="i" list="#form.to#">
		    <cfset form.to = i>
			<cfset resourceUri = ReplaceNoCase(resourceUri, "{to}", form.to) />
		
			<cfset requestObj = REQUEST.TwilioLib.newRequest(resourceUri, resourceMethod, FORM, _accountsid, _authtoken) />
			<cfif requestObj.getResponse().wasSuccessful()>
			    <!---cfset messageDetails = structNew()>
			    <cfset messageDetails.Sid = myxmldoc.TwilioResponse.SMSMessage.sid>    
			    <cfset messageDetails.DateCreated = myxmldoc.TwilioResponse.SMSMessage.DateCreated>    
			    <cfset messageDetails.DateUpdated = myxmldoc.TwilioResponse.SMSMessage.DateUpdated>    
			    <cfset messageDetails.AccountSid = myxmldoc.TwilioResponse.SMSMessage.AccountSid>
			    <cfset messageDetails.To = myxmldoc.TwilioResponse.SMSMessage.To>
			    <cfset messageDetails.From = myxmldoc.TwilioResponse.SMSMessage.From>        
			    <cfset messageDetails.Body = myxmldoc.TwilioResponse.SMSMessage.Body>
			    <cfset messageDetails.Status = myxmldoc.TwilioResponse.SMSMessage.Status>
			    <cfset messageDetails.Direction = myxmldoc.TwilioResponse.SMSMessage.Direction>
			    <cfset messageDetails.From = myxmldoc.TwilioResponse.SMSMessage.ApiVersion>        
			        
			    <cfdump var="#myxmldoc.TwilioResponse.SMSMessage#"--->
				<cfoutput>
					<h4>CFML Object Response - requestObj.getResponse().output()</h4>
					<textarea style="width:100%; height:100px;">#requestObj.getResponse().asString()#</textarea>    
					<cfdump var="#requestObj.getResponse().output()#" label="Response Output" expand="false" />
				</cfoutput>
			<cfelse>
				<span class="fail">failed</span>.
				<cfdump var="#requestObj.getResponse().GETSTATUSCODE#">
				<cfdump var="#requestObj.getResponse()#">
			</cfif>
        </cfloop--->
	</cfif>
    
    <cflocation url="/display/dsp_reviewMessages.cfm" addtoken="false">
