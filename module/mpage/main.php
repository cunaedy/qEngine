<?php
$page = get_param('pid');
if ($isPermalink) {
    $page = $original_idx;
}

if (!$current_admin_level) {
    $cache = qcache_get('mod_mpage.'.$page);
} else {
    $cache = '';
}

if (!$cache) {
    $pg = sql_qquery("SELECT * FROM ".$db_prefix."page WHERE page_id='$page' LIMIT 1");
    $tpl = $pg['page_body'];
    $txt['main_body'] = $tpl;
    $content = flush_tpl('_empty', '', true);
    $pg_tpl = $pg['page_template'];
    if (!$current_admin_level) {
        qcache_update('mod_mpage.'.$page, serialize(array('content' => $content, 'pg_tpl' => $pg['page_template'])));
    }
} else {
    $cache = unserialize($cache);
    $content = $cache['content'];
    $pg_tpl = $cache['pg_tpl'];
}

$txt['main_body'] = $content;

if ($pg_tpl == '_blank') {
    flush_tpl('_blank');
} else {
    flush_tpl();
}
