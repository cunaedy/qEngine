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
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/default.css"/>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/_common/jscripts.css"/>
	<link rel="stylesheet" type="text/css" href="{$site_url}/skins/default/style.css" />
	{$module_css_list}
	<link rel="shortcut icon" type="image/x-icon" href="{$favicon}" />
	<link rel="apple-touch-icon" href="{$favicon}" />
	<script type="text/javascript" src="{$site_url}/misc/js/jquery.min.js"></script>
	<script type="text/javascript" src="{$site_url}/misc/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="{$site_url}/misc/js/jscripts.js"></script>
	{$module_js_list}
</head>

<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.10";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<!-- BEGINIF $system_message -->
<div style="display:none">
	<div id="system_msg">
	{$system_message}
	</div>
</div>
<!-- ENDIF -->
<!-- BEGINIF $current_admin_level -->
{$acp_shortcuts}
<!-- ENDIF -->

<nav id="header" class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container">
		<a href="{$site_url}/index.php" class="navbar-brand"><img src="{$favicon}" alt="{$site_name}"/></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarMainMenu" aria-controls="navbarMainMenu" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarMainMenu">

			{qemod:qmenu:main_menu}

			<ul class="navbar-nav navbar-right ml-auto">
				<!-- BEGINIF $isLogin -->
				<li class="navbar-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<span class="oi oi-person"></span></a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a href="{$site_url}/account.php" class="dropdown-item">{$l_my_account} ({$current_user_id})</a>
						<div class="dropdown-divider"></div>
						<a href="{$site_url}/profile.php?mode=logout" class="dropdown-item">{$l_logout}</a>
					</div>
				</li>
				<!-- ELSE -->
				<li class="nav-item"><a href="{$site_url}/profile.php?redir={$current_url}" class="nav-link tips" title="{$l_login_register}"><span class="oi oi-person"></span> <span class="oi oi-account-login"></span></a></li>
				<!-- ENDIF -->
				<li class="navbar-item">
					<form method="get" action="{$site_url}/site_search.php" class="form-inline">
					<div class="form-group">
						<input type="text" name="query" class="form-control mr-sm-2" placeholder="{$l_search}">
					</div>
					</form>
				</li>
			</ul>
		</div>
	</div>
</nav>

<div id="body">
{$main_content}
</div>

<div id="footer">
	<div class="container">
		<div class="row" id="footer_content">
			<!-- ONLY UP TO 4 (FOUR) MODULES IN B1 HERE!!! -->
			{$module_box_B1}

			<div class="col-md-6 col-lg-3">
				<h6>{$l_site_name} &bull; {$l_site_slogan}</h6>
				<ul class="list_3">
					<li><a href="{$print_this_page}">{$l_print}</a></li>
					<li>&copy; All Rights Reserved</li>
					<li><!-- BEGINMODULE ztopwatch --><!-- ENDMODULE --></li>
				</ul>
			</div>

			<div class="col-md-6 col-lg-3">
				<h6>Powered By</h6>
				<a href="http://www.c97.net"><img src="{$site_url}/skins/_common/images/qe.png" alt="qEngine" /></a>
			</div>
		</div>

		<div class="row">
			<div class="col">
				{$module_box_B2}
			</div>
		</div>
	</div>
</div>

<script>
$(function(){
	$('#body').css('min-height', $(window).height()-$('#header').height()-$('#footer').height()-55+'px');
	$("a.popiframe").colorbox({iframe:true, width:"900px", maxWidth:"95%", height:"500px", maxHeight:"95%"});
	$("a.popiframe_s").colorbox({iframe:true, width:"500px", maxWidth:"95%", height:"300px", maxHeight:"95%"});
	$("a.popiframe_sp").colorbox({iframe:true, width:"600px", maxWidth:"95%", height:"540px", maxHeight:"95%"});
	$("a.lightbox").colorbox({rel:'group', maxWidth:"95%", maxHeight:"95%"});
	$('.tips').tooltip({placement : 'top',html:true,container: 'body'})
	$('a.simpleAjax').click(function(event){event.preventDefault();var that=$(this);$.ajax({url:$(this).attr('href'),success:function(result,status,xhr){var res=$.parseJSON(result);var sCallback=$(that).attr('data-ajax-success-callback')==undefined?false:$(that).attr('data-ajax-success-callback');var sArg=$(that).attr('data-ajax-success-arg')==undefined?0:$(that).attr('data-ajax-success-arg');var fCallback=$(that).attr('data-ajax-failed-callback')==undefined?false:$(that).attr('data-ajax-failed-callback');var fArg=$(that).attr('data-ajax-failed-arg')==undefined?0:$(that).attr('data-ajax-failed-arg');if(res[0])alert('Warning!\n'+res[1]);if(!res[0]&&res[2]==1){if(sCallback)window[sCallback](sArg);}else{if(fCallback)window[fCallback](fArg);}},error:function(result,status,xhr){alert('Error '+result.status+' '+result.statusText+'. Please try again later!');res=false;}});return false;});
	$("#navbar ul li a[href^='#']").on('click',function(e){e.preventDefault();$('html, body').animate({scrollTop:$(this.hash).offset().top},300,function(){window.location.hash=this.hash;});});
	var path = '{$request_location}';
	if (path !== undefined) {
		$('ul.navbar-nav').find("a[href$='" + path + "']").parents('li').addClass('active');
		$('div.dropdown-menu').find("a[href$='" + path + "']").addClass('active');
	}

	<!-- BEGINIF $system_message -->
	// system message
	$.colorbox({inline:true,href:'#system_msg',title:'{$site_name}', maxWidth:"95%", maxHeight:"95%"})
	<!-- ENDIF -->

	<!-- BEGINIF $enable_inline_edit -->
	$('.editable').addClass('inline_edit')
	<!-- ENDIF -->
});
</script>
</body>

</html>