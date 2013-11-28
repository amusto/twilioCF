<cfcomponent displayname="users" output="false" hint="">

	<!--- Getters and Setters --->
	<!--- Methods --->

	<cffunction name="addUser" access="public" output="false" returntype="void">
		<cfargument name="firstname" type="string" required="true" />
		<cfargument name="lastname" type="string" required="true" />
		<cfargument name="email" type="string" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="getUser" access="public" output="false" returntype="query">
        <cfargument name="userId" required="true" type="Numeric">
		<cfset var result = "" />
        
        <cftry>
	        <cfquery name="qgetUser" datasource="#application.datasource#">
	            select u.id, u.firstname, u.lastname, u.username, u.passwordHash, u.email, u.phone, u.cell, u.orgId, o.name organizationName, o.safe_list, u.ts from users u
					join organizations o on o.id=u.orgId
	                where u.id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#userId#">
		            order by u.lastname                                        
	        </cfquery>
	        <cfcatch type="any">
	            <cfdump var="#cfcatch#" expand="false" label="Error message">
	            <cfabort>
	        </cfcatch>
        </cftry>
        
        <cfset result = qgetUser>
        
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>    
    
	<cffunction name="getUsers" access="public" output="false" returntype="query">
        <cfargument name="orgId" required="true" default="">
		<cfset var result = "" />

        <cfquery name="qgetUsers" datasource="#application.datasource#">
            select id, firstname, lastname, username, passwordHash, email, phone, cell, orgId, ts from users
            where orgId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.orgId#">
            order by lastname
        </cfquery>
        
        <cfset result = qgetUsers>
        
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>    

	<cffunction name="removeUser" access="public" output="false" returntype="string">
		<cfargument name="userId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="updateUser" access="public" output="false" returntype="void">
		<cfargument name="userId" type="integer" required="true" />
		<cfargument name="firstname" type="string" required="true" />
		<cfargument name="lastname" type="string" required="true" />
		<cfargument name="email" type="string" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

</cfcomponent>
