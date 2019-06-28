<?php
/************************************************
 * Powered with qEngine v16.3 (c) C97.net
 * All rights reserved
 ************************************************/

// check install/
if (file_exists('./install/')) {
    die('If you have just installed qEngine, please delete the <b>"install/"</b> directory on your server before using qEngine v16.3.0 (build 2018.04.02).<br />Or <a href="install/index.php">'
        .'click here</a> to install qEngine for the first time.');
}

// very important file
require_once "./includes/user_init.php";

// get param?
$cmd = get_param('cmd');

switch ($cmd) {
    case 'skin':
        $skin = get_param('skin');
        if (file_exists('./skins/'.$skin.'/outline.tpl')) {
            $_SESSION[$db_prefix.'override_skin'] = $skin;
        }
        redir();
    break;


    case 'viewmode':
        $view_mode = get_param('mode');
        if ($view_mode == 'desktop') {
            $_SESSION[$db_prefix.'view_mode'] = 'desktop';
        } else {
            $_SESSION[$db_prefix.'view_mode'] = 'mobile';
        }
        redir();
    break;


    case 'lang':
        $l = get_param('lang');
        $foo = sql_qquery("SELECT * FROM ".$db_prefix."language WHERE lang_id='$l' LIMIT 1");
        if ($foo) {
            $_SESSION[$db_prefix.'language'] = $l;
        }
        redir();
    break;
}

// demo mode? -- if it is, check if it needs content reset
if (($config['demo_mode']) && ($config['last_autoexec'] != $sql_today)) {
    require './includes/admin_func.php';
    require $config['demo_path'].'/reset.php';
}

// auto exec (this block will be executed daily)
if ($config['last_autoexec'] != $sql_today) {
    sql_query("UPDATE ".$db_prefix."config SET config_value='$sql_today' WHERE config_id='last_autoexec' LIMIT 1");
}

// load tpl
$tpl = load_tpl('welcome.tpl');
$txt['main_body'] = quick_tpl($tpl, $txt);

generate_html_header($config['site_name'].' '.$config['cat_separator'].' '.$config['site_slogan']);
flush_tpl('_blank');
