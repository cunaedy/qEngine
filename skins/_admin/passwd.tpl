<form method="post" action="passwd.php">
	<input type="hidden" name="cmd" value="change" />
	<div class="card">
		<div class="card-header"><span class="oi oi-key" aria-hidden="true"></span> Change Admin Password</div>
		<div class="card-body">
			<div class="form-group row"><label class="col-md-3 col-form-label">Current Password</label>
				<div class="col-md-9"><input type="password" name="curr_passwd" required class="form-control" /></div>
			</div>
			<div class="form-group row"><label class="col-md-3 col-form-label">New Password</label>
					<div class="col-md-9"><input type="password" name="new_passwd" id="new_passwd" maxlength="255" class="form-control" onkeyup="passwordStrength('new_passwd',this.value)" required /></div>
			</div>
		</div>
		<div class="card-footer"><button type="submit" class="btn btn-primary">Submit</button></div>
	</div>
</form>