<!-- COMMENTS -->
EZD is a 'component' version of CForm (was qAdmin).
When you are using CForm, you don't need a separate .tpl file to display the generated form, but you can't change the designs, positions & layout.
EZD on the other hand, need a separate .tpl file, but you gain more flexibility in positioning & designing the form.

Usage:
- Similar to normal CForm (see qadmin_demo.php)
- Add a config:
$qadmin_cfg['ezd_mode'] = true;	// or $qform_cfg

- Load tpl & flush
$tpl = load_tpl('my-ezd-form.tpl');
$txt['main_body'] = quick_tpl($tpl, $tpl_var_from_qadmin_manage); 	// or $tpl_var_from_cform_manage
flush_tpl();

- In my-ezd-form.tpl, use: {$ezd_form_field_name} to display the related form field.
<!-- /COMMENTS -->

<!-- BEGINSECTION ezd_head -->
<script>
function confirm_remove ()
{
	c = window.confirm ("Do you wish to remove this item?\nThis process can not be un-done!");
	if (!c) return false;
	document.location = "{$action}qadmin_cmd=remove_item&primary_val={$primary_val}";
}
</script>

<form method="post" name="qadmin_form" id="qadmin_form" action="{$action}" enctype="{$enctype}">
	<input type="hidden" name="qadmin_cmd" value="{$cmd}" />
	<input type="hidden" name="qadmin_process" value="1" />
	<input type="hidden" name="qadmin_savenew" value="0" />
	<input type="hidden" name="primary_key" value="{$primary_key}" />
	<input type="hidden" name="primary_val" value="{$primary_val}" />
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_head_inner -->
<h2><span class="oi oi-pencil"></span> {$title}</h2>
<div class="card">
	<div class="card-header">
		<ul id="qadmin_tab" class="nav nav-tabs card-header-tabs">
			<li class="nav-item"><a href="{$back}" class="nav-link"><span class="oi oi-chevron-left"></span> Back</a></li>
			<li class="nav-item"><a href="#tab1" class="nav-link active"><span class="oi oi-home"></span>  Main</a></li>
			{$tab_list}
		</ul>
	</div>
	<div class="card-body">
		<div class="tab-content">
			<div class="tab-pane active" id="tab1">
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_tab_list_li -->
			<li class="nav-item"><a href="#tab{$i}" class="nav-link">{$title}</a></li>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_divider -->
			</div>

			<div class="tab-pane" id="tab{$tabindex}">
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_required -->
<span style="color:#f00" title="Required field" class="tips"><b>&bull;</b></span>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_required_js -->
 required="required"
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_help -->
 <small class="form-text text-muted">{$help}</small>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_viewfile -->
<div><prefix>{$prefix}</prefix> <span class="form-control">{$value} - {$size} bytes <a href="{$view}" target="_blank"><span class="oi oi-zoom-in"></span> View File</a> <a href="{$remove}"><span class="oi oi-x"></span> Remove</a></span><suffix>{$suffix}</suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_viewimg -->
<div><img src="{$view}" alt="{$value}" class="img-thumbnail" width="200" /></div>
<div><prefix>{$prefix}</prefix> <span class="form-control">{$value} - {$size} bytes <a href="{$view}" class="lightbox" target="_blank"><span class="oi oi-zoom-in"></span> View Image</a> <a href="{$remove}"><span class="oi oi-x"></span> Remove</a></span><suffix>{$suffix}</suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_viewthumb -->
 <div><img src="{$thumb}" alt="{$value}" class="img-thumbnail" /></div>
 <div><prefix>{$prefix}</prefix> <span class="form-control">{$value} - {$size} bytes <a href="{$view}" class="lightbox" target="_blank"><span class="oi oi-zoom-in"></span> View Image</a> <a href="{$remove}"><span class="oi oi-x"></span> Remove</a></span><suffix>{$suffix}</suffix></suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_upload -->
<prefix>{$prefix}</prefix><div class="custom-file">
	<input type="file" class="custom-file-input" id="file_{$field}" name="{$field}" class="form-control" {$required_js} />
	<label class="custom-file-label" for="file_{$field}">Choose file</label></div><suffix>{$suffix}</suffix>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_savenew_button -->
