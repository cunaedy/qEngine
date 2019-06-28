<?php
require './../includes/admin_init.php';
admin_check('site_setting');

//
$res = sql_query("SELECT * FROM ".$db_prefix."config WHERE group_id='ke'");
while ($row = sql_fetch_array($res)) {
    $cfg[$row['config_id']] = $row['config_value'];
}
$tpl = load_tpl('adm', 'local_config.tpl');

$txt['main_body'] = quick_tpl($tpl, $txt);
flush_tpl('adm');
