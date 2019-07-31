<form method="post" action="sendmail.php">
	<input type="hidden" name="mode" value="{$mode}" />
	<div class="card">
		<div class="card-header"><span class="oi oi-envelope-open" aria-hidden="true"></span> Send Email</div>
		<div class="card-body">

			<div class="form-group row"><label class="col-md-3 col-form-label">Send Email to</label>
				<div class="col-md-9"><input type="text" size="50" name="name" value="{$user_id}" class="form-control" /></div>
			</div>

			<div class="form-group row"><label class="col-md-3 col-form-label">Email address</label>
				<div class="col-md-9"><input type="text" size="50" name="email" value="{$user_email}" class="form-control" /></div>
			</div>

			<div class="form-group row"><label class="col-md-3 col-form-label">Subject</label>
				<div class="col-md-9"><input type="text" size="50" name="subject" value="{$subject}" class="form-control" /></div>
			</div>

			<div class="form-group row"><label class="col-md-3 col-form-label">Message</label>
				<div class="col-md-9">{$email_body}</div>
			</div>
		</div>
		<div class="card-footer">
			<button type="submit" class="btn btn-primary">Submit</button>
			<button type="reset" class="btn btn-danger">Reset</button>
		</div>
	</div>
</form>