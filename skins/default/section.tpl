// module boxes
// qE provides 8 module positions: L1, L2, R1, R2, T1, T2, B1, B2 (L = left, R = right, T = top, B = bottom)
// TO make it easier, you only need to supply 2 design: LR for L1, L2, R1 & R2 boxes, and TB for T1, T2, B1 & B2 boxes
// eg: < !-- BEGINSECTION module_design_LR -->your design< !-- ENDSECTION -->
// BUT, if you need to customize each position, you can easily do so, simply create a design for it, eg, for L1 position:
// < !-- BEGINSECTION module_design_L1 -->your design< !-- ENDSECTION -->

<!-- BEGINSECTION module_design_LR -->
<h3>{$mod_title}</h3>
{$mod_content}
<!-- ENDSECTION -->

<!-- BEGINSECTION module_design_TB -->
<div>{$mod_content}</div>
<!-- ENDSECTION -->

// This is bottom_1 module design
// so, as you can see from class 'footer_content_block', it can only display 2 blocks!
<!-- BEGINSECTION module_design_B1 -->
<div class="col-sm-4 col-md-5 col-lg-4">
<h4>{$mod_title}</h4>
{$mod_content}</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION pagination -->
<div style="float:left;margin-right:5px">
	<ul class="pagination">
		<li><span style="background:#ccc">{$pg_total_items} {$l_items}/{$pg_total_pages} {$l_pages}</span></li>
	</ul>
</div>
<div style="float:left">
	<ul class="pagination">
		<li class="{$pg_top_class}">{$pg_top}</li>
		<li class="{$pg_prev_class}">{$pg_prev}</li>
		<!-- BEGINBLOCK pagelist -->
		<li class="{$class}">{$pp}</li>
		<!-- ENDBLOCK -->
		<li class="{$pg_next_class}">{$pg_next}</li>
		<li class="{$pg_last_class}">{$pg_last}</li>
		<li class="normal"><a onclick="promptPage()" style="cursor:pointer"><span class="glyphicon glyphicon-share-alt"></span></a></li>
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

<!-- BEGINSECTION fullpage_msg -->
<div class="well" id="msgalert">
{$message}
<p>{$l_browser_back_button}</p>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION popup_msg -->
<div class="well" id="msgalert">
{$message}
<p align="center"><button type="button" onclick="javascript:document.getElementById('msgalert').style.display='none'">{$l_ok}</button></p>
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION normal_msg -->
{$message}
<!-- ENDSECTION -->

<!-- BEGINSECTION site_closed -->
<div class="well">
{$l_site_closed_info}
</div>
<!-- ENDSECTION -->

<!-- BEGINSECTION acp_shortcuts -->
<div id="acp_shortcuts">
	<div class="btn-toolbar">
		<div class="btn-group">
			<a href="{$site_url}/{$l_admin_folder}/index.php" class="btn btn-default tips" title="Open ACP" target="acp"><span class="glyphicon glyphicon-wrench"></span></a>
			<a href="{$site_url}/{$l_admin_folder}/qe_config.php" class="btn btn-default tips" title="Open Site Configuration" target="acp"><span class="glyphicon glyphicon-cog"></span></a>
			<a href="{$site_url}/{$l_admin_folder}/page.php?qadmin_cmd=new" class="btn btn-default tips" title="Create a New Content" target="acp"><span class="glyphicon glyphicon-file"></span></a>
			<a href="{$site_url}/profile.php?mode=logout" class="btn btn-default tips" title="Logout"><span class="glyphicon glyphicon-lock"></span></a>

		</div>

		<div class="btn-group">
			<a href="{$site_url}/{$l_admin_folder}/about.php" class="btn btn-default tips" title="About qEngine" target="acp"><span class="glyphicon glyphicon-heart"></span></a>
			<a class="btn btn-default tips" title="Notifications" id="popup-notify" data-placement="bottom" data-href="{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifylist&amp;query=foo" tabindex="1"><span class="glyphicon glyphicon-envelope"></span>
				<span id="notification-dot"></span></a>
			<a onclick="$('#acp_shortcuts').hide();" class="btn btn-default tips" title="Close toolbar (refresh page to reveal)"><span class="glyphicon glyphicon-remove"></span></a>

		</div>
	</div>
</div>

<script>
$(function(){
	function details_in_popup(link, div_id) { $.ajax({url: link, success: function(response){ $('#'+div_id).html(response); } }); return '<div id="'+ div_id +'" style="max-height:500px;overflow:auto">Loading...</div>'; }
	$('#popup-notify').popover({"html": true,"content": function(){var div_id =  "tmp-id-" + $.now();return details_in_popup($(this).attr('data-href'), div_id);}}).on("show.bs.popover", function(){ $(this).data("bs.popover").tip().css("width", "600px"); });;
	$('#notification-dot').load ('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifydot&query=foo');
	setInterval (function (){ $('#notification-dot').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifydot&query=foo') }, 10000);
})
</script>
<!-- ENDSECTION -->