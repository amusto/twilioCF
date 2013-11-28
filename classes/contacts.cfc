<cfcomponent displayname="contacts" output="false" hint="">


	<!--- Getters and Setters --->

	<!--- Methods --->

	<cffunction name="addContact" access="public" output="false" returntype="string">
		<cfargument name="contactValues" type="struct" required="true" />
		<cfset var result = "" />

        <cftry>
	        <cfquery name="insertContact" datasource="#application.datasource#">
	            insert into contacts(firstname, lastname, email, phone_cell, building_id, unit_id, userId)
				    values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#contactValues.firstName#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactValues.lastName#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactValues.email#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactValues.phone#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactValues.building#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactValues.unit#">, <cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userId#">)
	        </cfquery>
	        <cfcatch type="any">
	            <cfdump var="#cfcatch#" expand="false" label="Error message">
	            <cfabort>
	        </cfcatch>
        </cftry>

		<cfreturn result />
	</cffunction>

	<cffunction name="getContactById" access="public" output="false" returntype="query">
		<cfargument name="contactId" type="any" required="true" />
		<cfset var result = "" />

	        <cfquery name="getContactInfo" datasource="#application.datasource#">
	            select id, firstname, lastname, email, phone_cell, property_id, building_id, unit_id, lease_years, unit_type, lease_expires, ts from contacts
	            where id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#contactId#">
	        </cfquery>
            <cfset result = getContactInfo>

		<cfreturn result />
	</cffunction>
    
	<cffunction name="getContactMessageDetailsById" access="public" output="false" returntype="query">
		<cfargument name="contactId" type="any" required="true" />
		<cfset var result = "" />

	        <cfquery name="getContactInfo" datasource="#application.datasource#">
	            select id, firstname, lastname, email, phone_cell, property_id, building_id, unit_id, lease_years, unit_type, lease_expires, ts from contacts
	            where id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#contactId#">
	        </cfquery>
            <cfset result = getContactInfo>

		<cfreturn result />
	</cffunction>    
    
	<cffunction name="getContactByPhone" access="public" output="false" returntype="query">
		<cfargument name="contactPhone" type="any" required="true" />
		<cfset var result = "" />

	        <cfquery name="getContactInfo" datasource="#application.datasource#">
	            select id, firstname, lastname, email, phone_cell, property_id, building_id, unit_id from contacts
	            where phone_cell = <cfqueryparam cfsqltype="cf_sql_varchar" value="#right(arguments.contactPhone, 10)#">
                and userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userId#">
	        </cfquery>

            <cfset result = getContactInfo>

		<cfreturn result />
	</cffunction>    

	<cffunction name="getContactByName" access="public" output="false" returntype="query">
		<cfargument name="contactId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>
    
	<cffunction name="getContacts" access="public" output="false" returntype="query">
		<cfargument name="queryParameters" type="struct" required="true" />        
        <cfset var result = "" />

        <cfif queryParameters.iDisplayLength EQ 0>
	        <cfquery name="getContacts" datasource="#application.datasource#">
	            select id, firstname, lastname, email, phone_cell, property_id, building_id, unit_id, ts from contacts
                where phone_cell IS NOT NULL
                and userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userid#">
	            order by id
	        </cfquery>
        <cfelse>
	        <cfquery name="getContacts" datasource="#application.datasource#" maxrows="#queryParameters.IDISPLAYLENGTH#">
	            select id, firstname, lastname, email, phone_cell, property_id, building_id, unit_id, ts from contacts
                where phone_cell IS NOT NULL                                                   
                and userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userid#">                 
	            order by id
	        </cfquery>        
        </cfif>

        <cfset result = getContacts>
		<cfreturn result />
	</cffunction>    

	<cffunction name="getGroupContacts" access="public" output="false" returntype="query">
		<cfargument name="queryParameters" type="struct" required="true" />        
        <cfset var result = "" />
        
        <cfquery name="getGroupInfo" datasource="#application.datasource#">
	        select id, groupName, contactList, userId, ts
			from groups
            where id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#queryParameters.groupId#">
            and userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#session.userid#">
        </cfquery>

        <cfif queryParameters.iDisplayLength EQ 0>
	        <cfquery name="getContacts" datasource="#application.datasource#">
				select c.id, c.firstname, c.lastname, c.email, c.phone_cell, c.property_id, c.building_id, c.unit_id, c.ts
				from contacts c
				where c.phone_cell IS NOT NULL
				and c.userId = 1
				and c.id in (<cfqueryparam cfsqltype="cf_sql_numeric" list="true" value="#getGroupInfo.contactList#">)
				order by c.id
	        </cfquery>
        <cfelse>
	        <cfquery name="getContacts" datasource="#application.datasource#" maxrows="#queryParameters.IDISPLAYLENGTH#">
				select c.id, c.firstname, c.lastname, c.email, c.phone_cell, c.property_id, c.building_id, c.unit_id, c.ts
				from contacts c
				where c.phone_cell IS NOT NULL
				and c.userId = 1
				and c.id in (<cfqueryparam cfsqltype="cf_sql_numeric" list="true" value="#getGroupInfo.contactList#">)
				order by c.id
	        </cfquery>        
        </cfif>
        
        <cfset result = getContacts>
		<cfreturn result />
	</cffunction>    

	<cffunction name="addGroup" access="public" output="false" returntype="string">
		<cfargument name="formValues" type="any" required="true" />
		<cfset var result = "Success" />
        <cfset listContacts = "">
        <cfloop list="#id#" index="i">
            <cfset listContacts = listAppend(listContacts,i)>            
        </cfloop>

        <!---cftry--->
	        <cfquery name="insertGroup" datasource="#application.datasource#">
	            insert into groups (groupName, contactList, userId)
	                values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#groupName#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#listContacts#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userId#">)
	        </cfquery>
	        <!---cfcatch type="any">
	            <cfset result="fail">
	        </cfcatch>
        </cftry--->

		<cfreturn result />
	</cffunction>
    
	<cffunction name="updateGroup" access="public" output="false" returntype="string">
		<cfargument name="formValues" type="any" required="true" />
		<cfset var result = "Success" />
        <cfset listContacts = "">

        <cfloop list="#id#" index="i">
            <cfset listContacts = listAppend(listContacts,i)>            
        </cfloop>

