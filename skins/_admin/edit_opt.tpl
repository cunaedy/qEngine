<form method="post" action="edit_opt.php" class="form-inline">
<input type="hidden" name="fid" value="{$fid}" />
<input type="hidden" name="cmd" value="save" />
<table class="table">
 <tr><th>ID</th><th class="text-capitalize">{$title}</th><th class="text-center">Remove</th></tr>
<!-- BEGINBLOCK list -->
 <tr>
  <td>{$idx}</td>
  <td><div class="form-group"><input type="text" name="value_{$idx}" value="{$config_value}" size="40" class="form-control" /></div></td>
  <td class="text-center"><a href="edit_opt.php?cmd=del&amp;idx={$idx}&amp;AXSRF_token={$axsrf}" class="text-danger"><span class="oi oi-x"></span></a></td>
 </tr>
<!-- ENDBLOCK -->
<!-- BEGINBLOCK new -->
 <tr>
  <td></td>
  <td><div class="form-group"><input type="text" name="value_{$idx}" value="" size="40" class="form-control" /></div></td>
  <td class="text-center"></td>
 </tr>
<!-- ENDBLOCK -->
</table>
<p class="text-center"><button type="submit" class="btn btn-primary">Save</button>
<button type="reset" class="btn btn-danger">Reset</button></p>
</form>