<?php
// copy this file to / to create a standalone version of multi page
require_once './includes/user_init.php';

// fill with your template filename (eg: mpage_sample.tpl), but without any extension (eg: mpage_sample)
$page = 'xxx';

$content = qcache_get('mpage.'.$page);
if (!$content) {
    $tpl = load_tpl($page.'.tpl');
    $txt['main_body'] = $tpl;
    $content = flush_tpl('_empty', '', true);
    if (!$current_admin_level) {
        qcache_update('mpage.'.$page, $content);
    }
}

$txt['main_body'] = $content;

// use flush_tpl ('_blank') to display your file without sidebar, or flush_tpl () to display with sidebar
flush_tpl('_blank');