<cfdump var="#arguments#">
<cfdump var="#listContacts#">
<cfabort>

        <!---cftry--->
	        <cfquery name="updateGroup" datasource="#application.datasource#">
                update groups 
                    set groupName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#groupName#">,
                    contactList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listContacts#">
                    where id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#groupId#">
                    and userId = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userId#">
	        </cfquery>
	        <!---cfcatch type="any">
	            <cfset result="fail">
	        </cfcatch>
        </cftry--->

		<cfreturn result />
	</cffunction>    
    
	<cffunction name="deleteGroup" access="public" output="false" returntype="string">
		<cfargument name="groupId" type="numeric" required="true" />
		<cfset var result = "Success" />
    
        <!---cftry--->
	        <cfquery name="deleteGroup" datasource="#application.datasource#">
                delete groups 
                    where id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#groupId#">
                    and userId = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userId#">
	        </cfquery>
	        <!---cfcatch type="any">
	            <cfset result="fail">
	        </cfcatch>
        </cftry--->

		<cfreturn result />
	</cffunction>    

	<cffunction name="getGroup" access="public" output="false" returntype="query">
		<cfargument name="userId" type="Numeric" required="true" />
		<cfargument name="groupId" type="Numeric" required="true" />        
        <cfset var result = "" />
        
        <cfquery name="getGroup" datasource="#application.datasource#">
            select * from groups
	            where userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#userId#">
                and id = <cfqueryparam cfsqltype="cf_sql_integer" value="#groupId#">
        </cfquery>
        
        <cfset result = getGroup>
		<cfreturn result />
	</cffunction>    

	<cffunction name="getGroups" access="public" output="false" returntype="query">
		<cfargument name="userId" type="Numeric" required="true" />        
        <cfset var result = "" />
        
        <cfquery name="getGroups" datasource="#application.datasource#">
			select id, groupname, (select count(contactList) from groups where userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#userId#">) contacts, userid, ts from groups
			where userId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#userId#">
			order by groupName
        </cfquery>
        
        <cfset result = getGroups>
		<cfreturn result />
	</cffunction>    

	
    <cffunction name="removeContact" access="public" output="false" returntype="string">
		<cfargument name="contactId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="updateContact" access="public" output="false" returntype="string">
		<cfargument name="contactId" type="integer" required="true" />
		<cfargument name="firstname" type="string" required="true" />
		<cfargument name="lastname" type="string" required="true" />
		<cfargument name="email" type="string" required="true" />
		<cfargument name="phone_cell" type="string" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

</cfcomponent>
