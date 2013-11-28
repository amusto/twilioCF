<cfcomponent displayname="messages" output="false" hint="">


	<!--- Getters and Setters --->

	<!--- Methods --->

	<cffunction name="createMessage" access="public" output="false" returntype="string">
		<cfargument name="userid" type="integer" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="from" type="string" required="true" />
		<cfargument name="contactList" type="string" required="true" />        
		<cfargument name="body" type="string" required="true" />
		<cfset var result = "" />

		<cfreturn result />
	</cffunction>

	<cffunction name="getMessage" access="public" output="false" returntype="query">
		<cfargument name="messageId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="removeMessage" access="public" output="false" returntype="string">
		<cfargument name="messageId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="updateMessage" access="public" output="false" returntype="string">
		<cfargument name="messageId" type="integer" required="true" />
		<cfargument name="title" type="string" required="true" />
		<cfargument name="body" type="string" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

</cfcomponent>
