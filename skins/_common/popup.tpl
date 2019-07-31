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

<body style="background-image:none;background:#fff;margin: 10px">
<!-- BEGINIF $system_message -->
{$system_message}
<!-- ENDIF -->
{$main_body}
</body>

</html>