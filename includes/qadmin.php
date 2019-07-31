<?php
require 'qform.php';

function qadmin_manage($qadmin_def, $qadmin_cfg, $qadmin_title = array(), $tpl_mode = 'full')
{
    global $lang, $txt;
    $qform_cfg = array();

    // security
    if (empty($qadmin_cfg['admin_level'])) {
        just_die('<b>Fatal Error!</b> Admin level is not defined!');
    }
    if ($qadmin_cfg['admin_level']) {
        admin_check($qadmin_cfg['admin_level']);
    }

    // qadmin_cmd compatibility
    $qcmd = get_param('qadmin_cmd');
    if (!empty($qcmd)) {
        $_GET['qform_cmd'] = $qcmd;
    } else {
        $qcmd = post_param('qadmin_cmd');
        if (!empty($qcmd)) {
            $_POST['qform_cmd'] = $qcmd;
        }
    }
    $_POST['qform_process'] = post_param('qadmin_process');
    $_POST['qform_savenew'] = post_param('qadmin_savenew');
    $_GET['qform_process'] = get_param('qadmin_process');
    $_GET['qform_savenew'] = get_param('qadmin_savenew');

    if (empty($qadmin_cfg['primary_val'])) {
        $qadmin_cfg['primary_val'] = '';
    }
    if ($qadmin_cfg['primary_val'] == 'dummy') {
        $qadmin_cfg['primary_val'] = '';
    }

    // template
    if (!isset($qadmin_cfg['template'])) {
        $qform_cfg['template'] = 'default';
    } else {
        $qform_cfg['template'] = $qadmin_cfg['template'];
    }

    if ($qform_cfg['template'] == 'default') {
        $qform_cfg['tpl_file'] = './../_admin/qadmin_section.tpl';
        $qform_cfg['ezd_file'] = './../_admin/qadmin_ezd.tpl';
    } else {
        $qform_cfg['tpl_file'] = './../_admin/' . $qform_cfg['template'] . '_section.tpl';
        $qform_cfg['tpl_file'] = './../_admin/' . $qform_cfg['template'] . '_ezd.tpl';
    }

    // permissions
    $qform_cfg['cmd_default'] = 'list';						// if this script called without ANY parameter
    $qform_cfg['cmd_search_enable'] = isset($qadmin_cfg['cmd_search_enable']) ? $qadmin_cfg['cmd_search_enable'] : true;
    $qform_cfg['cmd_list_enable'] = isset($qadmin_cfg['cmd_list_enable']) ? $qadmin_cfg['cmd_list_enable'] : true;
    $qform_cfg['cmd_new_enable'] = isset($qadmin_cfg['cmd_new_enable']) ? $qadmin_cfg['cmd_new_enable'] : true;
    $qform_cfg['cmd_update_enable'] = isset($qadmin_cfg['cmd_update_enable']) ? $qadmin_cfg['cmd_update_enable'] : true;
    $qform_cfg['cmd_remove_enable'] = isset($qadmin_cfg['cmd_remove_enable']) ? $qadmin_cfg['cmd_remove_enable'] : true;

    // other settings
    $qform_cfg['ezd_mode'] = isset($qadmin_cfg['ezd_mode']) ? $qadmin_cfg['ezd_mode'] : false;				// set enable to use design your own form with ezform's EZD, which returns form elements as array (use print_r to qadmin_manage's return)
    $qform_cfg['auto_save_changes'] = isset($qadmin_cfg['auto_save_changes']) ? $qadmin_cfg['auto_save_changes'] : true;		// auto save changes to database, or return sql query & submitted parameter in an array (useful in EZD mode) -- notice: all uploaded files have been stored & processed before returning the sql

    // messages
    $qform_cfg['msg'] = array();
    $qform_cfg['msg']['ok'] = $lang['msg']['admin_ok'];
    $qform_cfg['msg']['item_not_found'] = $lang['msg']['qadmin_item_not_found'];
    $qform_cfg['msg']['captcha_error'] = $lang['msg']['captcha_error'];
    $qform_cfg['msg']['permalink_error'] = $lang['msg']['permalink_error'];
    $qform_cfg['msg']['can_not_upload'] = $lang['msg']['can_not_upload'];
    $qform_cfg['msg']['qform_required_err'] = $lang['msg']['qadmin_required_err'];
    $qform_cfg['msg']['qform_email_ok'] = $lang['msg']['qadmin_email_ok'];

    $qadmin_cfg = array_merge($qadmin_cfg, $qform_cfg);
    $output = qform_manage($qadmin_def, $qadmin_cfg, $qadmin_title);

    // add proper prefix & suffix
    $output = preg_replace_callback("/<PREFIX>(.*?)<\/PREFIX>(.*?)<SUFFIX>(.*?)<\/SUFFIX>/is", 'cform_pre_suf', $output);

    if ($qform_cfg['ezd_mode']) {
        return $output;
    } else {
        if ($tpl_mode != 'popup') {
            $tpl_mode = 'adm';
        }
        $txt['main_body'] = $output;
        flush_tpl('adm');
    }
}


// support for cform_manage, replace <PREFIX> & <SUFFIX> with approriate <div>
function cform_pre_suf($args)
{
    foreach ($args as $k => $v) {
        $args[$k] = trim($v);
    }
    if (!$args[1] && !$args[3]) {
        return $args[2];
    }
    $ret = '<div class="input-group">';
    if ($args[1]) {
        $ret .= '<div class="input-group-prepend"><span class="input-group-text">' . $args[1] . '</span></div>';
    }
    $ret .= $args[2];
    if ($args[3]) {
        $ret .= '<div class="input-group-append"><span class="input-group-text">' . $args[3] . '</span></div>';
    }
    $ret .= '</div>';
    return $ret;
}
