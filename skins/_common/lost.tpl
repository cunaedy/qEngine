{$breadcrumb}

<!-- BEGINIF $tpl_mode == 'lost' -->
<h1>{$l_lost_passwd}</h1>
<form method="post" action="{$site_url}/includes/lost_process.php" style="margin:auto">
	<div class="form-group">
		<label>{$l_username} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="user_id" size="50" maxlength="80" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_enter_captcha} <span class="required">&bull;</span></label>
		<div><img src="visual.php" alt="captcha" /></div><input type="text" class="form-control" name="qvc" size="5" maxlength="5" required="required" />
	</div>
	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_submit}</button></p>
</form>
<!-- ENDIF -->


<!-- BEGINIF $tpl_mode == 'reset' -->
<h1>{$l_reset_passwd}</h1>
<form method="post" action="{$site_url}/includes/lost_process.php" style="margin:auto">
	<input type="hidden" name="do_reset" value="1" />
	<div class="form-group">
		<label>{$l_username} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="user_id" value="{$user_id}" size="50" maxlength="80" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_reset_code} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="reset" value="{$reset}" size="50" maxlength="80" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_new_password} <span class="required">&bull;</span></label>
		<input type="password" class="form-control" name="user_passwd" id="user_passwd" size="50" maxlength="80" required="required" onkeyup="passwordStrength('user_passwd', this.value)" />
	</div>
	<div class="form-group">
		<label>{$l_enter_captcha} <span class="required">&bull;</span></label>
		<div><img src="visual.php" alt="captcha" /></div><input type="text" class="form-control" name="qvc" size="5" maxlength="5" required="required" />
	</div>
	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_submit}</button></p>
</form>
<!-- ENDIF -->