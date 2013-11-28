<!---cfsavecontent variable="returnJSONFeed">{
  "sEcho": 1,
  "iTotalRecords": "57",
  "iTotalDisplayRecords": "57",
  "aaData": [
    [
      "Gecko",
      "Firefox 1.0",
      "Win 98+ / OSX.2+",
      "1.7",
      "A"
    ],
    [
      "Gecko",
      "Firefox 1.5",
      "Win 98+ / OSX.2+",
      "1.8",
      "A"
    ],
    [
      "Gecko",
      "Firefox 2.0",
      "Win 98+ / OSX.2+",
      "1.8",
      "A"
    ],
    [
      "Gecko",
      "Firefox 3.0",
      "Win 2k+ / OSX.3+",
      "1.9",
      "A"
    ],
    [
      "Gecko",
      "Camino 1.0",
      "OSX.2+",
      "1.8",
      "A"
    ],
    [
      "Gecko",
      "Camino 1.5",
      "OSX.3+",
      "1.8",
      "A"
    ],
    [
      "Gecko",
      "Netscape 7.2",
      "Win 95+ / Mac OS 8.6-9.2",
      "1.7",
      "A"
    ],
    [
      "Gecko",
      "Netscape Browser 8",
      "Win 98SE+",
      "1.7",
      "A"
    ],
    [
      "Gecko",
      "Netscape Navigator 9",
      "Win 98+ / OSX.2+",
      "1.8",
      "A"
    ],
    [
      "Gecko",
      "Mozilla 1.0",
      "Win 95+ / OSX.1+",
      "1",
      "A"
    ]
  ]
}</cfsavecontent>
<cfoutput>
<cfcontent type="application/json">
#returnJSONFeed#
</cfoutput>
<cfabort--->

<!--- SERVERSIDE VERSION --->
<!---cfset sEcho=sEcho>
<cfset queryParameters = structnew()>
<cfset queryParameters.iDisplayLength = iDisplayLength--->

<cfset queryParameters = structnew()>
<cfset queryParameters.iDisplayLength = 0>

<cfprocessingdirective suppresswhitespace="yes">
<cfsetting showdebugoutput="no">
<cfset getContacts = application.contacts.getContacts(queryparameters:queryParameters)>

<!--- Declare the array ---> 
<cfset aContacts=arraynew(2)> 
 
<cfsavecontent variable="checkBoxValue">
    <input type="checkbox" name="id" value="#id#"/>
</cfsavecontent> 
 
<!--- Populate the array row by row ---> 
<cfloop query="getContacts">
    <cfset aContacts[CurrentRow][1]="<input type='checkbox' name='id' value='#id#'/>">
    <cfset aContacts[CurrentRow][2]="#trim(lastname)#, #trim(firstname)#"> 
    <cfset aContacts[CurrentRow][3]=property_id>
    <cfset aContacts[CurrentRow][4]=building_id>
    <cfset aContacts[CurrentRow][5]=unit_id> 
    <cfset aContacts[CurrentRow][6]=phone_cell> 
    <cfset aContacts[CurrentRow][7]=email> 
    <cfset aContacts[CurrentRow][8]=ts>    
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