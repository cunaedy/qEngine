<?php
// part of qEngine
require_once "./includes/user_init.php";

// close site?
if (!$isLogin) {
    redir($config['site_url'].'/profile.php?mode=login');
}

//
$bc = breadcrumb(array($lang['l_my_account']));
$txt = array_merge($txt, $bc);
generate_html_header($bc['head']);
$txt['main_body'] = quick_tpl(load_tpl('account.tpl'), $txt);
flush_tpl();
