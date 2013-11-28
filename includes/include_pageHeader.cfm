	<!-- Begin header -->
	<div id="header">
		<div id="logo">
		</div>
        
		<!---div id="search">
			<form action="dashboard.html" id="search_form" name="search_form" method="get">
				<input type="text" id="q" name="q" title="Search" class="search noshadow"/>
			</form>
		</div--->
        <cfoutput>
		<div id="userDetails">
			<img src="/images/icon_online.png" alt="Online" class="mid_align"/>
			#session.firstname# <a href="/display/dsp_settings.cfm">(Setting)</a> | <a href="index.cfm?logout=1" style="color:red;">Logout</a>
		</div>
		<!---div id="account_info">
			<img src="/images/icon_online.png" alt="Online" class="mid_align"/>
			#getauthuser()# <a href="/display/dsp_settings.cfm">(Setting)</a> | <a href="index.cfm?logout=1">Logout</a>
		</div--->
        </cfoutput>
	</div>
	<!-- End header -->