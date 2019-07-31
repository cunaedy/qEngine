{$breadcrumb}

<h1>{$l_manage_profile}</h1>
<p>{$l_manage_profile_why}</p>
<form method="post" action="{$site_url}/includes/update_profile.php" class="form-horizontal">
	<p>{$l_profile_enter_passwd}</p>

	<div class="form-group">
		<label for="user_id">{$l_username}</label>
		<div class="input-group">
			<div class="input-group-prepend"><span class="input-group-text"><span class="oi oi-person"></span></span></div>
			<input id="user_id" name="user_id" class="form-control" type="text" value="{$user_id}" disabled>
		</div>
	</div>

	<div class="form-group">
		<label for="user_email">{$l_email_address}</label>
		<div class="input-group">
			<div class="input-group-prepend"><span class="input-group-text"><span class="oi oi-envelope-closed"></span></span></div>
			<input id="user_email" name="user_email" id="user_email" value="{$user_email}" class="form-control" type="email" required>
		</div>
	</div>

	<div class="form-group">
		<label for="user_passwd">{$l_current_password}</label>
		<div class="input-group">
			<div class="input-group-prepend"><span class="input-group-text"><span class="oi oi-lock-locked"></span></span></div>
			<input id="user_passwd" name="user_passwd" class="form-control" type="password" required>
		</div>
	</div>

	<div class="form-group">
		<label for="new_user_passwd">{$l_new_password}</label>
		<div class="input-group">
			<div class="input-group-prepend"><span class="input-group-text"><span class="oi oi-lock-locked"></span></span></div>
			<input id="new_user_passwd" name="new_user_passwd" class="form-control" type="password" onkeyup="passwordStrength('new_user_passwd',this.value)">
		</div>
	</div>

	<div class="form-group">
		<label for="confirm_user_passwd">{$l_confirm_password}</label>
		<div class="input-group">
			<div class="input-group-prepend"><span class="input-group-text"><span class="oi oi-lock-locked"></span></span></div>
			<input id="confirm_user_passwd" name="confirm_new_user_passwd" class="form-control" type="password">
		</div>
	</div>

	<div class="form-group">
		<label for="btn"></label>
		<div class="text-center">
			<button id="btn" name="btn" class="btn btn-primary">{$l_submit}</button>
		</div>
	</div>
</form>

<script>
	$('#user_email').blur(function () {
		validateByAjax('#user_email', '{$site_url}/ajax.php?cmd=emailOk&uid={$user_id}');
	});
</script>