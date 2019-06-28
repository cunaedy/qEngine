<?php
require './includes/user_init.php';

$cmd = get_param('cmd');
$q = get_param('query');
$limit = 20;

switch ($cmd) {
    case 'userOk':
        if (!empty($q)) {
            $foo = sql_qquery("SELECT user_id FROM ".$db_prefix."user WHERE user_id='$q' LIMIT 1");
            if (!empty($foo) || !preg_match("/^[[:alnum:]]+$/", $q)) {
                flush_json(0) ;
            } else {
                flush_json(1);
            }	// 1 = username is ok
        }
    break;


    case 'emailOk':
        if (!empty($q)) {
            if ($isLogin) {
                $foo = sql_qquery("SELECT user_email FROM ".$db_prefix."user WHERE (user_email='$q') AND (user_id!='$current_user_id') LIMIT 1");
            } else {
                $foo = sql_qquery("SELECT user_email FROM ".$db_prefix."user WHERE user_email='$q' LIMIT 1");
            }
            if (!empty($foo) || !validate_email_address($q)) {
                flush_json(0);
            } else {
                flush_json(1);
            }	// 1 = email is ok
        }
    break;


    default:
        flush_json(9999, 'Undefined ajax mode '.$cmd);
    break;
}
