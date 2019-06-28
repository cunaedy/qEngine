<?php
$_GET['filter_by']=1;
$id = get_param('id');
if ($id) {
    $slide = sql_qquery("SELECT * FROM ".$db_prefix."page WHERE page_id='$id' LIMIT 1");
}

// page_id :: int :: 10
$qadmin_def['page_id']['title'] = 'Slide ID';
$qadmin_def['page_id']['field'] = 'page_id';
$qadmin_def['page_id']['type'] = 'echo';
$qadmin_def['page_id']['size'] = 10;
$qadmin_def['page_id']['value'] = 'sql';

// page_image :: string :: 255
$qadmin_def['page_image']['title'] = 'Slide Image';
$qadmin_def['page_image']['field'] = 'page_image';
$qadmin_def['page_image']['type'] = 'thumb';
$qadmin_def['page_image']['size'] = 255;
$qadmin_def['page_image']['value'] = 'sql';

// cat_id :: string :: 255
$qadmin_def['cat_id']['title'] = 'Category';
$qadmin_def['cat_id']['field'] = 'cat_id';
$qadmin_def['cat_id']['type'] = 'select';
$qadmin_def['cat_id']['size'] = 255;
$qadmin_def['cat_id']['option'] = get_editable_option('mod_slideshow');
$qadmin_def['cat_id']['value'] = 'sql';
$qadmin_def['cat_id']['suffix'] = ' <a href="edit_opt.php?fid=mod_slideshow&popup=1" class="popiframe_s">Edit Categories</a>';

// page_title :: string :: 255
$qadmin_def['page_title']['title'] = 'Title/Description';
$qadmin_def['page_title']['field'] = 'page_title';
$qadmin_def['page_title']['type'] = 'varchar';
$qadmin_def['page_title']['size'] = 255;
$qadmin_def['page_title']['value'] = 'sql';
$qadmin_def['page_title']['required'] = true;

// page_keyword :: string :: 255
$qadmin_def['page_keyword']['title'] = 'URL';
$qadmin_def['page_keyword']['field'] = 'page_keyword';
$qadmin_def['page_keyword']['type'] = 'varchar';
$qadmin_def['page_keyword']['size'] = 255;
$qadmin_def['page_keyword']['value'] = 'sql';
$qadmin_def['page_keyword']['required'] = true;

// notes
if ($id) {
    $qadmin_def['notes1']['title'] = 'Notes';
    $qadmin_def['notes1']['field'] = 'notes1';
    $qadmin_def['notes1']['type'] = 'echo';
    $qadmin_def['notes1']['value'] = 'To display only this category of slides, please specify category ID of <kbd>'.$slide['cat_id'].'</kbd>';
}

// group_id :: string :: 5
$qadmin_def['group_id']['title'] = 'Group Id';
$qadmin_def['group_id']['field'] = 'group_id';
$qadmin_def['group_id']['type'] = 'hidden';
$qadmin_def['group_id']['size'] = 5;
$qadmin_def['group_id']['value'] = 'SSHOW';

// page_body :: blob :: 65535
$qadmin_def['page_body']['title'] = 'Page Body';
$qadmin_def['page_body']['field'] = 'page_body';
$qadmin_def['page_body']['type'] = 'hidden';
$qadmin_def['page_body']['size'] = 255;
$qadmin_def['page_body']['value'] = 'This page is part of SlideShow module. Please use SlideShow Manager to edit this page.';

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
$qadmin_cfg['action'] = 'task.php?mod=slideshow&run=edit.php';

// folder configuration (qAdmin only stores filename.ext without folder location), ends without slash '/' - optional
$qadmin_cfg['file_folder'] = './../public/file';					// folder to place file upload (relative to /admin folder)
$qadmin_cfg['img_folder'] = './../public/image';				// folder to place image upload
$qadmin_cfg['thumb_folder'] = './../public/thumb';			// folder to place thumb (auto generated)

// search configuration
$qadmin_cfg['search_key'] = 'page_id,page_image,page_title,page_keyword';		// list other key to search
$qadmin_cfg['search_key_mask'] = 'ID,Image,Title/Description,URL';	// mask other key

// enable qadmin functions, which are: search, list, new, update & remove
$qadmin_cfg['cmd_default'] = 'list';						// if this script called without ANY parameter
$qadmin_cfg['cmd_search_enable'] = true;
$qadmin_cfg['cmd_list_enable'] = true;
$qadmin_cfg['cmd_new_enable'] = true;
$qadmin_cfg['cmd_update_enable'] = true;
$qadmin_cfg['cmd_remove_enable'] = true;

$qadmin_cfg['search_filterby'] = 'group_id=\'SSHOW\'';	// filter by sql_query (use , to separate queries) *
$qadmin_cfg['search_filtermask'] = 'Slideshow Items';				// mask filter *

// security *** qADMIN CAN NOT RUN IF admin_level NOT DEFINED ***
// Highest to lowest: 5, 4, 3, 2, 1
// higher level can access lower level features [ 4 should be good, 5 is too high and should be used in a very important area ]
$qadmin_cfg['admin_level'] = '4';

// form title
$qadmin_title['new'] = 'Add a Slide';
$qadmin_title['update'] = 'Update a Slide';
$qadmin_title['search'] = 'Search Slide';
$qadmin_title['list'] = 'Slide List';
qadmin_manage($qadmin_def, $qadmin_cfg, $qadmin_title);
