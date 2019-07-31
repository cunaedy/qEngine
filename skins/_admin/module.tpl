<!-- BEGINIF $module_engine -->
<!-- ELSE -->
<div class="alert alert-danger"><span class="oi oi-warning"></span> Module Engine is disabled in Primary Config. All modules will be disabled!</div>
<!-- ENDIF -->

<!-- BEGINIF $tpl_mode == 'list' -->
<div class="card">
	<div class="card-header"><span class="oi oi-cog" aria-hidden="true"></span> Module Library</div>
	<table width="100%" class="table">
		<tr>
			<th class="">Name</th>
			<th class="text-center">Version</th>
			<th class="">Description</th>
			<th class="text-center">Enabled</th>
			<th class="text-center">Configure</th>
			<th class="text-center">Document</th>
			<th class="text-center">Uninstall</th>
		</tr>

	<!-- BEGINBLOCK list -->
	<tr>
		<td class="text-center" valign="top">{$icon}<br />{$mod_name}</td>
		<td class="text-center" valign="top">{$mod_version}</td>
		<td valign="top"><div>{$mod_desc}</div>
						<p><span class="oi oi-person"></span> Author: {$mod_author}
						<span class="oi oi-info ml-2"></span> License: {$mod_license}<br />
						<span class="oi oi-external-link"></span> <a href="http://{$mod_authorUrl}">{$mod_authorUrl}</a>
						<span class="oi oi-envelope-closed ml-2"></span> <a href="mailto:{$mod_authorEmail}">{$mod_authorEmail}</a><br />
						&copy; {$mod_copyright}</p></td>
		<td class="text-center">{$mod_enabled}</td>
		<td class="text-center">
		<p>{$configure}</p></td>

		<td class="text-center"><p><a href="modplug_doku.php?what=module&amp;mod_id={$mod_id}" class="module_setup">
		<span class="oi oi-file icon-l"></span></a></p></td>

		<td class="text-center"><p><a href="modplug_install.php?cmd=ask_uninstall&amp;what=module&amp;mod_id={$mod_id}&amp;AXSRF_token={$axsrf}" class="module_setup">
		<span class="oi oi-trash icon-l text-danger"></span></a></td>
	</tr>
	<!-- ENDBLOCK -->
	</table>
</div>
<div class="card-footer">
	<a href="module.php?cmd=scan" class="btn btn-primary"><span class="oi oi-magnifying-glass"></span> Scan For New Modules</a>
</div>
<!-- ENDIF -->

<!-- BEGINIF $tpl_mode == 'scan' -->
<div class="card">
	<div class="card-header">Available Modules</div>
	<table class="table table-bordered">
		<tr>
			<td colspan="5"><a href="module.php"><span class="oi oi-chevron-left"></span> Installed Modules</a></td>
		</tr>
		<tr>
			<th>Name</th>
			<th class="text-center">Version</th>
			<th>Description</th>
			<th class="text-center">Install</th>
			<th class="text-center">Documentation</th>
		</tr>

		<!-- BEGINBLOCK avail -->
		<tr>
			<td valign="toptext-center" valign="top">{$icon}<br />{$mod_name}</td>
			<td valign="toptext-center" valign="top">{$mod_version}</td>
			<td valign="top"><div>{$mod_desc}</div>
							<p><span class="oi oi-person"></span> Author: {$mod_author}
							<span class="oi oi-info"></span> License: {$mod_license}<br />
							&copy; {$mod_copyright}<br />
							<span class="oi oi-external-link"></span> <a href="http://{$mod_authorUrl}">{$mod_authorUrl}</a>
							<span class="oi oi-envelope-closed"></span> <a href="mailto:{$mod_authorEmail}">{$mod_authorEmail}</a></p></td>
			<td class="text-center"><a href="modplug_install.php?cmd=install&amp;what=module&amp;mod_id={$mod_id}&amp;AXSRF_token={$axsrf}" class="module_setup">
			<span class="oi oi-check icon-l"></span><br />
			{$l_install}</a></td>

			<td class="text-center"><a href="modplug_doku.php?what=module&amp;mod_id={$mod_id}" class="module_setup">
			<span class="oi oi-file icon-l"></span><br />Documentation</a></td>
		</tr>
		<!-- ENDBLOCK -->
	</table>
</div>
<!-- ENDIF -->


<!-- BEGINSECTION config_icon -->
<a href="modplug_config.php?what=module&amp;mod_id={$mod_id}" class="module_setup"><span class="oi oi-wrench icon-l"></span></a>
<!-- ENDSECTION -->

<!-- BEGINSECTION no_config_icon -->
<span class="oi oi-wrench icon-l text-muted"></span>
<!-- ENDSECTION -->