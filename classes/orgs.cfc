<cfcomponent displayname="orgs" output="false" hint="">

	<!--- Getters and Setters --->

	<!--- Methods --->

	<cffunction name="addOrg" access="public" output="false" returntype="string">
		<cfargument name="orgName" type="string" required="true" />
		<cfargument name="orgPoc" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="getOrg" access="public" output="false" returntype="query">
		<cfargument name="orgId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>
    
	<cffunction name="getOrgs" access="public" output="false" returntype="query">
		<cfset var result = "" />
        
        <cfquery name="qgetOrgs" datasource="#application.datasource#">
            select * from organizations
        </cfquery>

        <cfset result = qgetOrgs>
        
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>    
    
	<cffunction name="getNumbers" access="public" output="false" returntype="query">
		<cfargument name="orgId" type="numeric" required="true" />
		<cfset var result = "" />
        
        <cftry>
	        <cfquery name="getNumbers" datasource="#application.datasource#" maxrows="1">
                select id, org_id, number, active, ts from org_numbers            
	                where org_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#orgId#">
                    order by active desc                                                                    
	        </cfquery>
	        <cfcatch type="any">
	            <cfdump var="#cfcatch#" expand="false" label="Error message">
	            <cfabort>
	        </cfcatch>
        </cftry>
        
        <cfset result = getNumbers>
        
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>    
    
	<cffunction name="getDefaultNumber" access="public" output="false" returntype="string">
		<cfargument name="orgId" type="numeric" required="true" />
		<cfset var result = "" />
        
        <cftry>
	        <cfquery name="getDefaultNumber" datasource="#application.datasource#">
                select number from org_numbers            
	                where org_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#orgId#">
                    and active = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">                                                                    
	        </cfquery>
	        <cfcatch type="any">
	            <cfdump var="#cfcatch#" expand="false" label="Error message">
	            <cfabort>
	        </cfcatch>
        </cftry>
        
        <cfset result = getDefaultNumber.number>
        
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>    

	<cffunction name="removeOrg" access="public" output="false" returntype="string">
		<cfargument name="orgId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="updateOrg" access="public" output="false" returntype="string">
		<cfargument name="orgId" type="integer" required="true" />
		<cfargument name="orgName" type="string" required="true" />
		<cfargument name="orgPoc" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

</cfcomponent>
