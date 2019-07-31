<!DOCTYPE html>
<html lang="{$l_language_short}" dir="{$l_direction}" style="font-size:15px">
<head>
	<meta charset="{$l_encoding}" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="description" content="{$site_description}" />
	<meta name="keywords" content="{$site_keywords}" />
	<meta name="author" content="{$site_email}" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>{$head_title}</title>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/default.css" />
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/jscripts.css"/>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_admin/style.css" />
	<link rel="shortcut icon" type="image/x-icon" href="{$favicon}" />
	<script type="text/javascript" src="{$site_url}/misc/js/jquery.min.js"></script>
	<script type="text/javascript" src="{$site_url}/misc/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="{$site_url}/misc/js/jscripts.js"></script>
</head>

<body>

<!-- BEGINIF $system_message -->
<div style="display:none">
	<div id="system_msg">
	{$system_message}
	</div>
</div>
<!-- ENDIF -->

<!-- BEGINIF $mini_message -->
<div style="display:none">
	<div id="system_msg">
	{$system_message}
	</div>
</div>
<!-- ENDIF -->

<div class="container-fluid" style="max-width:1500px">
	<div class="row">
		<div class="col-sm-12">
			<div id="wrapper">
				<div class="sameH" id="nav-bar">
					<div id="clock"><div class="liveclock_hour">00:00</div><div class="liveclock_date">Loading...</div></div>
					<div id="clockIcon"><a href="{$site_url}/misc/js/timecalc.html" class="popiframe_m"><span class="oi oi-clock" style="color:#fff" class="tips" title="Click here to check the time in other countries."></span></a></div>
					<ul id="accordion">
						<li><a href="#"><span class="oi oi-power-standby" aria-hidden="true"></span> Session</a>
							<ul>
								<li><a href="{$site_url}/{$l_admin_folder}/index.php">Summary</a></li>
								<li><a href="{$site_url}">View My Site</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/passwd.php">Change Password</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/logout.php">Log Out</a></li>
							</ul>
						</li>
						<li><a href="#"><span class="oi oi-file" aria-hidden="true"></span> Contents</a>
							<ul>
						<!-- BEGINIF $is_allowed_page_manager -->
								<li><a href="{$site_url}/{$l_admin_folder}/page_group.php?qadmin_cmd=list">Manage Types</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/page_cat.php?qadmin_cmd=list">Manage Categories</a></li>
						<!-- ENDIF -->
						<!-- BEGINIF $is_allowed_page_editor -->
								<li><a href="{$site_url}/{$l_admin_folder}/page.php?qadmin_cmd=list">Manage Contents</a></li>
						<!-- ENDIF -->
						<!-- BEGINIF $is_allowed_manage_menu -->
								<li><a href="{$site_url}/{$l_admin_folder}/menu_man.php">Manage Menu</a></li>
						<!-- ENDIF -->
							</ul>
						</li>

						<!-- BEGINIF $is_allowed_manage_user -->
						<li><a href="#"><span class="oi oi-people" aria-hidden="true"></span> Users</a>
							<ul>
								<li><a href="{$site_url}/{$l_admin_folder}/user.php">User Center</a></li>
							</ul>
						</li>
						<!-- ENDIF -->

						<li><a href="#"><span class="oi oi-cog" aria-hidden="true"></span> Modules</a>
							<ul>
						<!-- BEGINBLOCK module -->
								<li><a href="#">{$title}</a>
									<ul>
						<!-- BEGINSUBBLOCK module -->
										<li><a href="{$site_url}/{$l_admin_folder}/{$item_url}">{$item_title}</a></li>
						<!-- ENDSUBBLOCK -->
									</ul>
								</li>
						<!-- ENDBLOCK -->
						<!-- BEGINIF $is_allowed_manage_module -->
							<li><a href="{$site_url}/{$l_admin_folder}/manage.php">Layout</a></li>
							<li><a href="{$site_url}/{$l_admin_folder}/module.php">Configure</a></li>
						<!-- ENDIF -->
							</ul>
						</li>

						<!-- BEGINIF $is_allowed_site_setting -->
						<li><a href="#"><span class="oi oi-wrench" aria-hidden="true"></span> Tools</a>
							<ul>
								<li><a href="#">Site Configuration</a>
									<ul>
						<!-- ENDIF -->
						<!-- BEGINIF $is_allowed_site_config -->
										<li><a href="{$site_url}/{$l_admin_folder}/qe_config.php">Engine Settings</a></li>
						<!-- ENDIF -->
						<!-- BEGINIF $is_allowed_site_setting -->
										<!-- li><a href="{$site_url}/{$l_admin_folder}/local_config.php">Other Settings</a></li -->
										<li><a href="{$site_url}/{$l_admin_folder}/phpinfo.php">PHP Info</a></li>
						<!-- ENDIF -->
						<!-- BEGINIF $is_allowed_permisi -->
										<li><a href="{$site_url}/{$l_admin_folder}/permisi.php">User Level</a></li>
						<!-- ENDIF -->
						<!-- BEGINIF $is_allowed_site_setting -->
									</ul>
								</li>
								<li><a href="#">Logs</a>
									<ul>
										<li><a href="{$site_url}/{$l_admin_folder}/qform_log.php">qForm Logs</a></li>
										<li><a href="{$site_url}/{$l_admin_folder}/mailog.php">Email Logs</a></li>
										<li><a href="{$site_url}/{$l_admin_folder}/iplog.php">Login Logs</a></li>
									</ul>
								</li>
								<li><a href="{$site_url}/{$l_admin_folder}/lang.php">Language Editor</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/fman/fileman.php">File Manager</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/cache.php">Optimize DB</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/backup.php">Backup DB</a></li>
								<li><a href="{$site_url}/{$l_admin_folder}/fman/miniman.php?chdir=../backup&amp;script=../restore.php" class="popiframe">Restore DB</a></li>
							</ul>
						</li>
						<!-- ENDIF -->

						<li><a href="{$site_url}/{$l_admin_folder}/about.php"><span class="oi oi-heart"></span> About</a></li>
					</ul>
				</div>
				<div class="sameH" id="content">
					<div id="menuButton"><span class="oi oi-menu" id="toggleMenu"></span></div>
					<div id="top-bar">
						<span class="oi oi-envelope-closed" aria-hidden="true" id="popup-notify" data-placement="bottom" data-href="{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifylist&amp;query=foo" tabindex="1"></span>
						<span id="notification-center" class="badge alert-danger"></span>
						Hello, <b><a href="{$site_url}/{$l_admin_folder}/user.php?id={$current_user_id}">{$current_user_id}</a></b>.
					</div>
					<div style="padding:30px" id="main_body">
							{$main_body}
					</div>
				</div>
				<div style="clear:both"></div>
			</div>
		</div>
	</div>
