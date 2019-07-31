{$breadcrumb}

<h1>{$l_tell_friend}</h1>
<form method="post" action="{$site_url}/tell.php">
	<input type="hidden" name="item_id" value="0" />
	<input type="hidden" name="contact_us" value="0" />
	<input type="hidden" name="cmd" value="send" />
	<div class="form-group">
		<label>{$l_your_name} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="name" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_your_email} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="email" value="{$user_email}" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_friend_name} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="friend_name" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_friend_email} <span class="required">&bull;</span></label>
		<input type="text" class="form-control" name="friend_email" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_message}</label>
		<textarea class="form-control" name="tell_body"></textarea>
	</div>
	<div class="form-group">
		<label>{$l_enter_captcha} <span class="required">&bull;</span></label>
		<div><img src="visual.php" alt="captcha" /></div><input type="text" class="form-control" name="visual" size="3" maxlength="3" required="required" />
	</div>

	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_submit}</button></p>
</form>