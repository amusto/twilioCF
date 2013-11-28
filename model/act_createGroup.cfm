<cfdump var="#form#">
<cfset addGroup = application.contacts.addGroup(form)>

<cflocation addtoken="false" url="/display/dsp_groups.cfm">
