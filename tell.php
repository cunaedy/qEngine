<?php
// part of qEngine
require './includes/user_init.php';

$cmd = get_param('cmd');
$popup = get_param('popup');
if (empty($cmd)) {
    $cmd = post_param('cmd');
}

switch ($cmd) {
    case 'send':
        $txt['name'] = post_param('name');
        $txt['email'] = post_param('email');
        $txt['friend_name'] = post_param('friend_name');
        $txt['friend_email'] = post_param('friend_email');
        $txt['tell_body'] = nl2br(post_param('tell_body'));
        $txt['site_name'] = $config['site_name'];
        $txt['site_slogan'] = $config['site_slogan'];
        $txt['site_url'] = $config['site_url'];
        $visual = post_param('visual');
        if (qvc_value() != qhash(strtolower($visual))) {
            msg_die($lang['msg']['captcha_error']);
        }
        if (!validate_email_address($txt['email'])) {
            msg_die($lang['msg']['tell_error']);
        }

        $body = quick_tpl(load_tpl('mail', 'tell'), $txt);
        if (!validate_email_address($txt['friend_email'])) {
            msg_die($lang['msg']['tell_error']);
        }
        email($txt['friend_email'], $lang['l_mail_friend_subject'], $body, true, true);
        msg_die(sprintf($lang['msg']['tell_ok'], $txt['friend_email']));
    break;


    default:
        // get user info
        qvc_init(3);
        $usr = get_user_info();

        $txt['main_body'] = quick_tpl(load_tpl('tell.tpl'), $usr);
        generate_html_header();
        flush_tpl();
    break;
}
