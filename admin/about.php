<?php
// part of qEngine
require './../includes/admin_init.php';
admin_check(1);
$tpl = load_tpl('adm', 'about.tpl');

// qe
$f = explode('/', $config['qe_version']);
$txt['qe_ver'] = $f[0];
$txt['qe_build'] = $f[1];

$txt['main_body'] = quick_tpl($tpl, $txt);
flush_tpl('adm');