<button type="button" class="btn btn-light" onclick="document.forms['qadmin_form'].qadmin_savenew.value=1;document.forms['qadmin_form'].submit()">Save &amp; New</button>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_echo -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
	<prefix>{$prefix}</prefix><span class="form-control text-muted bg-light">{$value}</span><suffix>{$suffix}</suffix>
	{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_url -->
<div class="form-group" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
	<prefix>{$prefix}</prefix> <input type="url" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /> <suffix>{$suffix}</suffix>
	{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_static -->
<div class="form-group" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
	<input type="hidden" name="{$field}" value="{$value}" />
	<prefix>{$prefix}</prefix> {$value} <suffix>{$suffix}</suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_varchar -->
<div class="form-group has-feedback" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
	<prefix>{$prefix}</prefix><input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /><suffix>{$suffix}</suffix>
	{$ezd_help}
	</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_disabled -->
<div class="form-group has-feedback" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
	<prefix>{$prefix}</prefix><input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" class="form-control" disabled {$required_js} /><suffix>{$suffix}</suffix>
	{$ezd_help}
	</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION ezd_permalink -->
<div class="form-group" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
	<prefix>{$prefix} {$permalink_path}</prefix> <input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /> <suffix>{$suffix}</suffix>
	{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_email -->
<div class="form-group has-feedback" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
<prefix>{$prefix}</prefix> <input type="email" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /> <suffix>{$suffix}</suffix>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_password -->
<div class="form-group" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
<prefix>{$prefix}</prefix> <input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" class="form-control" maxlength="{$maxlength}" autocomplete="new-password" onfocus="this.type='password'" {$disabled} {$required_js} onkeyup="passwordStrength('{$field}', this.value)" /> <suffix>{$suffix}</suffix>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_checkbox -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
<prefix>{$prefix}</prefix><span class="form-control">{$checkbox}</span><suffix>{$suffix}</suffix>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_date -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
<div><prefix>{$prefix}</prefix> {$date_select} <suffix>{$suffix}</suffix></div>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_time -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
<div><prefix>{$prefix}</prefix> {$time_select} <suffix>{$suffix}</suffix></div>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_text -->
<div class="form-group" id="{$thisid}"><label class="control-label" for="{$field}">{$title} {$ezd_required}</label>
	<prefix>{$prefix}</prefix>
	<textarea name="{$field}" id="{$field}" style="height:{$y}px" class="form-control" {$disabled} {$required_js}>{$value}</textarea>
	<suffix>{$suffix}</suffix>
	{$ezd_help}
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_code -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$code_area}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_wysiwyg -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$rte_area}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_select -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
<prefix>{$prefix}</prefix>{$data_select}<suffix>{$edit_opt} {$suffix}</suffix>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_radioh -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
<div>{$data_radio}</div>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_radiov -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$data_radio}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_multi -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
<prefix>{$prefix}</prefix> {$data_multi} <suffix>{$suffix}</suffix>
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_file -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$viewfile}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_img -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$viewimg}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_thumb -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$viewthumb}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_img_resize -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$viewimg}
{$ezd_help}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_img_set -->
<div class="form-group" id="{$thisid}"><label class="control-label">{$title} {$ezd_required}</label>
{$viewimg} {$upload}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_edit_opt -->
<a href="edit_opt.php?fid={$editopt}&amp;title=Options&amp;popup=1" class="popiframe_s"><span class="oi oi-spreadsheet"></span></a>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_remove -->
<a href="#" onclick="confirm_remove()">Remove this item</a>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_foot_inner -->
				</div>
			</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_foot -->
		</div>
		<div class="card-footer">
			<button type="submit" class="btn btn-primary">Save</button> {$savenew_button} <button type="reset" class="btn btn-light">Reset</button>
		</div>
</div>

</form>
{$last_update}
<span style="color:#f00"><b>&bull;</b></span> Denotes required information

<script>
var $input = $('#qadmin_form:input[type=text]');
$input.each(function (){s = $(this).attr('size'); if (s < 50) s = s*15; else s = 650; $(this).css ('max-width', s+'px').css ('min-width', '100px')});
$('#qadmin_tab a').on('click', function (e) {
	e.preventDefault()
	$(this).tab('show')
  })
</script>
<!-- ENDSECTION -->

<!-- BEGINSECTION ezd_last_update -->
<p class="small">This entry has been updated {$log_count}&times;, last updated at {$log_last_time} by {$log_last_user} <a href="cform_log.php?w=pid&amp;h={$fn}&amp;pid={$id}" class="btn btn-default btn-xs small"><span class="glyphicon glyphicon-zoom-in"></span> See Logs</a></p>
<!-- ENDSECTION -->