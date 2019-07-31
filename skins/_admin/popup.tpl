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

<body style="margin:20px;background:#fff">
<!-- BEGINIF $system_message -->
<div id="system_msg" class="simple_overlay">
{$system_message}
</div>
<!-- ENDIF -->

   {$main_body}

</body>

</html>