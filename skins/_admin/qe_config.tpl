<h2 class="card-title"><span class="oi oi-wrench" aria-hidden="true"></span> Primary Settings</h2>
<form method="post" action="qe_config_process.php" enctype="multipart/form-data" name="qe_config">
	<div class="card">
		<div class="card-header">
			<ul id="qadmin_tab" class="nav nav-tabs card-header-tabs">
				<li class="nav-item"><a href="#tab1" class="nav-link active"><span class="oi oi-home"></span> Site Info</a></li>
				<li class="nav-item"><a href="#tab2" class="nav-link">Engine Settings</a></li>
				<li class="nav-item"><a href="#tab3" class="nav-link">Look &amp; Feel</a></li>
				<li class="nav-item"><a href="#tab4" class="nav-link">API</a></li>
				<li class="nav-item"><a href="#tab5" class="nav-link">Advanced</a></li>
			</ul>
		</div>
		<div class="card-body">
			<div class="tab-content">
				<div class="tab-pane active" id="tab1">
					<h5 class="card-title">Site Information</h5>
					<div class="form-group row"><label class="col-md-3 col-form-label">Site URL / Domain Name</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_url" maxlength="255" value="{$site_url}" />
							<small class="form-text text-muted">End without '/' Don't change if you aren't sure. Don't
								forget the www prefix (if needed)! HTTPS recommended.</small></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Absolute Path</label>
						<div class="col-md-9"><input type="text" class="form-control" name="abs_path" maxlength="255" value="{$abs_path}" />
							<small class="form-text text-muted">End without &#39;/&#39;. Use / instead of \. Don't
								change if you aren't sure.</small></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Site Name</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_name" maxlength="255" value="{$site_name}" /></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Site Slogan</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_slogan" maxlength="255" value="{$site_slogan}" /></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Site Description</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_description" maxlength="255" value="{$site_description}" /></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Site Keywords</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_keywords" maxlength="255" value="{$site_keywords}" />
							<small class="form-text text-muted">Useful for Search Engine Optimization.</small></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Site Email Address </label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_email" maxlength="255" value="{$site_email}" /></div>
					</div>

					<h5 class="card-title">Site Address</h5>
					<div class="form-group row"><label class="col-md-3 col-form-label">Address (line 1)</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_address" maxlength="255" value="{$site_address}" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Address (line 2)</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_address2" maxlength="255" value="{$site_address2}" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">City</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_city" maxlength="255" value="{$site_city}" size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Post / Zip Code </label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_zip" maxlength="255" value="{$site_zip}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">County / State</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_state" maxlength="255" value="{$site_state}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Country</label>
						<div class="col-md-9">{$country_select}</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Telephone</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_phone" maxlength="255" value="{$site_phone}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Fax</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_fax" maxlength="255" value="{$site_fax}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Mobile / Cell Phone Number
						</label>
						<div class="col-md-9"><input type="text" class="form-control" name="site_mobile" maxlength="255" value="{$site_mobile}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Close this Site</label>
						<div class="col-md-9">{$close_select}
							<small class="form-text text-muted">Temporarily close your site. A message will be displayed
								to any visitors suggesting that they should try visiting again soon.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Debug Mode</label>
						<div class="col-md-9">{$debug_select}
							<small class="form-text text-muted">Enable debug mode to show errors, and see developer
								oriented information.</small></div>
					</div>
				</div>

				<div class="tab-pane" id="tab2">
					<h5 class="card-title">Locale</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">Default Language</label>
						<div class="col-md-9">{$default_lang_select}
							<small class="form-text text-muted">You can add more language in Tools &gt; Language
								Editor.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">National Weight Name</label>
						<div class="col-md-9"><input type="text" class="form-control" name="weight_name" value="{$weight_name}"size="20" />
							<small class="form-text text-muted">Enter the units you use to measure Weight. For example: kgs,
								lbs, units, sets, items, etc.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">National Currency Name</label>
						<div class="col-md-9"><input type="text" class="form-control" name="num_curr_name" size="20" value="{$num_curr_name}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">National Currency Symbol</label>
						<div class="col-md-9"><input type="text" class="form-control" name="num_currency" value="{$num_currency}"size="20" />
							<small class="form-text text-muted">Use html escaped symbols. Eg, for &pound; use
								&amp;&#173;pound;. For &euro; use &amp;&#173;euro;</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Decimal Digits</label>
						<div class="col-md-9">{$num_decimals_select}
							<small class="form-text text-muted">The number of decimal places used after the decimal
								seperator in your currency. For example, a number of 12.3456, will be displayed 12.35 if you enter 2.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Decimal Pointer</label>
						<div class="col-md-9">{$num_dec_point_select}
							<small class="form-text text-muted">The pointer used to seperate the full units and the decimal
								digits.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Thousands Separator</label>
						<div class="col-md-9">{$num_thousands_sep_select}
							<small class="form-text text-muted">The pointer used to seperate every three figures. For
								example, a
								number of 1234, will be displayed 1 234 if you use blank space.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Location of Currency Symbol</label>
						<div class="col-md-9">{$curr_pos_select}</div>
					</div>

					<h5 class="card-title">User Management</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">Registration Requires Email
							Confirmation</label>
						<div class="col-md-9">{$active_radio}
							<small class="form-text text-muted">Determine if you want newly registered users to confirm their
								email address by sending an activation email.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Log All Outgoing Emails?</label>
						<div class="col-md-9">{$mailog_radio}
							<small class="form-text text-muted">This will log all outgoing email sent via qEngine, Some private
								emails will not be logged.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Log All Modifications?</label>
						<div class="col-md-9">{$qform_log_radio}
							<small class="form-text text-muted">This will log all modification made via qEngine ACP (script
								dependent).</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Use Detailed Logs?</label>
						<div class="col-md-9">{$qform_detail_log_radio}
							<small class="form-text text-muted">Enable detailed log to store all previous values so you can
								compare &amp; restore them easily. May produce a very big log table!"></small></div>
					</div>

					<h5 class="card-title">Site Optimisation</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">Enable Gzip Header</label>
						<div class="col-md-9">{$enable_gzip_select}
							<small class="form-text text-muted">A GZIP header will speed up the downloads of your site by
								compressing the whole page before having it sent to the users.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Enable Inline Editing</label>
						<div class="col-md-9">{$enable_inline_select}
							<small class="form-text text-muted">Complex web site may want to disable inline editing.</small>
						</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Disable Browser Cache?</label>
						<div class="col-md-9">{$disable_browser_cache}
							<small class="form-text text-muted">Enabling browser cache may increase site performance.</small>
						</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Enable Search Engine Friendly URLS (SEF
							URL)</label>
						<div class="col-md-9">{$enable_adp_select}
							<small class="form-text text-muted">Enabling ADP will make your URL be search engine friendly.
								Remember to rename /_htaccess file to /.htaccess.</small>
						</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Default file extension for SEF
							URL</label>
						<div class="col-md-9"><input type="text" class="form-control" name="adp_extension" value="{$adp_extension}"size="20" />
							<small class="form-text text-muted">SEF URL will generate virtual files. Set your desired file
								extension. This only affect new pages, existing pages will not be affected.</small>
						</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Regenerate Script Cache</label>
						<div class="col-md-9"><div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">Every</span></div>
							<input type="text" class="form-control" name="cache" size="5" value="{$cache}"size="20" />
							<div class="input-group-prepend"><span class="input-group-text">seconds</span></div></div>
							<small class="form-text text-muted">qEngine stores cache to improve performance. Enter 0 to disable
								or when developing your site.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Allow these files to be uploaded</label>
						<div class="col-md-9"><input type="text" class="form-control" name="allowed_file" size="50" maxlength="255" value="{$allowed_file}" />
							<small class="form-text text-muted">To improve site security, your users should not be able to
								upload some file types for custom field.</small></div>
					</div>
				</div>

				<div class="tab-pane" id="tab3">

					<h5 class="card-title">Company Logo</h5>
					<div class="form-group row"><label class="col-md-3 col-form-label">Logo</label>
						<div class="col-md-9">{$company_logo}<br /><input type="file" name="company_logo" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Small Logo</label>
						<div class="col-md-9">{$favicon}<br /><input type="file" name="favicon" />
							<small class="form-text text-muted">(recommended 152x152 pixels, 24-bit transparent PNG)</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Watermark</label>
						<div class="col-md-9">{$watermark}
							<!-- BEGINIF $isWatermark -->
							<div><a href="qe_config.php?cmd=del_watermark"><span class="oi oi-x"></span> Remove File</a></div>
							<!-- ELSE -->
							<div><input type="file" name="watermark_file" /></div>
							<!-- ENDIF -->
							<small class="form-text text-muted">All uploaded images will be watermarked with this image. Recommended watermark file: 24-bit transparent PNG @ 100x100 px</small>
						</div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Watermark Position</label>
						<div class="col-md-9">{$watermark_pos_select}</div>
					</div>

					<h5 class="card-title">Layout</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">Template</label>
						<div class="col-md-9">{$skin_select}</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Use WYSIWYG Editor in Admin Control
							Panel</label>
						<div class="col-md-9">{$wysiwyg_select}</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Enable Mobile Version Skin?</label>
						<div class="col-md-9">{$mobile_version}
							<small class="form-text text-muted">Default skin of qEngine uses responsive layout that adapt to any
								devices (PCs, tablets, phones). But if you prefer to use different skin for mobile, please
								enable this setting, and put your mobile skin files in /skins/_mobile folder.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Display member only content in page
							list?</label>
						<div class="col-md-9">{$allow_locked_page_radio}
							<small class="form-text text-muted">Choose Yes to display the content title in page list. Contents
								still not visible to guests.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Breadcrumbs Separator</label>
						<div class="col-md-9"><input type="text" class="form-control" name="cat_separator" value="{$cat_separator}"size="20" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Items per page</label>
						<div class="col-md-9">
							<div class="input-group"><input type="text" class="form-control" name="list_ipp" value="{$list_ipp}"size="20" />
								<div class="input-group-append"><span class="input-group-text">items</span></div>
							</div>
							<small class="form-text text-muted">The number of items that can be displayed on every page.</small>
						</div>
					</div>

					<h5 class="card-title">Graphics</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">GD version</label>
						<div class="col-md-9">{$gd_select} <small class="form-text text-muted">Confirm which version of GD
								Library you have installed. Be sure to know which version of GD you have. See your PHP info for
								more information</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Image Optimizer Quality</label>
						<div class="col-md-9">{$optimizer_select} <small class="form-text text-muted">Requires GD version 2 or
								higher.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Thumbnail Quality</label>
						<div class="col-md-9">{$thumb_quality_select} <small class="form-text text-muted">Use this to set the
								quality of your product images. High quality images are larger in size.</small></div>
					</div>

					<div class="form-group row"><label class="col-md-3 col-form-label">Thumbnail Size</label>
						<div class="col-md-9">
							<div class="input-group"><input type="text" class="form-control" name="thumb_size" value="{$thumb_size}" size="20" />
								<div class="input-group-append"><span class="input-group-text">pixels</span></div>
							</div>
						</div>
					</div>
				</div>

				<div class="tab-pane" id="tab4">
					<h5 class="card-title">Email Server Configuration</h5>
					<div class="form-group row"><label class="col-md-3 col-form-label">Send Emails Using SMTP Server?</label>
						<div class="col-md-9">{$smtp_email}
							<small class="form-text text-muted">Choose Yes to send email using your own SMTP server. Choose No to use
								internal PHP mailer service.</small>
						</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">SMTP Authentication Type</label>
						<div class="col-md-9">{$smtp_secure}</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">SMTP Server</label>
						<div class="col-md-9"><input type="text" class="form-control" size="20" name="smtp_server" value="{$smtp_server}" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">SMTP Port</label>
						<div class="col-md-9"><input type="text" class="form-control" name="smtp_port" value="{$smtp_port}"size="20" />
							<small class="form-text text-muted">Usually: 25 - for No Authentication, 465 - for SSL, 587 or 995 -
								for TLS.</small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">SMTP Username</label>
						<div class="col-md-9"><input type="text" class="form-control" size="20" name="smtp_user" value="{$smtp_user}" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">SMTP Password</label>
						<div class="col-md-9"><input type="text" class="form-control" size="20" name="smtp_passwd" value="{$smtp_passwd}" /></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">SMTP Sender Email</label>
						<div class="col-md-9"><input type="text" class="form-control" size="20" name="smtp_sender" value="{$smtp_sender}" /></div>
					</div>

					<h5 class="card-title">Social Media Integration</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">Enable Facebook Like &amp; Share?</label>
						<div class="col-md-9">{$facebook_like}</div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Replace qEngine Comments with Facebook Comments?</label>
						<div class="col-md-9">{$facebook_comment}
							<small class="form-text text-muted">Some features may rely on qEngine comments." ></small></div>
					</div>
					<div class="form-group row"><label class="col-md-3 col-form-label">Enable Twitter Share (tweet)?</label>
						<div class="col-md-9">{$twitter_share}</div>
					</div>

					<h5 class="card-title">Other Integration</h5>

					<div class="form-group row"><label class="col-md-3 col-form-label">Google Maps API Key</label>
						<div class="col-md-9"><input type="text" class="form-control" name="gmap_api" value="{$gmap_api}" />
							<small class="form-text text-muted">You only need this if you need to enable Google Map Picker function. Get
								your key from https://developers.google.com"></small></div>
					</div>
				</div>

				<div class="tab-pane" id="tab5">
					<div class="alert alert-warning">Disabling these settings will increase your site performance by sacrificing some conveniences.</div>
					<h5 class="card-title">Module Manager</h5>
					<p>You can disable module manager to increase site performance. Module Manager is a function accessed from:
						ACP &gt; Modules &gt; Layout. If you disable this, you can't add/modify/delete any modules from ACP &gt;
						Modules &gt; Layout</p>
					<p>You can still add modules manually by using &lt;-- BEGINMODULE --&gt;&lt;-- ENDMODULE --&gt;. See module
						documentation for more
						information.</p>
					<p>Enable module manager? {$module_man_radio}</p>

					<h5 class="card-title">Module Engine</h5>
					<p>You can disable module engine to increase site performance. If you don't need any modules, you
						can disable module engine altogether.</p>
					<p>Disabling module engine will remove module supports from your site, and you can't use modules
						anywhere.</p>
					<p>Enable module engine? {$module_engine_radio}</p>
				</div>
			</div>
		</div>
		<div class="card-footer"><button type="submit" class="btn btn-primary">Submit</button> <button type="reset" class="btn btn-danger">Reset</button></div>
	</div>
</form>

<script>
	$('input[type=text]').each(function (){s = $(this).attr('size'); if (s < 50) s = (s*15) + 'px'; else s = '100%'; $(this).css ('max-width', s).css ('min-width', '100px')});
	$('#qadmin_tab a').on('click', function (e) {
		e.preventDefault()
		$(this).tab('show')
	})
</script>