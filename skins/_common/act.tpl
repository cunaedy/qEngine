{$breadcrumb}

<h1>{$l_account_act}</h1>
<p>{$l_account_act_why}</p>
<form method="post" action="{$site_url}/includes/act_process.php">
	<div class="form-group">
		<label>{$l_username} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="user_id" value="{$user_id}" size="50" maxlength="255" required="required" class="username" />
	</div>
	<div class="form-group">
		<label>{$l_account_act_key} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="act" value="{$act}" size="50" maxlength="16" required="required" class="password" />
		<small class="form-text text-muted">{$l_account_act_key_why}</small>
	</div>
	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_submit}</button></p>
</form>