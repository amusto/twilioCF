<cfcomponent displayname="sms" output="false" hint="">


	<!--- Getters and Setters --->

	<!--- Methods --->

	<cffunction name="insertSMSMessage" access="public" output="false" returntype="string">
		<cfargument name="messageStruct" type="struct" required="true" />
		<cfargument name="orgId" type="string" required="true" />
		<cfset var result = "Success" />

        <cfif messageDupeCheck(messageStruct.Sid).recordcount EQ 0>
	        <cftry>
		        <cfquery name="insertMessage" datasource="#application.datasource#" result="insertResults">
					INSERT INTO smsMessages (orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri)
					     VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.orgId#">, 
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.sid#">, 
	                            <cfqueryparam cfsqltype="cf_sql_timestamp" value="#messageStruct.DateCreated#">, 
	                            <cfqueryparam cfsqltype="cf_sql_timestamp" value="#messageStruct.dateUpdated#">,                                    
	                            <cfqueryparam cfsqltype="cf_sql_timestamp" value="#messageStruct.dateSent#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.AccountSid#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.from#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.to#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.body#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.status#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.direction#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.price#" null="true">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.priceUnit#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.apiVersion#">,
	                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageStruct.uri#">)                                       
	            </cfquery>
		        <cfcatch type="any">
		            <cfset result="failed">
	                <cfdump var="#messageStruct#">                                                        
                    <cfdump var="#cfcatch#">                                                       

	                <cfabort>
		        </cfcatch>
	        </cftry>
        <cfelse>
            <cfset result="duplicate - no insert">        
        </cfif>

		<cfreturn result />
	</cffunction>

	<cffunction name="createMessage" access="public" output="false" returntype="string">
		<cfargument name="title" type="string" required="true" />
		<cfargument name="userid" type="integer" required="true" />
		<cfargument name="body" type="string" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="messageDupeCheck" access="public" output="false" returntype="query">
		<cfargument name="messageSid" type="string" required="true" />
		<cfset var result = queryNew("blank") />

        <cftry>		
	        <cfquery name="dupeCheck" datasource="#application.datasource#">
			    select orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts from smsMessages
			        where sid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#messageSid#">
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn dupeCheck />
	</cffunction>


	<cffunction name="getMessage" access="public" output="false" returntype="query">
		<cfargument name="messageId" type="integer" required="true" />
		<cfset var result = "" />
		<cfreturn result />
	</cffunction>
    
	<!---cffunction name="getMessageList" access="public" output="false" returntype="query">
		<cfargument name="orgId" type="numeric" required="true" />
		<cfset var result = queryNew("blank") />
		<cfset var queryFrom = getMessageListFrom(orgId:orgId) />        
		<cfset var queryTo = getMessageListTo(orgId:orgId) />        

        <cftry>		
	        <cfquery name="getMessageList" datasource="#application.datasource#">
			    select orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts from smsMessages
			        where orgId = <cfqueryparam cfsqltype="cf_sql_varchar" value="#orgId#">
                                            

				select [from], orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts 
				from smsMessages sms
				where sid = 
				( 
				select top 1 sid from smsMessages 
				where [from] = sms.[from] and orgId = <cfqueryparam cfsqltype="cf_sql_varchar" value="#orgId#"> 
				order by dateSent desc
				)
                                            
                                            
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <cfdump var="#cfcatch#">
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn getMessageList />

		<cfreturn result />
	</cffunction--->    

	<cffunction name="getMessagesByContact" access="public" output="false" returntype="query">
		<cfargument name="contactId" type="numeric" required="true" />
		<cfset var result = queryNew("blank") />

        <cftry>		
	        <cfquery name="getMessageList" datasource="#application.datasource#">
				select (select count(id) from smsMessages where [from] = sms.[from]) totalMessages, id, orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts 
				from smsMessages sms
				where direction = <cfqueryparam cfsqltype="cf_sql_varchar" value="inbound"> 
                and sid = 
				( 
				select top 1 sid from smsMessages 
				where [from] = sms.[from] 
				order by dateSent desc
				)
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <cfdump var="#cfcatch#">
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn getMessageList />

	</cffunction>    


    
	<cffunction name="getMessageList" access="public" output="false" returntype="query">
		<cfargument name="orgId" type="numeric" required="true" />
		<cfset var result = queryNew("blank") />

        <cftry>		
	        <cfquery name="getMessageList" datasource="#application.datasource#">
				select (select count(id) from smsMessages where [from] = sms.[from]) totalMessages, id, orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts 
				from smsMessages sms
				where direction = <cfqueryparam cfsqltype="cf_sql_varchar" value="inbound"> 
                and sid = 
				( 
				select top 1 sid from smsMessages 
				where [from] = sms.[from] 
	               and orgId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#orgId#">
				order by dateSent desc
				)
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <cfdump var="#cfcatch#">
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn getMessageList />

	</cffunction>    


	<cffunction name="getMessagesBySid" access="public" output="false" returntype="query">
		<cfargument name="sid" type="string" required="true" />
		<cfset var result = queryNew("blank") />

        <cftry>		
	        <cfquery name="getMessage" datasource="#application.datasource#">
				select id, orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts 
				from smsMessages sms
				where sid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sid#">
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <cfdump var="#cfcatch#">
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn getMessage />

	</cffunction>


	<cffunction name="getMessageListFrom" access="public" output="false" returntype="query">
		<cfargument name="orgId" type="numeric" required="true" />
		<cfset var result = queryNew("blank") />

        <cftry>		
	        <cfquery name="getMessageList" datasource="#application.datasource#">
				select (select count(id) from smsMessages where [from] = sms.[from]) totalMessages, id, orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts 
				from smsMessages sms
				where sid = 
				( 
				select top 1 sid from smsMessages 
				where [from] = sms.[from] 
                and orgId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#orgId#">
				order by dateSent desc
				)
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <cfdump var="#cfcatch#">
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn getMessageList />

	</cffunction>    

	<cffunction name="getMessageListTo" access="public" output="false" returntype="query">
		<cfargument name="orgId" type="numeric" required="true" />
		<cfset var result = queryNew("blank") />

        <cftry>		
	        <cfquery name="getMessageList" datasource="#application.datasource#">
				select (select count(id) from smsMessages where [to] = sms.[to]) totalMessages, id, orgId, Sid, DateCreated, DateUpdated , DateSent, AccountSid, [From], [To], Body, Status, Direction, Price, PriceUnit, ApiVersion, Uri, ts 
				from smsMessages sms
				where sid = 
				( 
				select top 1 sid from smsMessages 
				where [to] = sms.[to] 
                and orgId = <cfqueryparam cfsqltype="cf_sql_numeric" value="#orgId#">
				order by dateSent desc
				)
	        </cfquery>
	        <cfcatch type="any">
	            <cfset result="failed">
                <cfdump var="#result#">                                                    
                <cfdump var="#cfcatch#">
                <!--- TODO: change to log --->
                <cfabort>
	        </cfcatch>
        </cftry>        
        
		<cfreturn getMessageList />

	</cffunction>    

	<cffunction name="removeMessage" access="public" output="false" returntype="string">
		<cfargument name="messageId" type="integer" required="true" />
		<cfset var result = "" />
		<!---cfthrow type="NotImplemented" message="This method needs to be implemented." /--->
		<cfreturn result />
	</cffunction>

	<cffunction name="sendMessage" access="public" output="false" returntype="string">
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
