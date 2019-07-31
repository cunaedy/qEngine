<!-- BEGINSECTION qform_head -->
<script>
function confirm_remove ()
{
	c = window.confirm ("Do you wish to remove this item?\nThis process can not be un-done!");
	if (!c) return false;
	document.location = "{$action}qadmin_cmd=remove_item&primary_val={$primary_val}";
}
</script>

<form method="post" name="qadmin_form" id="qadmin_form" action="{$action}" enctype="{$enctype}" class="form">
	<input type="hidden" name="qadmin_cmd" value="{$cmd}" />
	<input type="hidden" name="qadmin_process" value="1" />
	<input type="hidden" name="qadmin_savenew" value="0" />
	<input type="hidden" name="primary_key" value="{$primary_key}" />
	<input type="hidden" name="primary_val" value="{$primary_val}" />
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_head_inner -->
<h2><span class="oi oi-pencil"></span> {$title}</h2>
<div class="card">
	<div class="card-header">
		<ul id="qadmin_tab" class="nav nav-tabs card-header-tabs">
			<li class="nav-item"><a href="{$back}" class="nav-link url"><span class="oi oi-chevron-left"></span> Back</a></li>
			<li class="nav-item"><a href="#tab1" class="nav-link active"><span class="oi oi-home"></span>  Main</a></li>
			{$tab_list}
		</ul>
	</div>
	<div class="card-body">
		<div class="tab-content">
			<div class="tab-pane active" id="tab1">
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_tab_list_li -->
			<li class="nav-item"><a href="#tab{$i}" class="nav-link">{$title}</a></li>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_divider -->
			</div>

			<div class="tab-pane" id="tab{$tabindex}">
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_required -->
<span style="color:#f00" title="Required field" class="tips"><b>&bull;</b></span>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_required_js -->
required="required"
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_help -->
<small class="form-text text-muted">{$help}</small>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_viewfile -->
<div><prefix>{$prefix}</prefix> <span class="form-control">{$value} - {$size} bytes <a href="{$view}" target="_blank"><span class="oi oi-zoom-in"></span> View File</a> <a href="{$remove}"><span class="oi oi-x"></span> Remove</a></span><suffix>{$suffix}</suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_viewimg -->
<div><img src="{$view}" alt="{$value}" class="img-thumbnail" width="200" /></div>
<div><prefix>{$prefix}</prefix> <span class="form-control">{$value} - {$size} bytes <a href="{$view}" class="lightbox" target="_blank"><span class="oi oi-zoom-in"></span> View Image</a> <a href="{$remove}"><span class="oi oi-x"></span> Remove</a></span><suffix>{$suffix}</suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_viewthumb -->
<div><img src="{$thumb}" alt="{$value}" class="img-thumbnail" /></div>
<div><prefix>{$prefix}</prefix> <span class="form-control">{$value} - {$size} bytes <a href="{$view}" class="lightbox" target="_blank"><span class="oi oi-zoom-in"></span> View Image</a> <a href="{$remove}"><span class="oi oi-x"></span> Remove</a></span><suffix>{$suffix}</suffix></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_upload -->
<prefix>{$prefix}</prefix><div class="custom-file">
	<input type="file" class="custom-file-input" id="file_{$field}" name="{$field}" class="form-control" {$required_js} />
	<label class="custom-file-label" for="file_{$field}">Choose file</label></div><suffix>{$suffix}</suffix>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_savenew_button -->
<button type="button" class="btn btn-light" onclick="document.forms['qadmin_form'].qadmin_savenew.value=1;document.forms['qadmin_form'].submit()">Save &amp; New</button>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_echo -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix><span class="form-control text-muted bg-light">{$value}</span><suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_url -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix> <input type="url" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /> <suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_static -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<input type="hidden" name="{$field}" value="{$value}" />
	<div class="col-md-9"><prefix>{$prefix}</prefix><span class="form-control">{$value}</span><suffix>{$suffix}</suffix></div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_varchar -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix><input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /><suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_disabled -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix><input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" class="form-control" disabled {$required_js} /><suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_permalink -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix} {$permalink_path}</prefix> <input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} /> <suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_email -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9">
		<div class="input-group"><prefix>{$prefix}</prefix><input type="email" name="{$field}" id="{$field}" size="{$size}" value="{$value}" maxlength="{$maxlength}" class="form-control" {$disabled} {$required_js} />
			<div class="input-group-append"><span class="input-group-text"><a href="admin_mail.php?mode=mail&amp;email={$value}"><span class="oi oi-envelope-closed" style="color:inherit" title="send email"></span></a></span></div>
			<suffix>{$suffix}</suffix>
			{$help}
		</div>
	</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_password -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix> <input type="text" name="{$field}" id="{$field}" size="{$size}" value="{$value}" class="form-control" maxlength="{$maxlength}" autocomplete="new-password" onfocus="this.type='password'" {$disabled} {$required_js} onkeyup="passwordStrength('{$field}', this.value)" /> <suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_checkbox -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix><span class="form-control">{$checkbox}</span><suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_date -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix> {$date_select} <suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_time -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix> {$time_select} <suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_text -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label" for="{$field}">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix>
	<textarea name="{$field}" id="{$field}" style="height:{$y}px" class="form-control" {$disabled} {$required_js}>{$value}</textarea>
	<suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_code -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$code_area} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_wysiwyg -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$rte_area} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_select -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix>{$data_select}<suffix>{$edit_opt} {$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_radioh -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$data_radio} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_radiov -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$data_radio} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_multi -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9"><prefix>{$prefix}</prefix> {$data_multi} <suffix>{$suffix}</suffix>
	{$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_file -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$viewfile} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_img -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$viewimg} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_thumb -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$viewthumb} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_img_resize -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$viewimg} {$help}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_img_set -->
