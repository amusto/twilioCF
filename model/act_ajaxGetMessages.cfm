<cfset messageList = application.sms.getMessageList(session.orgid)>

<cfset queryParameters = structnew()>
<cfset queryParameters.iDisplayLength = 0>

<!--- Declare the array ---> 
<cfset aMessages=arraynew(1)> 

<cfset loopCount = 1>
<cfloop query="messageList">
    <!--- Get contacts and create contact name --->
    <cfset fromContactId = application.contacts.getContactByPhone(from).id>
    <cfset fromLastName = application.contacts.getContactByPhone(from).lastName>
    <cfset toContactId = application.contacts.getContactByPhone(to).id>
    <cfset toLastName = application.contacts.getContactByPhone(to).lastName>
    
    <!---cfset aMessages[loopCount][0]="<td><img src='/images/details_open.png'></td>"--->

    <cfif application.contacts.getContactByPhone(from).recordcount EQ 0>
        <cfset aMessages[loopCount][0]= from >
    <cfelse>
        <cfset fromContactId = application.contacts.getContactByPhone(from).id>
        <cfset fromName = "#application.contacts.getContactByPhone(from).firstname# #application.contacts.getContactByPhone(from).lastname#">        
        <cfset aMessages[loopCount][0] = fromName >
    </cfif>
    <cfif application.contacts.getContactByPhone(from).recordcount EQ 0>
        <cfset toContactId = to>
        <cfset aMessages[loopCount][10]= toContactId >        
    <cfelse>
        <cfset toContactId = application.contacts.getContactByPhone(to).id>
        <cfset aMessages[loopCount][10]= toContactId>
    </cfif>

    <cfset aMessages[loopCount][1]= "<a href='/display/dsp_messageDetails.cfm?contactId=#fromContactId#&contactNumber=#from#&Sid=#sid#'>#left(body, 50)#</a>">    
    <!---cfset aMessages[loopCount][3]=status--->
    <cfset aMessages[loopCount][2]="#dateformat(datesent, "mm/dd/yy")# #timeformat(datesent, "hh:mm tt")#">
    <cfset aMessages[loopCount][3]=body>    
    <cfset aMessages[loopCount][4]=sid>    
    <cfset aMessages[loopCount][5]=Uri>    
    <cfset aMessages[loopCount][6]=dateSent>
    <cfset aMessages[loopCount][7]=dateCreated>
    <cfset aMessages[loopCount][8]=dateUpdated>
    <cfset aMessages[loopCount][9]=totalMessages>    
                
    <cfset loopCount = loopCount + 1>
</cfloop>

<!--- Create return array --->
<cfoutput>
<cfsavecontent variable="returnJSONFeed">{
"aaData": 
    #SerializeJSON(aMessages, false)#
    }
</cfsavecontent>
<cfcontent type="application/json">#trim(returnJSONFeed)#</cfoutput>
<cfabort>