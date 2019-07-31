<!-- BEGINSECTION pagination -->
<div style="float:left;margin-right:5px">
	<ul class="pagination">
		<li class="page-item disabled"><a href="#" class="page-link">{$pg_total_items} {$l_items}/{$pg_total_pages} {$l_pages}</a></li>
	</ul>
</div>
<div style="float:left">
	<ul class="pagination">
		<!-- BEGINBLOCK pagelist -->
		<li class="page-item {$class}"><a href="{$url}" class="page-link">{$val}</a></li>
		<!-- ENDBLOCK -->
		<li class="page-item"><a onclick="promptPage()" style="cursor:pointer" class="page-link"><span class="oi oi-share-boxed"></span></a></li>
	</ul>
</div>
<div style="clear:both"></div>
<script>
function promptPage()
{
	var page = prompt ('{$l_enter_page_number}: 1-{$pg_total_pages}', '{$pg_current_page}');
	var pageInt = parseInt (page);
	if (isNaN (pageInt)) return false;
	if ((pageInt > {$pg_total_pages}) || (pageInt < 1) || (pageInt == {$pg_current_page})) return false;
	var url = "{$base_url}&p="+pageInt;
	// alert (url);
	window.location.href = url;
	return false;
}
</script>
<!-- ENDSECTION -->


<!-- BEGINSECTION html_header -->
<!DOCTYPE html>
<html lang="{$l_language_short}" dir="{$l_direction}" style="font-size:15px">
<head>
	<meta charset="{$l_encoding}" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="description" content="{$site_description}" />
	<meta name="keywords" content="{$site_keywords}" />
	<meta name="author" content="{$site_email}" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>{$site_name}</title>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/default.css" />
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/jscripts.css"/>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_admin/style.css" />
	<link rel="shortcut icon" type="image/x-icon" href="{$favicon}" />
	<script type="text/javascript" src="{$site_url}/misc/js/jquery.min.js"></script>
	<script type="text/javascript" src="{$site_url}/misc/js/jscripts.js"></script>
</head>
<body style="margin:20px;background:#fff">
<!-- ENDSECTION -->


<!-- BEGINSECTION html_footer -->
</body>
</html>
<!-- ENDSECTION -->


<!-- BEGINSECTION html_redir -->
<html>
	<head><meta http-equiv="refresh" content="{$timer};url={$url}"></head>
	<body>Redirecting to <a href="{$url}">{$url}</a></body
><html>
<!-- ENDSECTION -->


<!-- BEGINSECTION fullpage_msg -->
<div class="card card-body bg-light" id="msgalert">
	{$message}
	<p>Please use your browser <a href="javascript:history.go(-1)">&lt;back&gt;</a> button to return to previous page!</p>
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION popup_msg -->
<div class="card card-body bg-light" id="msgalert">
	{$message}
	<p class="text-center"><button type="button" class="btn btn-primary" onclick="javascript:document.getElementById('msgalert').style.display='none'">Ok</button></p>
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION normal_msg -->
{$message}
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_radio_v -->
<div class="custom-control custom-radio">
	<input type="radio" name="{$radio_name}" value="{$key}" class="custom-control-input" id="{$radio_name}_{$key}" {$checked} {$addtl_option} />
	<label class="custom-control-label" for="{$radio_name}_{$key}">{$val}</label>
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_radio_h -->
<div class="custom-control custom-radio custom-control-inline">
	<input type="radio" name="{$radio_name}" value="{$key}" class="custom-control-input" id="{$radio_name}_{$key}" {$checked} {$addtl_option} />
	<label class="custom-control-label" for="{$radio_name}_{$key}">{$val}</label>
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_radio_col -->
<table class="table table-borderless">
	<tr>
		<!-- BEGINBLOCK col -->
		<td valign="top" width="{$w}%">{$col}</td>
		<!-- ENDBLOCK -->
	</tr>
</table>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_checkbox -->
<div class="custom-control custom-checkbox">
	<input type="checkbox" name="{$box_name}_{$k}" value="{$key}" class="custom-control-input checkbox_{$box_name}" id="{$box_name}_{$key}" {$checked} />
	<label class="custom-control-label" for="{$box_name}_{$key}">{$val}</label>
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_checkbox_col -->
<div class="custom-control custom-checkbox">
	<input type="checkbox" name="{$box_name}_all" id="{$box_name}_all" class="custom-control-input" onclick="javascript:$('.checkbox_{$box_name}').prop('checked', this.checked)">
	<label class="custom-control-label" for="{$box_name}_all">Check/Uncheck All</label>
</div>
<table class="table table-borderless">
	<tr>
		<!-- BEGINBLOCK col -->
		<td valign="top" width="{$w}%">{$col}</td>
		<!-- ENDBLOCK -->
	</tr>
</table>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_tickbox -->
<div class="custom-control custom-checkbox">
	<input type="checkbox" name="{$box_name}" value="1" class="custom-control-input" id="{$box_name}_tick" {$checked} />
	<label class="custom-control-label" for="{$box_name}_tick">{$val}</label>
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_select -->
<select class="custom-select" name="{$select_name}" {$disabled} {$addtl_option}>
	<!-- BEGINBLOCK opt -->
	<option value="{$key}" {$selected} {$disabled}>{$val}</option>
	<!-- ENDBLOCK -->
