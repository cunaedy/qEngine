<?php
$_GET['filter_by']=1;
$id = get_param('id');

// data definitions
$qadmin_def['page_id']['title'] = 'ID';
$qadmin_def['page_id']['field'] = 'page_id';
$qadmin_def['page_id']['type'] = 'echo';
$qadmin_def['page_id']['size'] = 10;
$qadmin_def['page_id']['value'] = 'sql';

// page_title :: string :: 255
$qadmin_def['page_title']['title'] = 'Title';
$qadmin_def['page_title']['field'] = 'page_title';
$qadmin_def['page_title']['type'] = 'varchar';
$qadmin_def['page_title']['size'] = 255;
$qadmin_def['page_title']['value'] = 'sql';

if ($id) {
    // preview :: string :: 255
    $qadmin_def['preview']['title'] = 'Preview';
    $qadmin_def['preview']['field'] = 'preview';
    $qadmin_def['preview']['type'] = 'echo';
    $qadmin_def['preview']['help'] = 'Preview saved content in new window (you must save first)';
    if ($config['enable_adp']) {
        $qadmin_def['preview']['value'] = "<a href=\"$config[site_url]/$page_info[permalink]\" target=\"_blank\">Preview Now</a>";
    } else {
        $qadmin_def['preview']['value'] = "<a href=\"$config[site_url]/task.php?mod=mpage&amp;pid=$id\" target=\"_blank\">Preview Now</a>";
    }
}


// page_body :: blob :: 65535
$qadmin_def['page_body']['title'] = 'Body';
$qadmin_def['page_body']['field'] = 'page_body';
$qadmin_def['page_body']['type'] = 'code';
$qadmin_def['page_body']['lang'] = 'html';
$qadmin_def['page_body']['size'] = '500,500';
$qadmin_def['page_body']['value'] = 'sql';
$qadmin_def['page_body']['index'] = true;

// permalink :: string :: 255
$qadmin_def['permalink']['title'] = 'Permalink';
$qadmin_def['permalink']['field'] = 'permalink';
$qadmin_def['permalink']['type'] = 'permalink';
$qadmin_def['permalink']['size'] = 255;
$qadmin_def['permalink']['value'] = 'sql';

// page_template :: string :: 255
$qadmin_def['page_template']['title'] = 'Page Template';
$qadmin_def['page_template']['field'] = 'page_template';
$qadmin_def['page_template']['type'] = 'select';
$qadmin_def['page_template']['option'] = array('default' => 'Default', '_blank' => 'Blank');
$qadmin_def['page_template']['value'] = 'sql';

// group_id :: string :: 5
$qadmin_def['group_id']['title'] = 'Group Id';
$qadmin_def['group_id']['field'] = 'group_id';
$qadmin_def['group_id']['type'] = 'hidden';
$qadmin_def['group_id']['size'] = 5;
$qadmin_def['group_id']['value'] = 'MPAGE';

// page_allow_comment :: string :: 3
$qadmin_def['page_allow_comment']['title'] = 'Page Allow Comment';
$qadmin_def['page_allow_comment']['field'] = 'page_allow_comment';
$qadmin_def['page_allow_comment']['type'] = 'hidden';
$qadmin_def['page_allow_comment']['size'] = 1;
$qadmin_def['page_allow_comment']['value'] = 0;

// page_list :: string :: 3
$qadmin_def['page_list']['title'] = 'Page List';
$qadmin_def['page_list']['field'] = 'page_list';
$qadmin_def['page_list']['type'] = 'hidden';
$qadmin_def['page_list']['size'] = 1;
$qadmin_def['page_list']['value'] = 0;

// page_status :: string :: 3
$qadmin_def['page_status']['title'] = 'Page Status';
$qadmin_def['page_status']['field'] = 'page_status';
$qadmin_def['page_status']['type'] = 'hidden';
$qadmin_def['page_status']['size'] = 1;
$qadmin_def['page_status']['value'] = 'H';

// general configuration ( * = optional )
$qadmin_cfg['table'] = $db_prefix.'page';					// table name
$qadmin_cfg['primary_key'] = 'page_id';						// table's primary key
$qadmin_cfg['primary_val'] = 'dummy';						// primary key value
$qadmin_cfg['template'] = 'default';						// template to use
$qadmin_cfg['action'] = 'task.php?mod=mpage&run=edit.php';
$qadmin_cfg['permalink_script'] = 'task.php';				// script name for permalink
$qadmin_cfg['permalink_source'] = 'page_title';				// script name for permalink
$qadmin_cfg['permalink_param'] = 'mod=mpage';				// script name for permalink

// folder configuration (qAdmin only stores filename.ext without folder location), ends without slash '/' - optional
$qadmin_cfg['file_folder'] = './../public/file';					// folder to place file upload (relative to /admin folder)
$qadmin_cfg['img_folder'] = './../public/image';				// folder to place image upload
$qadmin_cfg['thumb_folder'] = './../public/thumb';			// folder to place thumb (auto generated)

// search configuration
$qadmin_cfg['search_key'] = 'page_id,page_title';		// list other key to search
$qadmin_cfg['search_key_mask'] = 'ID,Title/Description';	// mask other key

// enable qadmin functions, which are: search, list, new, update & remove
$qadmin_cfg['cmd_default'] = 'list';						// if this script called without ANY parameter
$qadmin_cfg['cmd_search_enable'] = true;
$qadmin_cfg['cmd_list_enable'] = true;
$qadmin_cfg['cmd_new_enable'] = true;
$qadmin_cfg['cmd_update_enable'] = true;
$qadmin_cfg['cmd_remove_enable'] = true;

$qadmin_cfg['search_filterby'] = 'group_id=\'MPAGE\'';	// filter by sql_query (use , to separate queries) *
$qadmin_cfg['search_filtermask'] = 'Multipages';				// mask filter *

// security *** qADMIN CAN NOT RUN IF admin_level NOT DEFINED ***
// Highest to lowest: 5, 4, 3, 2, 1
// higher level can access lower level features [ 4 should be good, 5 is too high and should be used in a very important area ]
$qadmin_cfg['admin_level'] = '4';

// form title
$qadmin_title['new'] = 'Add a Multipage';
$qadmin_title['update'] = 'Update a Multipage';
$qadmin_title['search'] = 'Search Multipage';
$qadmin_title['list'] = 'Multipage List';
qadmin_manage($qadmin_def, $qadmin_cfg, $qadmin_title);
