<cfset queryParameters = structnew()>
<cfset queryParameters.iDisplayLength = 0>

<cfprocessingdirective suppresswhitespace="yes">
<cfsetting showdebugoutput="no">
<cfset getGroups = application.contacts.getGroups(session.userId)>
<cfabort>
<!---cfset getContacts = application.contacts.getContacts(queryparameters:queryParameters)--->

<!--- Declare the array ---> 
<cfset aContacts=arraynew(2)> 
 
<!--- Populate the array row by row ---> 
<cfloop query="getContacts">
    <cfoutput>
	<cfsavecontent variable="checkBoxValue">
	<input type='checkbox' name='id' value='#id#'>    
	</cfsavecontent>
    </cfoutput> 

    <cfset aContacts[CurrentRow][1]=checkBoxValue>     
    <cfset aContacts[CurrentRow][2]="#trim(lastname)#, #trim(firstname)#"> 
    <cfset aContacts[CurrentRow][3]=unit_id> 
    <cfset aContacts[CurrentRow][4]=phone_cell> 
    
</cfloop> 

<cfoutput>
<!---cfsavecontent variable="returnJSONFeed">{
  "sEcho": #sEcho#,
  "iTotalRecords": "#getContacts.recordcount#",
  "iTotalDisplayRecords": "#getContacts.recordcount#",        
"aaData": 
    #SerializeJSON(aContacts, false)#
    }
</cfsavecontent--->
<cfsavecontent variable="returnJSONFeed">{
"aaData": 
    #SerializeJSON(aContacts, false)#
    }
</cfsavecontent>
<cfcontent type="application/json">#trim(returnJSONFeed)#</cfoutput>
</cfprocessingdirective>
<cfabort>