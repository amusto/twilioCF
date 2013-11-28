	<!-- Begin left panel -->
	<a href="javascript:;" id="show_menu">&raquo;</a>
	<div id="left_menu">
		<a href="javascript:;" id="hide_menu">&laquo;</a>
		<ul id="main_menu">
			<li><a href="/dashboard.cfm"><img src="/images/icon_home.png" alt="Home"/>Home</a></li>
			<li><a id="menu_pages" href="/display/dsp_sendMessage.cfm"><img src="/images/icon_pages.png" alt="Pages"/>Send Message</a></li>
			<li><a id="menu_pages" href="/display/dsp_reviewMessages.cfm"><img src="/images/icon_pages.png" alt="Pages"/>Review messages</a>            
				<!---ul>
					<li><a href="/display/dsp_sendMessage.cfm">Create a message</a></li>
					<li><a href="/display/dsp_reviewMessages.cfm">Review messages</a></li>
				</ul--->
			</li>
			<li>
				<a href="/display/dsp_groups.cfm"><img src="/images/icon_media.png" alt="Media"/>Groups</a>
			</li>            
			<li>
				<a href="/display/dsp_reviewContacts.cfm"><img src="/images/icon_media.png" alt="Media"/>Contacts</a>
			</li>
            <cfif session.roleId GT 2>
			<li>
				<a id="menu_pages" href=""><img src="/images/icon_pages.png" alt="Pages"/>Users</a>
				<ul>
					<li><a href="/display/dsp_reviewOrgs.cfm"><img src="/images/icon_users.png" alt="Users"/>Review organizations</a></li>
					<li><a href="/display/dsp_reviewUsers.cfm"><img src="/images/icon_users.png" alt="Users"/>Review my users</a></li>
					<!---li><a href="/display/dsp_development.cfm"><img src="/images/icon_users.png" alt="Users"/>Development</a></li--->                    
				</ul>
			</li>
            <cfelse>
			<li>
				<a href="/display/dsp_reviewUsers.cfm"><img src="/images/icon_users.png" alt="Users"/>Users</a>
			</li>
            </cfif>
		</ul>
		<br class="clear"/>
		
		<!-- Begin left panel calendar -->
		<!---div id="calendar"></div--->
		<!-- End left panel calendar -->
		
	</div>
	<!-- End left panel -->