</div>

<div id="container" style="display:none">
	<div id="alertdiv"><div id="alertcontent"></div></div>
</div>

<script>
var triggers, navBar;
navBar = getCookie ('navBar');
if (navBar == null) navBar = 1;
if (navBar == 0) { $("#nav-bar").hide(); $("#wrapper").css('padding-left', '0'); }

$(function(){
	function details_in_popup(link, div_id) { $.ajax({url: link, success: function(response){ $('#'+div_id).html(response); } }); return '<div id="'+ div_id +'" style="max-height:500px;overflow:auto">Loading...</div>'; }
	function resizeH(){ $('.sameH').css('min-height', $(window).height()+'px'); }
	function CheckAllBoxes(className) {$('.'+className).prop('checked', this.checked)}

	$("a.popiframe").colorbox({iframe:true, width:"1100px", maxWidth:"95%", height:"700px", maxHeight:"95%"});
	$("a.popiframe_m").colorbox({iframe:true, width:"1100px", maxWidth:"95%", height:"500px", maxHeight:"95%"});
	$("a.popiframe_s").colorbox({iframe:true, width:"600px", maxWidth:"95%", height:"400px", maxHeight:"95%"});
	$("a.popiframe_sp").colorbox({iframe:true, width:"600px", maxWidth:"95%", height:"540px", maxHeight:"95%"});
	$("a.lightbox").colorbox({rel:'group'});
	$('.tips').tooltip({placement : 'top',html:true,container: 'body'})
	$("#toggleMenu").click(function () { if (navBar == 1) { $("#nav-bar").hide(); $("#wrapper").animate({paddingLeft: '0'}); navBar = 0; } else { $("#wrapper").animate({paddingLeft: '250'}, 400, function () { $("#nav-bar").show() }); navBar = 1; } setCookie('navBar', navBar) })
	$('a.simpleAjax').click(function(event){event.preventDefault();var that=$(this);$.ajax({url:$(this).attr('href'),success:function(result,status,xhr){var res=$.parseJSON(result);var sCallback=$(that).attr('data-ajax-success-callback')==undefined?false:$(that).attr('data-ajax-success-callback');var sArg=$(that).attr('data-ajax-success-arg')==undefined?0:$(that).attr('data-ajax-success-arg');var fCallback=$(that).attr('data-ajax-failed-callback')==undefined?false:$(that).attr('data-ajax-failed-callback');var fArg=$(that).attr('data-ajax-failed-arg')==undefined?0:$(that).attr('data-ajax-failed-arg');if(res[0])alert('Warning!\n'+res[1]);if(!res[0]&&res[2]==1){if(sCallback)window[sCallback](sArg);}else{if(fCallback)window[fCallback](fArg);}},error:function(result,status,xhr){alert('Error '+result.status+' '+result.statusText+'. Please try again later!');res=false;}});return false;});

	// accordion
	var path = '{$request_location}';
	if (path !== undefined) {$('ul#accordion').find("a[href$='" + path + "']").parent('li').addClass('active');}
	$('#accordion').tinyNav({active:'active'});
	$("#accordion").quiccordion();

	// clock
	goforit();

	// notification
	$('#popup-notify').popover({html: true,placement:'auto',content: function(){var div_id =  "tmp-id-" + $.now();return details_in_popup($(this).attr('data-href'), div_id);}});
	$('#notification-center').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notify&query=foo');
	$('#notification-center').click (function () { $('#alertcontent').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notifylist&query=foo', function(){ $('#alertdiv').slideToggle (); })})
	setInterval (function (){ $('#notification-center').load('{$site_url}/{$l_admin_folder}/admin_ajax.php?cmd=notify&query=foo') }, 10000);

	resizeH();
	$(window).resize(function (){resizeH()});

	<!-- BEGINIF $system_message -->
	// system message
	$.colorbox({inline:true,href:'#system_msg',title:'System Message'})
	<!-- ENDIF -->

	<!-- BEGINIF $mini_message -->
	// mini message
	$.colorbox({inline:true,href:'#system_msg',title:'System Message'})
	setTimeout('$.colorbox.close()', 1000)
	<!-- ENDIF -->
});
</script>
</body>
</html>