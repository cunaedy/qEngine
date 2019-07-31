<h2>Language Editor &mdash; [{$lang_name}]</h2>
<div class="card">
	<div class="card-header">
		<ul id="qadmin_tab" class="nav nav-tabs card-header-tabs">
			<li class="nav-item"><a href="lang.php?tab=0&amp;lang_id={$lang_id}" class="nav-link {$class0}">Properties</a></li>
			<li class="nav-item"><a href="lang.php?tab=1&amp;lang_id={$lang_id}" class="nav-link {$class1}">General</a></li>
			<li class="nav-item"><a href="lang.php?tab=2&amp;lang_id={$lang_id}" class="nav-link {$class2}">Date &amp; Time</a></li>
			<li class="nav-item"><a href="lang.php?tab=3&amp;lang_id={$lang_id}" class="nav-link {$class3}">Special</a></li>
			<li class="nav-item"><a href="lang.php?tab=4&amp;lang_id={$lang_id}" class="nav-link {$class4}">Messages</a></li>
			<li class="nav-item"><a href="lang.php?tab=5&amp;lang_id={$lang_id}" class="nav-link {$class5}">Emails</a></li>
			<li class="nav-item"><a href="lang.php?tab=6&amp;lang_id={$lang_id}" class="nav-link {$class6}">Custom</a></li>
		</ul>
	</div>
	<div class="card-body">
		<!-- BEGINIF $tpl_mode == 'properties' -->
		<div class="tab-pane active">
			<form method="post" action="lang.php">
				<input type="hidden" name="tab" value="{$tab}" />
				<input type="hidden" name="lang_id" value="{$lang_id}" />
				<input type="hidden" name="cmd" value="save_properties" />
				<div class="form-group row"><label class="col-md-3 col-form-label">Language ID</label>
					<div class="col-md-9">{$lang_id}</div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Language Name</label>
					<div class="col-md-9"><input type="text" class="form-control" name="lang_name" value="{$lang_name}" style="width:500px" /></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Language short code</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_language_short" value="{$cfg_l_language_short}" style="width:500px" /></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Encoding</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_encoding" value="{$cfg_l_encoding}" style="width:500px" />
						<small class="form-text text-muted">Enter 'utf-8' if you are not sure.</small></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Text direction</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_direction" value="{$cfg_l_direction}" style="width:500px" />
						<small class="form-text text-muted">Enter 'ltr' or 'rtl'.</small></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Mysql encoding</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_mysql_encoding" value="{$cfg_l_mysql_encoding}" style="width:500px" />
						<small class="form-text text-muted">Enter 'utf8' if you are not sure.</small></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Long date format</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_long_date_format" value="{$cfg_l_long_date_format}" style="width:500px" />
						<small class="form-text text-muted">See www.php.net/manual/en/function.date.php for more information.</small></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Short date format</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_short_date_format" value="{$cfg_l_short_date_format}" style="width:500px" />
						<small class="form-text text-muted">See www.php.net/manual/en/function.date.php for more information.</small></div>
				</div>
				<div class="form-group row"><label class="col-md-3 col-form-label">Form date format</label>
					<div class="col-md-9"><input type="text" class="form-control" name="l_select_date_format" value="{$cfg_l_select_date_format}" style="width:500px" />
						<small class="form-text text-muted">M = month, D = day, Y = year.</small></div>
				</div>
			</form>
		</div>
	</div>
	<div class="card-footer">
		<button type="submit" class="btn btn-primary">Save</button>
		<div class="btn-group">
			<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
				Language Tools <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a class="dropdown-item inline" href="#copy_lang">Copy Language</a></li>
				<li><a class="dropdown-item inline" href="#del_lang">Delete Language</a></li>
				<li class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="lang.php?cmd=export&amp;lang_id={$lang_id}">Export Language</a></li>
				<li><a class="dropdown-item inline" href="#import_lang">Import Language</a></li>
			</ul>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
				Load Another Language <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a class="dropdown-item" href="lang.php?tab=0&amp;lang_id=en">English (Default)</a></li>
				<!-- BEGINBLOCK list -->
				<li><a href="lang.php?tab=0&amp;lang_id={$lang_id}" class="dropdown-item">{$lang_value}</a></li>
				<!-- ENDBLOCK -->
			</ul>
		</div>

	</div>
</div>

<div style="display:none">
	<div id="copy_lang" style="padding:20px">
		<form method="get" action="lang.php">
			<input type="hidden" name="cmd" value="copy_lang" />
			<input type="hidden" name="lang_id" value="{$lang_id}" />
			<h1>Copy Current Language [{$lang_name}]</h1>
			<div class="form-group row"><label class="col-md-3 col-form-label">New language ID</label>
				<div class="col-md-9"><input type="text" class="form-control" name="new_lang_id" required /></div>
			</div>
			<div class="form-group row"><label class="col-md-3 col-form-label">New language name</label>
				<div class="col-md-9"><input type="text" class="form-control" name="new_lang_name" required /></div>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>
</div>


