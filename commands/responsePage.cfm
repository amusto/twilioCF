<!---cfoutput>
<cfsavecontent variable="replyContent">
    THIS IS A TEST<br />So is this<br /><br /><br />
    #form.AccountSid#
</cfsavecontent>
</cfoutput>
<cffile action="write" file="replyPageMessage.html" output="#replyContent#" --->
<cfxml variable="responseMessage">
<?xml version='1.0' encoding='utf-8' ?>
<Response>
    <Sms>Hello, Mobile Monkey</Sms>
</Response>
</cfxml>

<!---Convert the XML document to a string--->
<cfset xmlString = ToString(responseMessage)>

<!---Set the content to text/xml, reset the buffer, and output the XML string--->
<cfcontent type="text/xml" reset="yes"><cfoutput>#xmlString#</cfoutput>

<cfabort>


<!--- Create a new structure that will hold the request parameters ---> 
<cfset rData = StructNew() /> 

<!---cfxml variable="docGeorge">
<?xml version='1.0' encoding='utf-8' ?>
<Response>
    <Sms>Hello, Mobile Monkey</Sms>
</Response>
</cfxml>

<!---Convert the XML document to a string--->
<cfset xmlString = ToString(docGeorge)>

<!---Set the content to text/xml, reset the buffer, and output the XML string--->
<cfcontent type="text/xml" reset="yes"><cfoutput>#xmlString#</cfoutput--->

<cfxml variable="responseMessage">
<?xml version='1.0' encoding='utf-8' ?>
<Response>
    <Sms>Hello, Mobile Monkey</Sms>
</Response>
</cfxml>

<!---Convert the XML document to a string--->
<cfset xmlString = ToString(responseMessage)>

<!---Set the content to text/xml, reset the buffer, and output the XML string--->
<cfcontent type="text/xml" reset="yes"><cfoutput>#xmlString#</cfoutput>

<!---cfprocessingdirective suppresswhitespace="Yes">
<cfcontent type="text/xml; charset=utf-16">
<cfxml variable="MyDoc">
<?xml version='1.0' encoding='utf-8' ?>
<Response>
    <Sms>Hello, Mobile Monkey</Sms>
</Response>
</cfxml--->

<!---cfset form.accountSid = "AC56a6aae00ce4fff35e94bcc0d89ebee2">
<cfset form.AuthToken = "232d4c8af300c3ec357d36302ee5ec1e">
<cfset form.format = "xml">
<cfset form.resourceId = 8--->

<!---cffile action="read" file="#expandPath("api.twilio.com.xml")#" variable="wadl" />
<cfset wadl = XmlParse(wadl) />

<cfset categories = StructNew() />

<cfset resource = wadl.application.resources.resource[FORM.Resourceid]/>

<cfset _accountsid = FORM.accountsid />
<cfset _authtoken = FORM.authtoken />
<cfset left = "<" />
<cfset right = ">" /--->

<cfmail from="armando.musto@gmail.com" to="armando.musto@gmail.com" subject="reply from SMS">
    #responseMessage#
</cfmail>

<!---cfif StructKeyExists(FORM, 'format') AND NOT len(FORM.format)>
	<cfset FORM.format = FORM.defaultformat />	
</cfif--->

<!--- Add all the parameters to the structure --->
<cfset rData.Body = responseMessage />
<cfset rData.from = CleanedPhoneNumber(form.from)>

<cfdump var="#request#">
<cfabort>
<cfset requestObj = application.TwilioLib.newRequest("Accounts/#REQUEST.AccountSid#/SMS/Messages.xml", "POST", rData) />

<cfabort>
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
</cfif>

<!--- First loop the resource replacing any of the placeholders with the correct values... --->
<cfloop collection="#form#" item="f">
	<cfif FindNoCase("{#f#}", resourceUri) AND len(trim(FORM[f]))>
		<cfset resourceUri = ReplaceNoCase(resourceUri, "{#f#}", FORM[f]) />
		<!--- Now remove the value from the FORM struct to clean it up so it can be passed directly into the newRequst() method... --->
		<cfset StructDelete(FORM, f) />
	</cfif>
	<!--- Now, if any of the parameters are blank, delete them... --->
	<cfif StructKeyExists(FORM, f) AND NOT len(trim(FORM[f]))>
		<cfset StructDelete(FORM, f) />
	</cfif>
</cfloop>

	<cfset requestObj = REQUEST.TwilioLib.newRequest(resourceUri, resourceMethod, FORM, _accountsid, _authtoken) />
	
	<cfoutput>
  <cfsavecontent variable="cfmlcode" >
  	<h4>Request Result</h4>
		This request 
		<cfif requestObj.getResponse().wasSuccessful()>
			was <span class="success">successful</span>.
		<cfelse>
			<span class="fail">failed</span>.
		</cfif>
		<h4>CFML Code Used</h4>
		<div class="cfmlcode">
		&##60;--- Create an instance of the TwilioLib, this is a singleton so it could be persisted in the Application scope or handled via a DI engine such as ColdSpring ---&##62;
		<br/>
		&##60;cfset twilio = createObject("component", "TwilioLib").init(#_accountsid#, #_authtoken#) /&##62;
		<br/>
		<br/>		
		<cfif ListLen(StructKeyList(FORM))>
			&##60;--- Create a new structure that will hold the request parameters ---&##62;
			<br/>
			&##60;cfset rData = StructNew() /&##62;
			<br/>
			<br/>
			&##60;--- Add all the parameters to the structure ---&##62;<br/>
			<cfloop collection="#form#" item="f">
				&##60;cfset rData.#f# = #FORM[f]# /&##62;<br/>
			</cfloop>
			<br/>
		</cfif>
		&##60;--- Call the newRequest method from the TwilioLib object that was created previously, or is persisted in the application ---&##62;
		<br/>
		&##60;cfset requestObj = twilio.newRequest("#resourceUri#", "#resourceMethod#"<cfif ListLen(StructKeyList(FORM))>, rData</cfif>) /&##62;
		<br/>
		<br/>
		&##60;--- Check to see if the request was successful using the wasSuccessful method from the response object ---&##62;<br/>
		requestObj.getResponse().wasSuccessful()
		<br/>
		<br/>
		&##60;--- Get the raw text response ---&##62;
		<br/>
		requestObj.getResponse().asString()
		<br/>
		<br/>
		&##60;--- Get the response as CFML Object ---&##62;
		<br/>
		requestObj.getResponse().output()
		</div>
	</cfsavecontent>
	#cfmlcode#
	
	<h4>Raw Response - requestObj.getResponse().asString()</h4>
	<textarea style="width:100%; height:100px;">#requestObj.getResponse().asString()#</textarea>
	
	<h4>CFML Object Response - requestObj.getResponse().output()</h4>
	<cfdump var="#requestObj.getResponse().output()#" label="Response Output" expand="true" />
	
	</cfoutput>
	
