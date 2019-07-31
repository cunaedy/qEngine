<script type="text/javascript">
//<![CDATA[
function confirm_delete ()
{
	c = window.confirm ("Do you wish to clear all logs?\nThis process can not be undone!");
	if (!c) return false;
	document.location = "iplog.php?mode=delall&AXSRF_token={$axsrf}";
}
//]]>
</script>
<div class="card">
   <div class="card-header">Login Log</div>
   <table class="table table-bordered" id="result">
   	  <tr><th colspan="6"><a href="iplog.php"><span class="oi oi-reload"></span> Reset Filters</a></th></tr>
	  <tr><th width="5%">ID</th>
		  <th width="23%">Time</th>
		  <th width="22%">IP Address</th>
		  <th width="23%">User ID</th>
		  <th width="22%">Status</th>
		  <th width="5%">Remove</th></tr>

		<!-- BEGINBLOCK log_item -->
		<tr>
			<td>{$idx}</td>
			<td>{$log_time}</td>
			<td><a href="iplog.php?w=ip&amp;h={$log_ip_addr}">{$log_ip_addr}</a></td>
			<td>{$log_user_id} ({$log_user_type})</td>
			<td>{$log_success}</td>
			<td class="text-center"><a href="iplog.php?mode=del&amp;log_id={$idx}&amp;AXSRF_token={$axsrf}"><span class="oi oi-x"></span></a></td>
		</tr>
		<!-- ENDBLOCK -->
	</table>
	<div class="card-footer">
		{$pagination}
		<p><a href="#page" onclick="confirm_delete()" class="btn btn-danger alert-link"><span class="oi oi-x"></span> Remove all logs</a></p>
	</div>
</div>