<div style="display:none">
	<div id="del_lang" style="padding:20px">
		<form method="get" action="lang.php">
			<input type="hidden" name="cmd" value="del_lang" />
			<input type="hidden" name="lang_id" value="{$lang_id}" />
			<h1>Delete Current Language [{$lang_name}]</h1>
			<p>Are you sure you want to delete this language? This will also <b>reset the default language to English</b>.<br />
				This process can't be undone!</p>
			<button type="submit" class="btn btn-danger">Yes, Remove It</button>
			<button type="submit" class="btn btn-light" onclick="javascript:$.colorbox.close();return false">Cancel</button>
		</form>
	</div>
</div>


<div style="display:none">
	<div id="import_lang" style="padding:20px">
		<form method="post" action="lang.php" enctype="multipart/form-data">
			<input type="hidden" name="cmd" value="import" />
			<input type="hidden" name="lang_id" value="{$lang_id}" />
			<h1>Import New Language</h1>
			<p>Please upload your language pack file (lang_pack.xml): <input type="file" name="xml_file" /></p>
			<p><label><input type="checkbox" name="overwrite" value="1" /> Overwrite old language</label></p>
			<button type="submit" class="btn btn-primary">Import Language</button>
			<button type="submit" class="btn btn-light" onclick="javascript:$.colorbox.close();return false">Cancel</button>
		</form>
	</div>
</div>
<script type="text/javascript">
	$(".inline").colorbox({
		inline: true,
		width: "50%"
	});
</script>
<!-- ENDIF -->

<!-- BEGINIF $tpl_mode == 'custom' -->
		<form method="post" action="lang.php" id="theform">
			<input type="hidden" name="tab" value="{$tab}" />
			<input type="hidden" name="cmd" value="save_custom" />
			<input type="hidden" name="lang_id" value="{$lang_id}" />
			<div class="tab-pane active" style="margin-top:10px">
				<!-- BEGINBLOCK list -->
				<div class="form-group row"><label class="col-md-3 col-form-label">{$lang_key}</label>
					<div class="col-md-9">
						<div class="input-group">
							<input type="text" class="form-control" name="{$lang_key}" value="{$lang_val}" style="width:500px" />
							<div class="input-group-prepend"><span class="input-group-text"><a href="lang.php?cmd=del&amp;lang_id={$lang_id}&amp;id={$lang_key}&amp;AXSRF_token={$axsrf}"><span class="oi oi-x text-danger"></span></a></span></div>
						</div>
					</div>
				</div>
				<!-- ENDBLOCK -->
				<h5 class="card-title">New Fields</h5>
				<p>The following empty fields can be used to define your own custom words. You can define up to 10 new words at once. Please remember the prefix l_</p>
				<!-- BEGINBLOCK empty -->
				<div class="form-group row"><div class="col-md-3"><input type="text" class="form-control" name="ck_{$i}" placeholder="l_" /></div>
					<div class="col-md-9"><input type="text" class="form-control" name="cv_{$i}" /></div>
				</div>
				<!-- ENDBLOCK -->
			</div>
		</form>
	</div>
	<div class="card-footer"><button type="submit" class="btn btn-primary" onclick="document.getElementById('theform').submit()">Save</button></div>
</div>
<!-- ENDIF -->

<!-- BEGINIF $tpl_mode == 'else' -->
		<form method="post" action="lang.php" id="theform">
			<input type="hidden" name="tab" value="{$tab}" />
			<input type="hidden" name="cmd" value="save" />
			<input type="hidden" name="lang_id" value="{$lang_id}" />
			<div class="tab-pane active" style="margin-top:10px">
				<!-- BEGINBLOCK list -->
				<div class="form-group row"><label class="col-md-3 col-form-label">{$lang_key}</label>
					<div class="col-md-9">{$lang_val}</div>
				</div>
				<!-- ENDBLOCK -->
			</div>
		</form>
	</div>
	<div class="card-footer"><button type="submit" class="btn btn-primary" onclick="document.getElementById('theform').submit()">Save</button></div>
</div>

<script>
	function change(id) {
		$input = $("#textbox_" + id)
		$link = $("#change_" + id)
		v = $input.val();
		fid = $input.attr('id');
		fname = $input.attr('name');
		textarea = '<textarea class="form-control" style="height:4rem" id="' + fid + '" name="' + fname + '"></textarea>';
		$input.after(textarea).remove();
		$("#textbox_" + id).val(v);
		$link.remove();
	};
</script>
<!-- ENDIF -->

<!-- BEGINSECTION field_msg -->
<textarea class="form-control" name="{$v}" style="height:4rem">{$val}</textarea>
<!-- ENDSECTION -->

<!-- BEGINSECTION field_mail -->
<textarea  class="form-control" name="{$v}" style="height:7rem">{$val}</textarea>
<!-- ENDSECTION -->

<!-- BEGINSECTION field_normal -->
<div class="input-group">
	<input type="text" class="form-control" name="{$v}" value="{$val}" id="textbox_{$k}"/>
	<div class="input-group-prepend"><span class="input-group-text"><a href="javascript:change({$k})" id="change_{$k}"><span class="oi oi-fullscreen-enter" title="expand"></span></a></span></div>
</div>
<!-- ENDSECTION -->