<div class="form-group row" id="{$thisid}"><label class="col-md-3 col-form-label">{$title} {$required}</label>
	<div class="col-md-9">{$viewimg} {$upload}</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_edit_opt -->
<a href="edit_opt.php?fid={$editopt}&amp;title=Options&amp;popup=1" class="popiframe_s"><span class="oi oi-spreadsheet"></span></a>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_remove -->
<div class="alert alert-danger"><span class="oi oi-x"></span> <a href="#" class="alert-link" onclick="confirm_remove()">Remove this item</a></div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_foot_inner -->
				</div>
			</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_foot -->
		</div>
		<div class="card-footer">
			<button type="submit" class="btn btn-primary">Save</button> {$savenew_button} <button type="reset" class="btn btn-light">Reset</button>
		</div>
</div>

</form>
{$last_update}
<span style="color:#f00"><b>&bull;</b></span> Denotes required information

<script>
$('input[type=text]').each(function (){s = $(this).attr('size'); if (s < 50) s = s*15; else s = 650; $(this).css ('max-width', s+'px').css ('min-width', '100px')});
$('#qadmin_tab a:not(.url)').on('click', function (e) {
	e.preventDefault()
	$(this).tab('show')
  })
</script>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search -->
<div class="card">
	<div class="card-header"><span class="oi oi-magnifying-glass"></span> {$title}</div>
		<form method="get" name="qadmin_form" action="{$action}">
		{$hidden_value}
		<input type="hidden" name="qadmin_cmd" value="search" />
		<table class="table">
		<tr>
		<td width="20%">Keyword</td><td width="60%"><input type="text" name="keyword" value="{$keyword}" class="form-control"/></td><td width="20%">{$search_by}</td>
		</tr>
		{$date_form}
		{$filter_form}
		<tr>
			<td colspan="3"><button type="submit" class="btn btn-primary">Search</button> <button type="reset" class="btn btn-danger">Reset</button> {$switch_list}</td>
		</tr>

		</table>
		</form>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_date_1 -->
 <tr>
  <td>Date</td><td colspan="2">{$start_date}</td>
 </tr>
 <tr>
  <td>Operation</td><td colspan="2">{$andor}</td>
 </tr>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_date_2 -->
 <tr>
  <td>Date</td><td colspan="2">From {$start_date} to {$end_date}</td>
 </tr>
 <tr>
  <td>Operation</td><td colspan="2">{$andor}</td>
 </tr>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_filter -->
 <tr>
  <td>Filter By</td><td colspan="2">{$filter_by}</td>
 </tr>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_result -->
<table class="table table-bordered">
 <tr>
  <td colspan="{$colspan}">Information Found</td>
 </tr>
 <tr>
  {$block_title}
 </tr>
  {$block_result}
</table>

<div class="card-footer">
	<div class="row">
		<div class="col-md-8">{$pagination}</div>
		<div class="col-md-4">{$new_item_form}</div>
	</div>
</div>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_result_none -->
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_title_row -->
 <th style="text-align:{$align}" nowrap="nowrap">
  {$title}
  {$sortby}
 </td>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_result_row -->
 <td valign="top" style="text-align:{$align}">{$result}</td>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_edit_title -->
 <th valign="top" style="text-align:center">Edit</th>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_search_edit_result -->
 <td valign="top" width="100" class="text-center">&nbsp;<a href="{$edit_url}" target="{$edit_target}">Edit</a>&nbsp;</td>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_list -->
<div class="card">
	<div class="card-header"><span class="oi oi-list"></span> {$title}</div>
		<form method="get" name="qadmin_form" action="{$action}">
		{$hidden_value}
		<input type="hidden" name="qadmin_cmd" value="list" />
		<table class="table">
		 {$filter_form}
		 <tr>
		  <td class="text-center"><button type="submit" class="btn btn-light"><span class="oi oi-reload"></span> Refresh</button></td><td class="text-center">{$switch_search}</td>
		 </tr>
		</table>
		</form>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_switch_list -->
<a href="{$action}qadmin_cmd=list" class="btn btn-light"><span class="oi oi-list"></span> List All</a>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_switch_search -->
<a href="{$action}qadmin_cmd=search" class="btn btn-light"><span class="oi oi-magnifying-glass"></span> Search Form</a>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_new_item -->
<form method="get" name="qadmin_form_new" action="{$action}">
{$hidden_value}
<input type="hidden" name="qadmin_cmd" value="new" />
<button type="submit" class="btn btn-primary"><span class="oi oi-plus"></span> {$add_button_label}</button>
</form>
<!-- ENDSECTION -->

<!-- BEGINSECTION qform_send_email -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en-us" dir="ltr">
<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>Form Result</title>
<base href="{$site_url}" />
<style type="text/css">
body { font: 10pt Tahoma, Arial, Helvetica }
h1, h2 { font-family: Tahoma, Arial, Helvetica }
td { font: 10pt Tahoma, Arial, Helvetica }
td.form_title { font-weight: bold; background: #ccc; padding: 3px 10px 3px 5px }
td.form_value { background: #fff; padding: 3px 5px 3px 10px }
</style>
</head>

<body>
<h1>{$form_name}</h1>
{$header}
<table>
{$form_result}
</table>
{$footer}
<hr />
<p>You can also handle this form in <a href="{$site_url}/admin">ACP</a></p>
</body>
</html>
<!-- ENDSECTION -->