</select>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_varchar -->
<input type="{$type}" name="{$field_name}" value="{$value}" id="{$type}_{$field_name}" size="{$size}" maxlength="{$max}" class="form-control" {$disabled} {$addtl_option} />
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_date_form -->
<input type="text" name="{$field_name}" value="{$value}" id="date_{$field_name}" data-date-format="{$date_format}" class="form-control" {$disabled}/>
<script>$('#date_{$field_name}').datepicker({todayBtn: true,autoclose: true,todayHighlight: true})</script>
<!-- ENDSECTION -->


<!-- BEGINSECTION custom_time_form -->
{$hour}:{$minute}
<script>$('#{$prefix}_hou').addClass('width-xs'); $('#{$prefix}_min').addClass('width-xs')</script>
<!-- ENDSECTION -->


<!-- BEGINSECTION sortby -->
<a href="{$sort_url}" id="sort_{$idx}" class="icon-sort"><i class="oi oi-caret-top" {$asc_style}></i><i class="oi oi-caret-bottom" {$dsc_style}></i></a>
<!-- ENDSECTION -->


// module boxes
// qE provides 8 module positions: L1, L2, R1, R2, T1, T2, B1, B2 (L = left, R = right, T = top, B = bottom)
// TO make it easier, you only need to supply 2 design: LR for L1, L2, R1 & R2 boxes, and TB for T1, T2, B1 & B2 boxes
// eg: < !-- BEGINSECTION module_design_LR -->your design< !-- ENDSECTION -->
// BUT, if you need to customize each position, you can easily do so, simply create a design for it, eg, for L1 position:
// < !-- BEGINSECTION module_design_L1 -->your design< !-- ENDSECTION -->

<!-- BEGINSECTION module_design_LR -->
<h5>{$mod_title}</h5>
{$mod_content}
<!-- ENDSECTION -->

<!-- BEGINSECTION module_design_TB -->
<div>{$mod_content}</div>
<!-- ENDSECTION -->

// This is bottom_1 module design
// so, as you can see from class 'footer_content_block', it can only display 2 blocks!
<!-- BEGINSECTION module_design_B1 -->
<div class="col-md-6  col-lg-3">
<h6>{$mod_title}</h6>
{$mod_content}</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION download_attachment -->
<html>
	<head>
	<meta http-equiv="refresh" content="0;url={$fn}">
	<link rel="stylesheet" type="text/css" href="skins/_common/default.css" />
	</head>
	<body style="margin:20px">
		<div class="well">{$l_downloading} <a href="{$fn}">{$page_attachment}</a>. {$l_download_click}</div>
	</body>
</html>
<!-- ENDSECTION -->


<!-- BEGINSECTION site_closed -->
<div class="well">
{$l_site_closed_info}
</div>
<!-- ENDSECTION -->


<!-- BEGINSECTION acp_shortcuts -->
<div id="acp_shortcuts">
	<div class="btn-toolbar">
		<div class="btn-group btn-sm">
			<a href="{$site_url}/{$l_admin_folder}/index.php" class="btn btn-light btn-sm tips" title="Open ACP" target="acp"><span class="oi oi-wrench"></span></a>
			<a href="{$site_url}/{$l_admin_folder}/qe_config.php" class="btn btn-light btn-sm tips" title="Open Site Configuration" target="acp"><span class="oi oi-cog"></span></a>
			<a href="{$site_url}/{$l_admin_folder}/page.php?qadmin_cmd=new" class="btn btn-light btn-sm tips" title="Create a New Content" target="acp"><span class="oi oi-file"></span></a>
			<a href="{$site_url}/profile.php?mode=logout" class="btn btn-light btn-sm tips" title="Logout"><span class="oi oi-lock-locked"></span></a>
		</div>

		<div class="btn-group btn-sm" style="white-space: nowrap;">
			<a href="{$site_url}/{$l_admin_folder}/about.php" class="btn btn-light btn-sm tips" title="About qEngine" target="acp"><span class="oi oi-heart"></span></a>
			<a class="btn btn-light btn-sm tips" title="Notifications" id="popup-notify" data-placement="bottom" data-href="{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifylist&amp;query=foo" tabindex="1">
				<span class="oi oi-envelope-closed" ></span>
				<span id="notification-center" class="badge alert-danger"></span>
			</a>
			<a href="#" onclick="$('#acp_shortcuts').hide();" class="btn btn-light btn-sm tips" title="Close toolbar (refresh page to reveal)"><span class="oi oi-x"></span></a>
		</div>
	</div>
</div>

<div id="container" style="display:none">
	<div id="alertdiv"><div id="alertcontent"></div></div>
</div>

<script>
$(function(){
	function details_in_popup(link, div_id) { $.ajax({url: link, success: function(response){ $('#'+div_id).html(response); } }); return '<div id="'+ div_id +'" style="max-height:500px;overflow:auto">Loading...</div>'; }
	$('#popup-notify').popover({html: true,placement:'auto',content: function(){var div_id =  "tmp-id-" + $.now();return details_in_popup($(this).attr('data-href'), div_id);}});
	$('#notification-center').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notify&query=foo');
	$('#notification-center').click (function () { $('#alertcontent').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifylist&query=foo', function(){ $('#alertdiv').slideToggle (); })})
	setInterval (function (){ $('#notification-center').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notify&query=foo') }, 10000);
})
</script>
<!-- ENDSECTION -->