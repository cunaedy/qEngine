{$breadcrumb}

<h1>{$l_contact_us}</h1>
<!-- BEGINMODULE page_gallery -->
// Contact text
page_id = 6
body = 1
<!-- ENDMODULE -->

<p><b>{$site_name}</b></p>
{$site_address}

<hr />
<p>{$l_contact_us_form}</p>
<form method="post" action="{$site_url}/contact.php">
	<input type="hidden" name="cmd" value="send" />
	<div class="form-group">
		<label>{$l_your_name} <span class="required">&bull;</span></label>
			<input type="text" class="form-control" name="name" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_email_address} <span class="required">&bull;</span></label>
			<input type="email" class="form-control" name="email" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_subject}</label>
			<input type="text" class="form-control" name="subject" required="required" />
	</div>
	<div class="form-group">
		<label>{$l_message} <span class="required">&bull;</span></label>
			<textarea name="body" class="form-control" required="required"></textarea>
	</div>
	<div class="form-group">
		<label>{$l_enter_captcha} <span class="required">&bull;</span></label>
			<div><img src="visual.php" alt="captcha" /></div><input type="text" class="form-control" name="visual" size="3" maxlength="3" required="required" />
	</div>
	<p class="text-center"><button type="submit" class="btn btn-primary">{$l_submit}</button></p>
</form>