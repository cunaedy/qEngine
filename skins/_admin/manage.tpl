<!-- BEGINIF $module_engine -->
<!-- ELSE -->
<div class="alert alert-danger"><span class="oi oi-warning"></span> Module Engine is disabled in Primary Config. All modules will be disabled!</div>
<!-- ENDIF -->

<!-- BEGINIF $module_man -->
<!-- ELSE -->
<div class="alert alert-danger"><span class="oi oi-warning"></span> Module Manager is disabled in Primary Config. All settings &amp; modules in this page will be ignored!</div>
<!-- ENDIF -->
<div class="card">
	<div class="card-header"><span class="oi oi-cog" aria-hidden="true"></span> Module Manager</div>
	<div class="card-body">
		<ul class="list_2">
			<li>Use this form to position your modules in the UI.</li>
			<li><a href="{$skin_info}" class="popiframe">Show current skin module position.</a> [ <a href="{$skin_info}" target="_blank">new window</a> ]</li>
		</ul>
	</div>

	<form method="post" action="manage.php">
	<input type="hidden" name="cmd" value="save" />
	<div class="row">
		<div class="col-md-12">
			<table class="table">
				<tr><th>Top 1</th>{$mod_T1_form}</tr>
			</table>
		</div>
		<div class="col-md-12">
			<table class="table">
				<tr><th>Top 2</th>{$mod_T2_form}</tr>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<table class="table">
				<tr>
					<th>Left 1</th>
				</tr>
				{$mod_L1_form}
			</table>
		</div>
		<div class="col-md-3">
			<table class="table">
				<tr>
					<th>Left 2</th>
				</tr>
				{$mod_L2_form}
			</table>
		</div>
		<div class="col-md-3">
			<table class="table">
				<tr>
					<th>Right 1</th>
				</tr>
				{$mod_R1_form}
			</table>
		</div>
		<div class="col-md-3">
			<table class="table">
				<tr>
					<th>Right 2</th>
				</tr>
				{$mod_R2_form}
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<table class="table">
				<tr>
					<th>Bottom 1</th>{$mod_B1_form}
				</tr>
			</table>
		</div>
		<div class="col-md-12">
			<table class="table">
				<tr><th>Bottom 2</th>{$mod_B2_form}</tr>
			</table>
		</div>
	</div>
	<p class="text-center"><button type="submit" class="btn btn-primary">Save Changes</button></p>
	</form>
</div>
<script>
$(function(){
	var h = $.urlParam ('highlight');
	if (h) { $('#mod_id_'+h).addClass('manage_highlight'); setTimeout (function () {$('#mod_popup_'+h).trigger('click')}, 1000); }
})
</script>

<!-- BEGINSECTION mod_man_hor -->
	<td style="height:50px">{$mod_select}</td>
<!-- ENDSECTION -->

<!-- BEGINSECTION mod_man_hor_2 -->
	<td style="height:50px" id="mod_id_{$idx}">
		<a href="manage.php?cmd=edit&amp;idx={$idx}" class="popiframe_s" id="mod_popup_{$idx}"><span class="oi oi-list tips" title="Edit properties"></span></a>
		<a href="manage.php?cmd=del&amp;idx={$idx}"><span class="oi oi-x text-danger tips" title="Remove module"></span></a>
		<span class="tips" title="{$mod_def}">{$mod_name}</span>
	</td>
<!-- ENDSECTION -->

<!-- BEGINSECTION mod_man_ver -->
	<tr><td style="height:50px">{$mod_select}</td></tr>
<!-- ENDSECTION -->

<!-- BEGINSECTION mod_man_ver_2 -->
	<tr><td style="height:50px" id="mod_id_{$idx}">
		<a href="manage.php?cmd=edit&amp;idx={$idx}" class="popiframe_s" id="mod_popup_{$idx}"><span class="oi oi-list tips" title="Edit properties"></span></a>
		<a href="manage.php?cmd=del&amp;idx={$idx}"><span class="oi oi-x text-danger tips" title="Remove module"></span></a>
		<span class="tips" title="{$mod_def}">{$mod_name}</span>
	</td></tr>
<!-- ENDSECTION -->

<!-- BEGINSECTION mod_man_edit -->
	<form method="post" action="manage.php">
	<input type="hidden" name="cmd" value="save_config" />
	<input type="hidden" name="idx" value="{$idx}" />
	<table class="table" class="table" style="background:#fff">
		<tr>
			<td>Display Title</td><td><input type="text" name="mod_title" size="26" value="{$mod_title}"/></td>
		</tr>
		<tr>
			<td>Configuration</td><td><span class="oi oi-info help tips"></span> <small><a href="modplug_doku.php?what=module&mod_id={$mod_id}" target="_blank">See module documentation for module configurations</a></small></td>
		</tr>
		<tr>
			<td colspan="2"><textarea name="mod_config" style="height:170px;width:100%">{$mod_config}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center"><button type="submit" class="btn btn-primary">Save</button></td>
		</tr>
	</table>
	</form>
<!-- ENDSECTION -->