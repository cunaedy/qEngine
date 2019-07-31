{$breadcrumb}

<h1>{$l_login}</h1>
<p>{$l_login_why}</p>
<p class="text-muted">{$l_login_admin_why}</p>
<form method="post" action="{$site_url}/includes/login_process.php" id="login">
	<div class="form-group">
		<label>{$l_username} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="user_id" size="35" maxlength="80" required="required" /></div>

	<div class="form-group">
		<label>{$l_password} <span class="required">&bull;</span></label>
		<input type="password" class="form-control" name="user_passwd" size="35" maxlength="80" required="required" /></div>

	<div class="form-group">
		<label>{$l_enter_captcha} <span class="required">&bull;</span></label>
		<div><img src="visual.php" alt="captcha" /></div><input type="text" class="form-control" name="qvc" size="5" maxlength="5" required="required" />
	</div>

	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_login}</button></p>
	<p class="text-center"><a href="{$site_url}/profile.php?mode=lost">{$l_lost_passwd}</a></p>
</form>

<h1>{$l_register}</h1>
<p class="text-center"><a href="{$site_url}/profile.php?mode=register" class="btn btn-success">{$l_register_now}</a></p>