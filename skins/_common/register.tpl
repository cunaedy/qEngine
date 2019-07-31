{$breadcrumb}

<h1>{$l_register}</h1>
<form method="post" action="{$site_url}/includes/register_process.php">
	<div class="form-group">
		<label>{$l_username} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="user_id" id="user_id" value="{$user_id}" size="31" maxlength="80" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_password} <span class="required">&bull;</span></label>
		<input type="password" class="form-control" name="user_passwd" id="user_passwd" size="29" maxlength="255" onkeyup="passwordStrength('user_passwd',this.value)" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_email_address} <span class="required">&bull;</span></label>
		<input type="email" class="form-control" name="user_email" id="user_email" value="{$user_email}" size="42" maxlength="255" required="required" /> <span id="user_email_ok"></span>
	</div>
	<div class="form-group">
		<label>{$l_enter_captcha} <span class="required">&bull;</span></label>
		<div><img src="visual.php" alt="robot?" /></div><input type="text" class="form-control" name="visual" size="5" maxlength="5" required="required" />
	</div>
	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_register}</button></p>
</form>

<script>
	$('#user_id').blur(function () {
		validateByAjax('#user_id', '{$site_url}/ajax.php?cmd=userOk');
	});
	$('#user_email').blur(function () {
		validateByAjax('#user_email', '{$site_url}/ajax.php?cmd=emailOk');
	});
</script>