<script>
function confirm_delete ()
{
	c = window.confirm ("Do you wish to clear all logs?\nThis process can not be undone!");
	if (!c) return false;
	document.location = "qform_log.php?cmd=delall&AXSRF_token={$axsrf}";
}


function confirm_restore (id)
{
	c = window.confirm ("Do you wish to restore this values?\n\nNOTICE! Some changes may not be able to be restored, including: file/image changes.\nWARNING! If you have changed permalink, you may need to refresh it manually.");
	if (!c) return false;
	document.location = "qform_log.php?cmd=restore&log_id="+id+"&AXSRF_token={$axsrf}";
}
</script>
<!-- BEGINIF $enable_detailed_log -->
<div class="alert alert-info"><span class="oi oi-info"></span> Detailed log is enabled. You can restore previous changes. Click <span class="oi oi-magnifying-glass"></span> to restore an item.</div>
<!-- ELSE -->
<div class="alert alert-warning"><span class="oi oi-warning"></span> Restore function doesn't work when detailed log is disabled. Open <a href="qe_config.php" class="alert-link">Settings</a> to enable detailed log.</div>
<!-- ENDIF -->

<div class="card">
	<div class="card-header">qform Log</div>
<!-- BEGINIF $tpl_mode == 'list' -->
	<table class="table table-bordered">
		<tr><th colspan="8"><a href="qform_log.php"><span class="oi oi-reload"></span> Reset Filters</a></th></tr>
		<tr><th width="5%">ID {$sortby_idx}</th>
			<th width="10%">Date/Time {$sortby_date}</th>
			<th width="8%">Admin File {$sortby_file}</th>
			<th width="35%">Item Title {$sortby_title}</th>
			<th width="10%">Action {$sortby_action}</th>
			<th width="15%">User {$sortby_user}</th>
			<th width="7%" nowrap="nowrap"></th>
		</tr>

		<!-- BEGINBLOCK log_item -->
		<tr>
			<td>{$log_id}</td>
			<td><a href="qform_log.php?w=date&amp;h={$log_date}" title="Filter by same date">{$log_date}</a><br /><small>{$log_time}</small></td>
			<td nowrap><a href="qform_log.php?w=file&amp;h={$log_file}" title="Filter by same file">{$log_file}</a></td>
			<td><a href="{$log_file}?id={$log_pid}" title="Edit the item" class="btn btn-xs btn-light"><span class="oi oi-pencil"></span></a>
				<a href="qform_log.php?w=pid&amp;h={$log_file}&amp;pid={$log_pid}" title="Filter by same target item">{$log_title}</a></td>
			<td class="text-center"><a href="qform_log.php?w=action&amp;h={$log_action}">{$log_action_def}</a></td>
			<td><a href="{$site_url}/{$l_admin_folder}/user.php?id={$log_user}" class="btn btn-xs btn-light" title="Edit user in ACP"><span class="oi oi-person"></span></a>
				<a href="qform_log.php?w=user&amp;h={$log_user}" title="Filter by User ID"> {$log_user}</a><br />
				<span class="oi oi-globe btn btn-xs"></span> <a href="qform_log.php?w=ip&amp;h={$log_ip}" title="Filter by IP Address">{$log_ip}</a></td>
			<td class="text-center" nowrap="nowrap"><a href="qform_log.php?cmd=detail&amp;log_id={$log_id}" title="View details" class="btn btn-xs btn-primary"><span class="oi oi-magnifying-glass"></span></a>
			<a href="qform_log.php?cmd=del&amp;log_id={$log_id}&amp;AXSRF_token={$axsrf}" title="Remove this log" class="btn btn-xs btn-danger"><span class="oi oi-trash"></span></a></td>
		</tr>
		<!-- ENDBLOCK -->

	</table>
	<div class="card-footer">
		{$pagination}
		<a href="#page" onclick="confirm_delete()" class="btn btn-danger alert-link"><span class="oi oi-x"></span> Remove all logs</a>
</div>
</div>

<!-- ENDIF -->

<!-- BEGINIF $tpl_mode == 'detail' -->
<table class="table table-bordered">
	<tr><th colspan="2"><a href="qform_log.php"><span class="glyphicon glyphicon-chevron-left"></span> Back</a></th></tr>
	<tr><td width="25%">Log ID/Date</td><td width="75%">{$log_id} / {$log_time}</td></tr>
	<tr><td>File</td><td><a href="qform_log.php?w=file&amp;h={$log_file}">{$log_file}</a></td></tr>
	<tr><td>User</td><td>{$log_user} <a href="qform_log.php?w=user&amp;h={$log_user}"><span class="oi oi-eyedropper"></span></a> <a href="user.php?id={$log_user}"><span class="oi oi-person"></span></a></td></tr>
	<tr><td>IP Address</td><td>{$log_ip} <a href="qform_log.php?w=ip&amp;h={$log_ip}"><span class="oi oi-eyedropper"></span></a> <a href="iplog.php?w=ip&h={$log_ip}"><span class="glyphicon glyphicon-globe"></span></a></td></tr>
	<tr><td>Title</td><td>{$log_title} <a href="qform_log.php?w=pid&amp;h={$log_file}&amp;pid={$log_pid}"><span class="oi oi-eyedropper"></span></a> <a href="{$log_file}?id={$log_pid}"><span class="glyphicon glyphicon-pencil"></span></td></tr>
	<tr><td>Action</td><td><a href="qform_log.php?w=action&amp;h={$log_action}">{$log_action_def}</a></td></tr>
	<tr><td>Restore</td><td><a href="#" onclick="confirm_restore({$log_id})"><span class="glyphicon glyphicon-cloud-download"></span> Restore this Entry</a></td></tr>
	<tr><td>Remove</td><td><a href="qform_log.php?cmd=del&amp;log_id={$log_id}&amp;AXSRF_token={$axsrf}" class="text-danger"><span class="glyphicon glyphicon-trash"></span> Remove this Log</a></td></tr>
	<tr class="nohover"><td colspan="2">{$values}</td></tr>
</table>
</div>

<script>
	function reveal (w)
	{
		x = $("#"+w+"-change").css("display");
		if (x == 'none')
		{
			$("#"+w+"-change").show();
			$("#"+w+"-new").hide();
		}
		else
		{
			$("#"+w+"-change").hide();
			$("#"+w+"-new").show();
		}
	}
</script>
<!-- ENDIF -->