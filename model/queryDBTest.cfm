<cfquery name="getUsers" datasource="smsmgmt">
    select * from users
</cfquery>
<cfdump var="#getUsers#">