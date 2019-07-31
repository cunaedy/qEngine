<?php
// qform, the fastest (laziest) way to create form

define('LOG_ADD', 1);
define('LOG_EDIT', 2);
define('LOG_DEL', 3);
define('LOG_UPLOAD', 4);
define('LOG_DEL_FILE', 5);

###############
###
### Support functions
###
###############


// create random & unique filename
function get_filename($table, $field, $fn)
{
    $ok = false;
    $foo = pathinfo($fn);
    $ext = $foo['extension'];
    while (!$ok) {
        $tmp_name = random_str(16).'.'.$ext;
        $res = sql_query("SELECT * FROM $table WHERE $field='$tmp_name' LIMIT 1");
        $row = sql_fetch_array($res);
        if (empty($row)) {
            $ok = true;
        }
    }
    return $tmp_name;
}


/**
 * Log all changes made by qForm
 *
 * @param string	$pid 		Primary ID of the logged item
 * @param string	$title		Title of the logged item
 * @param int		$action		See constants above
 * @param array		$old		Old values (empty to ignore) ARRAY
 * @param array		$new		New values (empty to ignore) ARRAY
 * @param string	$table		Table name
 * @param int		$log_parent the parent of the log. If defined, this log will not be displayed qform_log; but when [restored], this log will also be restored.
 * @return void
 */
function qform_log($pid, $title, $action, $old, $new, $table, $log_parent = 0)
{
    global $current_user_id, $db_prefix, $dbh;
    $fn = basename($_SERVER['SCRIPT_NAME']);

    // serialize old & new values
    if (is_array($old)) {
        foreach ($old as $k => $v) {
            // if new = old -> no changes, remove value to save space
            if (!empty($new[$k])) {
                if ($old[$k] == $new[$k]) {
                    unset($old[$k], $new[$k]);
                }
            }

            // if new = old = empty -> remove to save space
            if (empty($new[$k]) && empty($old[$k])) {
                unset($old[$k], $new[$k]);
            }
        }
    }

    if (!empty($old)) {
        $old = base64_encode(gzcompress(serialize($old)));
    }
    if (!empty($new)) {
        $new = base64_encode(gzcompress(serialize($new)));
    }
    if (is_array($old)) {
        $old = false;
    }
    if (is_array($new)) {
        $new = false;
    }
    $ip = get_ip_address();

    // log saved if there are changes, otherwise do not save log
    if ($old || $new) {
        sql_query("INSERT INTO ".$db_prefix."qform_log
			SET log_parent='$log_parent', log_date=UNIX_TIMESTAMP(), log_file='$fn', log_table='$table', log_user='$current_user_id', log_ip='$ip', log_pid='$pid', log_title='$title', log_action='$action', log_previous='$old', log_now='$new'");

        if ($i = mysqli_insert_id($dbh)) {
            return $i;
        }
    }

    return false;
}


// get current qform cmd
// $cmd_default = can be use to be returned when no valid cmd
function qform_get_cmd($cmd_default = '')
{
    // try GET
    $cmd = get_param('qform_cmd');
    $id = get_param('id');
    if (empty($id)) {
        $id = get_param('primary_val');
    }

    //  get cmd from POST
    if (empty($cmd)) {
        $cmd = post_param('qform_cmd');
    }
    if (empty($id)) {
        $id = post_param('primary_val');
    }

    // manage cmd
    if (!empty($id) && !$cmd) {
        $cmd = 'update';
    }
    if (empty($cmd)) {
        $cmd = $cmd_default;
    }

    // process?
    if (post_param('qform_process') || $cmd == 'remove_item') {
        $process = true;
    } else {
        $process = false;
    }
    if ($process && !$id) {
        $cmd = 'new';
    }

    return array('cmd' => $cmd, 'id' => $id, 'process' => $process);
}


###############
###
### Compile (display) qform
###
###############


// $def = data definition
// $cfg = configuration
function qform_compile($def, $cfg)
{
    global $config, $tpl_section, $tpl_block, $db_prefix, $lang;

    // init
    $tmp = '';
    $tab_list = $row = $ezd = array();
    $file = false;
    if (empty($cfg['action'])) {
        $t = parse_url(urldecode(cur_url()));
        $cfg['action'] = basename($t['path']);
    }

    if (strpos($cfg['action'], '?')) {
        $cfg['action'] .= '&';
    } else {
        $cfg['action'] .= '?';
    }

    // template
    load_section($cfg['tpl_file']);
    load_section($cfg['ezd_file']);

    // buttons
    $cfg['tab_list'] = '';
    if (empty($cfg['back'])) {
        $cfg['back'] = $cfg['action'];
    } else {
        $cfg['back'] = $cfg['back'];
    }

    if ($cfg['cmd_new_enable']) {
        $cfg['savenew_button'] = $tpl_section['qform_savenew_button'];
    } else {
        $cfg['savenew_button'] = '';
    }

    // sql query
    if (($cfg['cmd'] == 'update') && !$cfg['update_ignore_value']) {
        $res = sql_query("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$cfg[primary_val]' LIMIT 1");
        $def_val = sql_fetch_array($res);
    } else {
        $def_val = create_blank_tbl($cfg['table']);
    }

    if (($cfg['cmd'] == 'update') && empty($def_val) && !$cfg['update_ignore_value']) {
        msg_die($cfg['msg']['item_not_found']);
    }

    // form already filled?
    $f = load_form($cfg['table']);
    if (!empty($f)) {
        $def_val = $form_val = $f;
    }	// $def_val = we replace values from sql; but some field needs further processing (eg date/time), so we use $form_val

    // field
    foreach ($def as $key=>$val) {
        $val['value'] = empty($val['value']) ? '' : $val['value'];
        $val['size'] = empty($val['size']) ? 0 : $val['size'];
        $val['help'] = empty($val['help']) ? '' : addslashes($val['help']);
        $val['prefix'] = !empty($val['prefix']) ? $val['prefix'] : '';
        $val['suffix'] = !empty($val['suffix']) ? $val['suffix'] : '';
        $val['disabled'] = empty($val['disabled']) ? '' : 'disabled="disabled"';
        $val['thisid'] = $cfg['table'].'-'.$val['field'];

        if ($val['value'] == 'sql') {
            $val['value'] = !isset($def_val[$val['field']]) ? '' : $def_val[$val['field']];
        }
        if (empty($val['help'])) {
            $val['help'] = $val['ezd_help'] = '';
        } else {
            $val['ezd_help'] = quick_tpl($tpl_section['ezd_help'], $val);
            $val['help'] = quick_tpl($tpl_section['qform_help'], $val);
        }

        if (empty($val['required'])) {
            $val['required'] = $val['required_js'] = $val['ezd_required'] = $val['ezd_required_js'] = '';
        } else {
            $val['required'] = quick_tpl($tpl_section['qform_required'], 0);
            $val['required_js'] = quick_tpl($tpl_section['qform_required_js'], 0);
            $val['ezd_required'] = quick_tpl($tpl_section['ezd_required'], 0);
            $val['ezd_required_js'] = quick_tpl($tpl_section['ezd_required_js'], 0);
        }

        if (empty($val['type'])) {
            die("<b>Error!</b> $val[field] doesn\'t have type!");
        }
        switch ($val['type']) {
            // plain text
            case 'echo':
                if (empty($val['value'])) {
                    $val['value'] = '&nbsp;';
                }
                $tmp .= quick_tpl($tpl_section['qform_echo'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_echo'], $val);
            break;


            // link
            case 'url':
                $val['maxlength'] = $val['size'];
                $tmp .= quick_tpl($tpl_section['qform_url'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_url'], $val);
            break;

            // disabled
            case 'disabled':
                $tmp .= quick_tpl($tpl_section['qform_disabled'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_disabled'], $val);
            break;

            // hidden value
            case 'hidden':
                $tmp .= "<tr><td colspan=\"2\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin:0;padding:0;border:none\"><input type=\"hidden\" name=\"$val[field]\" value=\"$val[value]\" /></td></tr>";
                $ezd['ezd_'.$key] = "<input type=\"hidden\" name=\"$val[field]\" value=\"$val[value]\" />";
            break;

            // static (a combination of echo & hidden)
            case 'static':
                if (!empty($val['option'])) {
                    $val['display_value'] = empty($val['option'][$val['value']]) ? '-' : $val['option'][$val['value']];
                } else {
                    $val['display_value'] = $val['value'];
                }
                $tmp .= quick_tpl($tpl_section['qform_static'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_static'], $val);
            break;

            // email
            case 'email':
                $val['maxlength'] = $val['size'];
                $val['size'] = $val['size'] > 50 ? 50 : $val['size'];

                if (!empty($val['value'])) {
                    $tmp .= quick_tpl($tpl_section['qform_email'], $val);
                    $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_email'], $val);
                } else {
                    $tmp .= quick_tpl($tpl_section['qform_varchar'], $val);
                    $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_varchar'], $val);
                }
            break;

            // divider
            case 'divider':
            case 'div':
                $tab_list[] = $val['title'];
                $val['tabindex'] = count($tab_list) + 1;
                $tmp .= quick_tpl($tpl_section['qform_divider'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_divider'], $val);
            break;

            // mask
            case 'mask':
                $val['value'] = empty($val['option'][$val['value']]) ? '-' : $val['option'][$val['value']];
                $tmp .= quick_tpl($tpl_section['qform_echo'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_echo'], $val);
            break;

            // short text
            case 'varchar':
            case 'permalink':
            case 'password':
                $val['maxlength'] = $val['size'];
                $val['size'] = $val['size'] > 50 ? 50 : $val['size'];

                if ($val['type'] == 'varchar') {
                    $tmp .= quick_tpl($tpl_section['qform_varchar'], $val);
                    $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_varchar'], $val);
                } elseif ($val['type'] == 'permalink') {
                    if (empty($val['value'])) {
                        $val['permalink_path'] = empty($cfg['permalink_folder']) ? $config['site_url'].'/' : $config['site_url'].'/'.$cfg['permalink_folder'].'/';
                    } else {
                        $val['permalink_path'] = $config['site_url'].'/';
                    }

                    if (empty($val['help'])) {
                        $val['help'] = 'Create a search engine friendly URL. Leave empty to auto generate, or enter your own url.';
                        $val['help'] = quick_tpl($tpl_section['qform_help'], $val);
                    }
                    $val['size'] = $val['size'] > 32 ? 32 : $val['size'];
                    $tmp .= $ezd['ezd_'.$key] = quick_tpl($tpl_section['qform_permalink'], $val);
                    $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_permalink'], $val);
                } else {
                    $tmp .= $ezd['ezd_'.$key] = quick_tpl($tpl_section['qform_password'], $val);
                    $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_password'], $val);
                }
            break;

            // date
            case 'date':
                if (empty($val['value'])) {
                    $val['value'] = 'today';
                }

                // user_val = user entered val in a form (some fields don't need more processing, but others ~like this one~ need more processing)
                if (!empty($form_val[$key])) {
                    $val['value'] = date_param($key, $form_val[$key]);
                }
                $val['date_select'] = date_form($val['field'], $val['value']);

                $tmp .= quick_tpl($tpl_section['qform_date'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_date'], $val);
            break;

            // time
            case 'time':
                if (empty($val['value'])) {
                    $val['value'] = 'now';
                }
                if (!empty($form_val[$key.'_hou'])) {
                    $val['value'] = $form_val[$key.'_hou'].':'.$form_val[$key.'_min'];
                }
                $val['time_select'] = time_form($val['field'], $val['value']);
                $tmp .= quick_tpl($tpl_section['qform_time'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_time'], $val);
            break;

            // text - $row['size'] is in "x,y"
            case 'text':
            case 'textarea':
                if (empty($val['size'])) {
                    $val['size'] = '500,200';
                }
                $s = explode(',', $val['size']);

                $val['x'] = $s[0]; $val['y'] = $s[1];
                $tmp .= quick_tpl($tpl_section['qform_text'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_text'], $val);
            break;

            // code - $row['size'] is in "x,y"
            case 'code':
                if (empty($val['lang'])) {
                    $val['lang'] = 'html';
                }
                $s = explode(',', $val['size']);
                if (empty($val['size'])) {
                    $val['code_area'] = code_editor_area($val['field'], $val['value'], $val['lang']);
                } else {
                    $val['code_area'] = code_editor_area($val['field'], $val['value'], $val['lang'], $s[0], $s[1]);
                }

                $tmp .= quick_tpl($tpl_section['qform_code'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_code'], $val);
            break;

            // rte - $row['size'] is in "x,y"
            case 'wysiwyg':
                $s = explode(',', $val['size']);
                if (!empty($form_val[$key])) {
                    $val['value'] = html_entity_decode($val['value']);
                }
                if (!empty($val['wysiwyg_pagebreak'])) {
                    $pagebreak = true;
                } else {
                    $pagebreak = false;
                }
                if (empty($val['size'])) {
                    $val['rte_area'] = rte_area($val['field'], $val['value'], 0, 0, $pagebreak);
                } else {
                    $val['rte_area'] = rte_area($val['field'], $val['value'], $s[0], $s[1], $pagebreak);
                }
                $tmp .= quick_tpl($tpl_section['qform_wysiwyg'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_wysiwyg'], $val);
            break;

            // select
            case 'select':
                $val['edit_opt'] = '';
                if (!empty($val['editopt'])) {
                    $val['edit_opt'] = quick_tpl($tpl_section['qform_edit_opt'], $val);
                    $val['option'] = get_editable_option($val['editopt']);
                }
                if (!empty($val['required'])) {
                    $val['data_select'] = create_select_form($val['field'], $val['option'], $val['value'], '[ Select ]', 0, 'required="required" class="form-control" '.$val['disabled']);
                } else {
                    $val['data_select'] = create_select_form($val['field'], $val['option'], $val['value'], '[ Select ]', 0, 'class="form-control" '.$val['disabled']);
                }
                $tmp .= quick_tpl($tpl_section['qform_select'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_select'], $val);
            break;

            // radio
            case 'radio':
            case 'radioh':
                $val['edit_opt'] = '';
                if (!empty($val['editopt'])) {
                    $val['edit_opt'] = quick_tpl($tpl_section['qform_edit_opt'], $val);
                    $val['option'] = get_editable_option($val['editopt']);
                }

                foreach ($val['option'] as $k => $v) {
                    $val['option'][$k] = str_replace('\n', '<br />', $v);
                }
                $val['data_radio'] = create_radio_form($val['field'], $val['option'], $val['value'], 'h', 1, $val['disabled']);
                $tmp .= quick_tpl($tpl_section['qform_radioh'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_radioh'], $val);
            break;

            // radio
            case 'radiov':
                $val['edit_opt'] = '';
                if (!empty($val['editopt'])) {
                    $val['edit_opt'] = quick_tpl($tpl_section['qform_edit_opt'], $val);
                    $val['option'] = get_editable_option($val['editopt']);
                }

                foreach ($val['option'] as $k => $v) {
                    $val['option'][$k] = str_replace('\n', '<br />', $v);
                }
                $val['data_radio'] = create_radio_form($val['field'], $val['option'], $val['value'], 'v', 1, $val['disabled']);
                $tmp .= quick_tpl($tpl_section['qform_radiov'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_radiov'], $val);
            break;

            // file
            case 'file':
                $file = true;
                if (!empty($val['value'])) {
                    $val['view'] = $cfg['file_folder'].'/'.$val['value'];
                    @$val['size'] = num_format(filesize($val['view']));
                    $val['remove'] = $cfg['action']."qform_cmd=remove_file&amp;field=$val[field]&amp;primary_val=$cfg[primary_val]";
                    $val['viewfile'] = quick_tpl($tpl_section['qform_viewfile'], $val);
                    $val['ezd_viewfile'] = quick_tpl($tpl_section['ezd_viewfile'], $val);
                } else {
                    $val['viewfile'] = quick_tpl($tpl_section['qform_upload'], $val);
                    $val['ezd_viewfile'] = quick_tpl($tpl_section['ezd_upload'], $val);
                }
                $tmp .= quick_tpl($tpl_section['qform_file'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_file'], $val);
            break;

            // image
            case 'img':
            case 'image':
                $file = true;
                if (!empty($val['value'])) {
                    $val['view'] = $cfg['img_folder'].'/'.$val['value'];
                    @$val['size'] = num_format(filesize($val['view']));
                    $val['remove'] = $cfg['action']."qform_cmd=remove_file&amp;field=$val[field]&amp;primary_val=$cfg[primary_val]";
                    $val['viewimg'] = quick_tpl($tpl_section['qform_viewimg'], $val);
                    $val['ezd_viewimg'] = quick_tpl($tpl_section['ezd_viewimg'], $val);
                } else {
                    $val['viewimg'] = quick_tpl($tpl_section['qform_upload'], $val);
                    $val['ezd_viewimg'] = quick_tpl($tpl_section['ezd_upload'], $val);
                }
                $tmp .= quick_tpl($tpl_section['qform_img'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_img'], $val);
            break;

            // image series
            case 'img_set':
            case 'img_series':
                $file = true;
                $ok = false; $i = 0;
                $val['viewimg'] = '';
                if ($cfg['cmd'] == 'update') {
                    while (!$ok) {
                        $i++;
                        $fn = $val['prefix'].'_'.$cfg['primary_val'].'_'.$i;
                        $img_th = "$cfg[thumb_folder]/$fn.jpg";
                        $img_src = "$cfg[img_folder]/$fn.jpg";
                        if (file_exists($img_src)) {   // if thumbs avail
                            $val['view'] = $img_src;
                            @$val['size'] = num_format(filesize($img_src));
                            $val['remove'] = "<a href=\"".$cfg['action']."qform_cmd=remove_file&amp;field=$val[field]&amp;primary_val=$cfg[primary_val]&amp;idx=$i\"><span class=\"glyphicon glyphicon-remove\"></span> Delete</a>";
                            $val['viewimg'] .= "<p><a href=\"$img_src\" class=\"lightbox\"><img src=\"$img_th\" alt=\"image\" /></a><br /><span class=\"glyphicon glyphicon-file\"></span> $val[size] bytes $val[remove]</p>";
                        } else {
                            $ok = true;
                        }
                    }
                }
                $val['upload'] = quick_tpl($tpl_section['qform_upload'], $val);
                $tmp .= quick_tpl($tpl_section['qform_img_set'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_img_set'], $val);
            break;

            // image + thumb
            case 'thumb':
                $file = true;
                if (!empty($val['value'])) {
                    $val['view'] = $cfg['img_folder'].'/'.$val['value'];
                    $val['thumb'] = $cfg['thumb_folder'].'/'.$val['value'];
                    $val['size'] = num_format(filesize($val['view']));
                    $val['remove'] = $cfg['action']."qform_cmd=remove_file&amp;field=$val[field]&amp;primary_val=$cfg[primary_val]";
                    $val['viewthumb'] = quick_tpl($tpl_section['qform_viewthumb'], $val);
                } else {
                    $val['viewthumb'] = quick_tpl($tpl_section['qform_upload'], $val);
                }
                $tmp .= quick_tpl($tpl_section['qform_thumb'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_thumb'], $val);
            break;

            // image resize
            case 'img_resize':
            case 'image_resize':
                $file = true;
                if (!empty($val['value'])) {
                    $val['view'] = $cfg['img_folder'].'/'.$val['value'];
                    $val['size'] = num_format(filesize($val['view']));
                    $val['remove'] = $cfg['action']."qform_cmd=remove_file&amp;field=$val[field]&amp;primary_val=$cfg[primary_val]";
                    $val['viewimg'] = quick_tpl($tpl_section['qform_viewimg'], $val);
                } else {
                    $val['viewimg'] = quick_tpl($tpl_section['qform_upload'], $val);
                };
                $tmp .= quick_tpl($tpl_section['qform_img_resize'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_img_resize'], $val);
            break;

            // multi = stored as: <opt>\r\n<opt>\r\n<opt>
            // multi, = stored as: ,opt,opt,opt,	(make searching easier with LIKE %,opt,%)
            // multicsv = stored as: opt,opt,opt
            // multiselect = same with "multi," -> but displayed as <select>
            case 'multi':
            case 'multi,':
            case 'multicsv':
            case 'multiselect':
                $val['edit_opt'] = '';
                if (!empty($val['editopt'])) {
                    $val['edit_opt'] = quick_tpl($tpl_section['qform_edit_opt'], $val);
                    $val['option'] = get_editable_option($val['editopt']);
                }

                if (empty($val['size'])) {
                    $val['size'] = 3;
                }

                if (!is_array($val['value'])) {
                    if ($val['type'] == 'multi') {
                        $val['value'] = explode("\r\n", $val['value']);
                    } elseif (($val['type'] == 'multi,') || ($val['type'] == 'multiselect')) {
                        $val['value'] = explode(',', substr($val['value'], 1, -1));
                    } else {
                        $val['value'] = explode(',', $val['value']);
                    }
                }

                $fuu = array();
                if (!empty($form_val)) {
                    foreach ($form_val as $fk => $fv) {
                        if (strpos('*'.$fk, $key) == 1) {
                            $fuu[] = $fv;
                        }
                    }
                }	// to make things easier, find '*[field_name]' in form_val, not '[field_name]' :-)
                if (!empty($fuu)) {
                    $val['value'] = $fuu;
                }
                foreach ($val['option'] as $k => $v) {
                    $val['option'][$k] = str_replace('\n', '<br />', $v);
                }

                if ($val['type'] == 'multiselect') {
                    $val['data_multi'] = cform_multiselect($val['field'].'[]', $val['option'], $val['value']);
                } else {
                    $val['data_multi'] = create_checkbox_form($val['field'], $val['option'], $val['value'], $val['size'], 'qform_form');
                }
                $tmp .= quick_tpl($tpl_section['qform_multi'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_multi'], $val);
            break;

            //
            case 'rating':
                global $rating_def;
                $val['edit_opt'] = '';
                $val['data_select'] = create_select_form($val['field'], $rating_def, $val['value'], '', $val['disabled']);
                $tmp .= quick_tpl($tpl_section['qform_select'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_select'], $val);
            break;

            //
            case 'checkbox':
                $val['checkbox'] = create_tickbox_form($val['field'], $val['option'], $val['value']);
                $tmp .= quick_tpl($tpl_section['qform_checkbox'], $val);
                $ezd['ezd_'.$key] = quick_tpl($tpl_section['ezd_checkbox'], $val);
            break;

            // what?
            default:
                die("<b>Error!</b> $val[field] has unrecognized type of $val[type]!");
            break;
        }
    }

    // tabs
    $i = 1;
    foreach ($tab_list as $k => $v) {
        $i++;
        $tb = array('i' => $i, 'title' => $v);
        $cfg['tab_list'] .= quick_tpl($tpl_section['qform_tab_list_li'], $tb);
    }

    // show captchai
    if (!empty($cfg['captcha'])) {
        qvc_init();
        $tmp .= $ezd['ezd_qform_captcha'] = quick_tpl($tpl_section['qform_captcha'], $val);
    }

    // show remove item (on UPDATE mode)
    if (($cfg['cmd'] == 'update') && ($cfg['cmd_remove_enable'])) {
        $tmp .= $ezd['ezd_qform_remove_item'] = quick_tpl($tpl_section['qform_remove'], $cfg);
    }

    // last update
    if ($cfg['cmd'] == 'new') {
        $cfg['last_update'] = $ezd['ezd_last_update'] = '';
    } elseif ($cfg['cmd'] == 'update') {
        if ($cfg['enable_log']) {
            $fn = basename($_SERVER['SCRIPT_NAME']);
            $tlog = sql_qquery("SELECT COUNT(*) AS count FROM ".$db_prefix."qform_log WHERE log_file='$fn' AND log_pid='$cfg[primary_val]' AND log_parent='0' LIMIT 1");
            $rlog = sql_qquery("SELECT log_date, log_user FROM ".$db_prefix."qform_log WHERE log_file='$fn' AND log_pid='$cfg[primary_val]' ORDER BY log_id DESC LIMIT 1");
            $last_update = date('Y-m-d H:i:s', $rlog['log_date']);
            $log['log_count'] = $tlog['count'];
            $log['log_last_time'] = $last_update;
            $log['log_last_user'] = ($rlog['log_user']) ? $rlog['log_user'] : '';
            $log['fn'] = $fn;
            $log['id'] = $cfg['primary_val'];
            $cfg['last_update'] = "<p class=\"small\">This entry has been updated $tlog[count]&times;, last updated at $last_update by $rlog[log_user] <a href=\"qform_log.php?w=pid&amp;h=$fn&amp;pid=$cfg[primary_val]\" class=\"btn btn-default btn-xs\"><span class=\"glyphicon glyphicon-zoom-in\"></span> See details or restore changes</a></p>";
            $ezd['ezd_last_update'] = quick_tpl($tpl_section['ezd_last_update'], $log);
        } else {
            $ezd['ezd_last_update'] = $cfg['last_update'] = '(Log has been disabled)';
        }
    }


    // table header & footer
    if ($file) {
        $cfg['enctype'] = 'multipart/form-data';
    } else {
        $cfg['enctype'] = 'application/x-www-form-urlencoded';
    }
    $row['title'] = $cfg['title'];
    $head = quick_tpl($tpl_section['qform_head'], $cfg);
    $ezd['ezd_qform_head'] = quick_tpl($tpl_section['ezd_head'], $cfg);

    $head_inner = quick_tpl($tpl_section['qform_head_inner'], $cfg);
    $ezd['ezd_qform_head_inner'] = quick_tpl($tpl_section['ezd_head_inner'], $cfg);

    $foot_inner = quick_tpl($tpl_section['qform_foot_inner'], $cfg);
    $ezd['ezd_qform_foot_inner'] = quick_tpl($tpl_section['ezd_foot_inner'], $cfg);

    $foot = quick_tpl($tpl_section['qform_foot'], $cfg);
    $ezd['ezd_qform_foot'] = quick_tpl($tpl_section['ezd_foot'], $cfg);

    // additional header & footer
    if (!empty($cfg['header'])) {
        $head = $cfg['header'].$head;
    }
    if (!empty($cfg['footer'])) {
        $foot = $foot.$cfg['footer'];
    }

    if ($cfg['ezd_mode']) {
        return $ezd;
    } else {
        return $head.$head_inner.$tmp.$foot_inner.$foot;
    }
}


###############
###
### Form processor (add / edit item)
###
###############


function qform_process($def, $cfg)
{
    global $config, $db_prefix, $dbh, $lang;

    // AXSRF
    if ($cfg['auto_save_changes']) {
        AXSRF_check();
    }

    // init (sql = sql query, output = array, eml = emailed string, err = required error, fs_query = do fast search for xxx
    $sql = $output = $eml = $err = $fs_query= array();
    $index_first = true;
    $permalink_changed = false;
    $permalink = '';
    $cfg['cmd'] = $qform_cmd = post_param('qform_cmd');
    $primary_val = post_param('primary_val');
    $savenew = post_param('qform_savenew');
    $isAjax = post_param('isAjax');

    // enforce proper cmd
    if (!$primary_val) {
        $cfg['cmd'] = $qform_cmd = 'new';
    } else {
        $cfg['cmd'] = $qform_cmd = 'update';
    }

    // pre process
    if (!empty($cfg['pre_process'])) {
        if (function_exists($cfg['pre_process'])) {
            call_user_func($cfg['pre_process'], $cfg['cmd'], $primary_val);
        }
    }

    // old value for ajax, as not all fields are required in ajax, so we may need to re-use old values
    if ($isAjax) {
        $isAjax = true;
        if ($cfg['cmd'] == 'update') {
            $old = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$primary_val' LIMIT 1");
        } else {
            $old = create_blank_tbl($cfg['table']);
        }

        foreach ($old as $k => $v) {
            $old[$k] = addslashes($v);
        }

        // remove suffix if necessary
        if ($cfg['allow_ajax_suffix']) {
            $suf = $cfg['allow_ajax_suffix'].$primary_val;
            $sufn = strlen($suf);
            foreach ($_POST as $k => $v) {
                if (substr($k, $sufn * -1) == $suf) {
                    $kk = substr($k, 0, $sufn * -1);
                    $_POST[$kk] = $v;
                }
            }
        }
    } else {
        $isAjax = false;
    }

    // save form
    save_form($cfg['table']);

    // captchai
    if (!empty($cfg['captcha'])) {
        $visual = qhash(post_param('visual'));
        if ($visual != qvc_value()) {
            msg_die($cfg['msg']['captcha_error']);
        }
    }

    // field
    foreach ($def as $key=>$val) {
        unset($tt, $et);
        if (!isset($val['disabled'])) {
            $val['disabled'] = false;
        }
        if (!$val['disabled']) {
            switch ($val['type']) {
            // short text
            case 'varchar':
            case 'email':
            case 'url':
                $t = post_param($val['field'], false);

                if (!empty($val['unique'])) {
                    if ($cfg['cmd'] == 'new') {
                        $foo = sql_qquery("SELECT * FROM $cfg[table] WHERE ($val[field]='$t') LIMIT 1");
                    } else {
                        $foo = sql_qquery("SELECT * FROM $cfg[table] WHERE ($val[field]='$t') AND ($cfg[primary_key] != '$primary_val') LIMIT 1");
                    }
                    if (!empty($foo)) {
                        $err[] = $val['title'].' must be unique!';
                    }
                }
                if ($t !== false) {
                    $et = $tt = $t;
                }	// $tt = for sql queries, $et = for email report. Value must be set (empty string or 0 is accepted, but false or not set is not accepted)
            break;


            case 'permalink':
                if (empty($cfg['permalink_source']) || empty($cfg['permalink_script'])) {
                    msg_die($cfg['msg']['permalink_error']);
                }
                if (empty($cfg['permalink_param'])) {
                    $cfg['permalink_param'] = '';
                }
                if (empty($cfg['permalink_folder'])) {
                    $cfg['permalink_folder'] = '';
                }
                $t = post_param($val['field'], false);
                if (empty($t)) {
                    $t = post_param($cfg['permalink_source']);
                    $auto = true;
                } else {
                    $auto = false;
                }

                $permalink_cfg = array();	// so we can reuse it later
                $permalink_cfg['source'] = $cfg['permalink_source'];
                $permalink_cfg['script'] = $cfg['permalink_script'];
                $permalink_cfg['param'] = $cfg['permalink_param'];
                $permalink_cfg['folder'] = $cfg['permalink_folder'];
                $permalink_cfg['title'] = $t;
                $permalink_cfg['auto'] = $auto;
                $permalink = generate_permalink($permalink_cfg['title'], $permalink_cfg['script'], $primary_val, $permalink_cfg['param'], $permalink_cfg['folder'], $permalink_cfg['auto']);
                if (!$permalink) {
                    $err[] = $val['title'].' must be unique!';
                }
                if ($t !== false) {
                    $et = $tt = $permalink;
                }	// $tt = for sql queries, $et = for email report

                // permalink db must be updated/inserted to permalink db after qform finish (see below)
            break;

            case 'text':
            case 'textarea':
            case 'hidden':
            case 'static':
            case 'disabled':
                $t = post_param($val['field'], false);
                if ($t !== false) {
                    $et = $tt = $t;
                }	// $tt = for sql queries, $et = for email report
            break;

            case 'checkbox':
                $t = post_param($val['field'], 0);
                if ($t !== false) {
                    $et = $tt = $t;
                }	// $tt = for sql queries, $et = for email report
            break;

            case 'select':
            case 'radio':
            case 'radioh':
            case 'radiov':
                $val['edit_opt'] = '';
                if (!empty($val['editopt'])) {
                    $val['option'] = get_editable_option($val['editopt']);
                }

                $t = post_param($val['field'], false);
                if ($t !== false) {
                    $tt = $t;	// $tt = for sql queries, $et = for email report
                    @$et = $val['option'][$t];
                    if (empty($t)) {
                        $et = '(None selected)';
                    }
                }
            break;

            // multi = stored as: <opt>\r\n<opt>\r\n<opt>
            // multi, = stored as: ,opt,opt,opt,	(make searching easier with LIKE %,opt,%)
            // multicsv = stored as: opt,opt,opt
            case 'multi':
            case 'multi,':
            case 'multicsv':
            case 'multiselect':
                $val['edit_opt'] = '';
                if (!empty($val['editopt'])) {
                    $val['option'] = get_editable_option($val['editopt']);
                }
                if ($val['type'] == 'multiselect') {
                    $t = post_param($val['field']);
                } else {
                    $t = checkbox_param($val['field'], 'post', true);
                }

                if (!$t) {
                    $t = array();
                }

                if ($val['type'] == 'multi') {
                    $tt = implode("\r\n", $t);
                } elseif (($val['type'] == 'multi,') || ($val['type'] == 'multiselect')) {
                    $tt = ','.implode(',', $t).',';
                } else {
                    $tt = implode(',', $t);
                }

                // email values
                $foo = array();
                $et = implode("<br />", $foo);
            break;

            // password
            case 'password':
                $t = post_param($val['field']);
                if (!empty($t)) {
                    $tt = qhash($t);
                    $et = $t;
                } else {
                    unset($tt, $et);
                }

            break;

            // date
            case 'date':
                $t = date_param($val['field'], 'post', true);
                if (!empty($t)) {
                    $tt = $et = $t;
                }
            break;

            // time
            case 'time':
                $t = time_param($val['field'], 'post', true);
                if (!empty($t)) {
                    $tt = $et = $t;
                }
            break;

            // ode
            case 'code':
                $t = post_param($val['field'], false, 'rte');
                if ($t !== false) {
                    $tt = $et = $t;
                }
            break;

            // rte
            case 'wysiwyg':
                $t = post_param($val['field'], false, 'rte');
                if ($t !== false) {
                    $tt = $et = $t;
                }
            break;

            // file
            case 'file':
            case 'img':
            case 'image':
                if (!empty($_FILES[$val['field']]['name']) && (!$config['demo_mode'])) {
                    $fm = $_FILES[$val['field']]['tmp_name'];
                    $fn = $_FILES[$val['field']]['name'];
                    if (!empty($val['rename'])) {
                        $rnd = true;
                    } else {
                        $rnd = false;
                    }
                    if ($val['type'] == 'file') {
                        $fn = create_filename($cfg['file_folder'], $fn, $rnd);
                        $fl = $cfg['file_folder'].'/'.$fn;
                    } else {
                        $fn = create_filename($cfg['img_folder'], $fn, $rnd);
                        $fl = $cfg['img_folder'].'/'.$fn;
                    }
                    $x = upload_file($val['field'], $fl);
                    if (!$x['success']) {
                        msg_die($cfg['msg']['can_not_upload']);
                    }

                    // get new name
                    $fn = $x[0]['filename'];
                    $fl = $cfg['img_folder'].'/'.$fn;
                    $ft = $cfg['thumb_folder'].'/'.$fn;
                    @chmod($fl, 0644);

                    $tt = $fn;
                    if ($val['type'] == 'file') {
                        $et = "<a href=\"$config[site_url]/$fl\">$config[site_url]/$fl</a>";
                    } else {
                        if (!empty($config['watermark_file'])) {
                            image_watermark($fl, './../public/image/'.$config['watermark_file']);
                        }
                        $et = "<img src=\"$config[site_url]/$fl\"><br /><a href=\"$config[site_url]/$fl\">$config[site_url]/$fl</a>";
                    }
                }
            break;

            // thumb
            case 'thumb':
                if (!empty($_FILES[$val['field']]['name']) && !$config['demo_mode']) {
                    $fn = $_FILES[$val['field']]['name'];
                    $fm = $_FILES[$val['field']]['tmp_name'];
                    if (!empty($val['rename'])) {
                        $fn = get_filename($cfg['table'], $val['field'], $fn);
                    }

                    $fl = $cfg['img_folder'].'/'.$fn;
                    $ft = $cfg['thumb_folder'].'/'.$fn;
                    $x = upload_file($val['field'], $fl);
                    if (!$x['success']) {
                        msg_die($cfg['msg']['can_not_upload']);
                    }

                    // get new name
                    $fn = $x[0]['filename'];
                    $fl = $cfg['img_folder'].'/'.$fn;
                    $ft = $cfg['thumb_folder'].'/'.$fn;
                    @chmod($fl, 0644);

                    if (!empty($config['watermark_file'])) {
                        image_watermark($fl, './../public/image/'.$config['watermark_file']);
                    }

                    // create thumb
                    $size = empty($val['size']) ? 'thumb' : $val['size'];
                    image_optimizer($fl, $ft, $config['thumb_quality'], $size);

                    $tt = $fn;
                    $et = "<a href=\"$config[site_url]/$fl\"><img src=\"$config[site_url]/$ft\" alt=\"image\"></a><br />"
                         ."<a href=\"$config[site_url]/$fl\">$config[site_url]/$fl</a>";
                }
            break;

            // image resizer
            case 'img_resize':
                if (!empty($_FILES[$val['field']]['name'])) {
                    $fn = $_FILES[$val['field']]['name'];
                    $fm = $_FILES[$val['field']]['tmp_name'];
                    if (!empty($val['rename'])) {
                        $fn = get_filename($cfg['table'], $val['field'], $fn);
                    }
                    if (empty($val['size'])) {
                        $val['size'] = $config['thumb_size'];
                    }
                    if (!empty($config['watermark_file'])) {
                        image_watermark($fl, './../public/image/'.$config['watermark_file']);
                    }

                    // create thumb
                    $fl = $cfg['img_folder'].'/'.$fn;
                    $img_size = GetImageSize($fm);
                    image_optimizer($fm, $fl, $config['thumb_quality'], $val['size']);

                    $tt = $fn;
                    $et = "<img src=\"$config[site_url]/$fl\"><br /><a href=\"$config[site_url]/$fl\">$config[site_url]/$fl</a>";
                }
            break;

            // image series
            case 'img_set':
            case 'img_series':
                if (!empty($_FILES[$val['field']]['tmp_name']) && !$config['demo_mode']) {
                    if ($cfg['cmd'] != 'update') {
                        $nid = sql_qquery("SHOW TABLE STATUS LIKE '$cfg[table]'");
                        $next = $nid['Auto_increment'];
                        $primary_val = $next;
                    }

                    $fm = $_FILES[$val['field']]['tmp_name'];

                    // search lastest index file for image
                    $ok = false;
                    $i = 0;
                    while (!$ok) {
                        $i++;
                        $fn = $val['prefix'].'_'.$primary_val.'_'.$i;
                        if (!file_exists("$cfg[img_folder]/$fn.jpg")) {
                            $ok = true;
                        }
                    }
                    $fl = "$cfg[img_folder]/$fn.jpg";

                    if (!empty($val['resize'])) {
                        image_optimizer($fm, $fl, $config['thumb_quality'], $val['resize']);
                    } else {
                        $x = upload_file($val['field'], $fl);
                        if (!$x['success']) {
                            msg_die($cfg['msg']['can_not_upload']);
                        }
                    }
                    @chmod($fl, 0644);

                    if (!empty($config['watermark_file'])) {
                        image_watermark($fl, './../public/image/'.$config['watermark_file']);
                    }

                    // thumb
                    $ft = $cfg['thumb_folder'].'/'.$fn;
                    $size = empty($val['thumb_size']) ? 'thumb' : $val['thumb_size'];
                    image_optimizer($fl, $ft.'.jpg', $config['thumb_quality'], $size);

                    $tt = $fn;
                    $et = "<img src=\"$config[site_url]/$fl\"><br /><a href=\"$config[site_url]/$fl\">$config[site_url]/$fl</a>";
                }
            break;
        }
        }

        // ajax?
        if ($isAjax) {
            // if field not allowed ajax, remove value
            if (empty($val['allow_ajax'])) {
                unset($tt, $et);
            }

            // if field not filled/defined, use old value
            if (!isset($tt)) {
                $tt = $et = $old[$val['field']];
            }
        }

        // required?
        if (!empty($val['required']) && empty($tt)) {
            $err[] = $val['title'].' is required!';
        }

        // sql query (only do !empty field)
        if (isset($tt)) {
            $output[$val['field']] = $tt;
            $sql[] = "$val[field] = '$tt'";
        }
        if (isset($et)) {
            $eml[] = "<tr><td valign=\"top\" class=\"form_title\"><b>$val[title]</b></td><td class=\"form_value\">$et</td></tr>";
        }

        // fast search query
        if (!empty($cfg['fastsearch']) && !empty($val['index'])) {
            $fs_query[] = $tt;
        }
    }

    // any 'required' error?
    if (!empty($err)) {
        $err = '<ul><li>'.implode('</li><li>', $err).'</li></ul>';
        msg_die(sprintf($cfg['msg']['qform_required_err'], $err));
    }

    reset_form();

    // do sql
    $sql = implode(', ', $sql);

    // if not auto_save => return as array instead
    if (!$cfg['auto_save_changes']) {
        $var_sql = array();
        foreach ($output as $k => $v) {
            $var_sql[] = "$k='\$val[$k]'";
        }
        return array('field' => $output, 'sql' => $sql, 'var_sql' => implode(', ', $var_sql), 'email' => $eml);
    }

    if ($cfg['cmd'] == 'update') {
        // create log - get previous values
        $old = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$primary_val' LIMIT 1");
        $old_values = $old;

        // update db
        if (!empty($sql)) {
            sql_query("UPDATE $cfg[table] SET $sql WHERE $cfg[primary_key]='$primary_val' LIMIT 1");
        }
        $id = $primary_val;

        // create log - get new values
        $new = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$primary_val' LIMIT 1");
        $new_values = $new;

        if (($old != $new) && !empty($cfg['enable_log'])) {
            // if not detailed_log, remove all details, but preserve title
            if (empty($cfg['detailed_log'])) {
                $foo = $old[$cfg['log_title']];
                $old = $new = array();
                $old[$cfg['log_title']] = $foo;
            }
            qform_log($primary_val, $old[$cfg['log_title']], LOG_EDIT, $old, $new, $cfg['table']);
        }
    } elseif ($cfg['cmd'] == 'new') {
        if (!empty($sql)) {
            sql_query("INSERT INTO $cfg[table] SET $sql");
        }
        $id = mysqli_insert_id($dbh);

        // create log - get previous values
        $old = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$id' LIMIT 1");
        $old_values = $new_values = $old;
        $new = array();
        if (!empty($cfg['enable_log'])) {
            qform_log($id, $old[$cfg['log_title']], LOG_ADD, $old, $new, $cfg['table']);
        }

        // if $id = 0, it means the primary key is not auto-increment, is it... varchar?
        if (empty($id)) {
            $id = post_param($cfg['primary_key']);
        }

        // send email?
        if (!empty($cfg['send_to'])) {
            global $title, $tpl_section;
            if (empty($cfg['send_subject'])) {
                $cfg['send_subject'] = 'Form Result';
            }

            load_section($cfg['tpl_file']);
            $eml = implode("\n", $eml);
            $snt['form_result'] = $eml;
            $snt['form_name'] = empty($title['new']) ? 'Form' : $title['new'];
            $snt['header'] = empty($cfg['header']) ? '' : $cfg['header'];
            $snt['footer'] = empty($cfg['footer']) ? '' : $cfg['footer'];
            $snt['site_url'] = $config['site_url'];
            $body = quick_tpl($tpl_section['qform_send_email'], $snt);
            email($cfg['send_to'], $cfg['send_subject'], $body, 1, 1);
        }
    }

    // permalink
    if ($permalink) {
        $permalink = generate_permalink($permalink_cfg['title'], $permalink_cfg['script'], $id, $permalink_cfg['param'], $permalink_cfg['folder'], $permalink_cfg['auto'], true);
    }

    // cache
    if (!empty($cfg['auto_recache']) || !empty($cfg['recache']) || !empty($cfg['rebuild_cache'])) {
        qcache_clear();
    }

    // hurray! done!
    if ($savenew) {
        $redir = cur_url(false)."qform_cmd=new";
    } else {
        $redir = cur_url(false)."id=$id";
    }

    if (empty($cfg['post_process'])) {
        if (!empty($cfg['send_to'])) {
            msg_die($cfg['msg']['qform_email_ok'], $redir);
        } else {
            msg_die($cfg['msg']['ok'], $redir);
        }
    } else {
        if (function_exists($cfg['post_process'])) {
            call_user_func($cfg['post_process'], $cfg['cmd'], $id, $savenew, $old_values, $new_values, $isAjax);
        } else {
            redir($cfg['post_process']."&qform_cmd=$cfg[cmd]&qform_id=$id&qform_savenew=$savenew&isAjax=$isAjax");
        }
    }
}


###############
###
### Search form
###
###############


function qform_search($def, $cfg)
{
    global $config, $tpl_section, $tpl_block;

    // init
    $tmp = '';
    $row = array();
    $file = false;
    $keyword = get_param('keyword');
    $search_by = get_param('search_by');
    $start = date_param('start_date');
    $end = date_param('end_date');
    $andor = get_param('andor');

    $filter_by = get_param('filter_by');

    // andor data def
    $andor_def['or'] = 'or';
    $andor_def['and'] = 'and';

    if (empty($cfg['action'])) {
        $t = parse_url(urldecode(cur_url()));
        $cfg['action'] = basename($t['path']);
    }

    if (strpos($cfg['action'], '?')) {
        $cfg['action'] .= '&amp;';
    } else {
        $cfg['action'] .= '?';
    }

    // add some hidden values
    $cfg['hidden_value'] = '';
    $foo = url_query_to_array($cfg['action']);
    foreach ($foo as $hkey => $hval) {
        $cfg['hidden_value'] .= "<input type=\"hidden\" name=\"$hkey\" value=\"$hval\" />\n";
    }

    // template
    load_section($cfg['tpl_file']);

    // search by
    $j = explode(',', $cfg['search_key']);
    $k = explode(',', $cfg['search_key_mask']);
    $t = array_pair($j, $k);
    $cfg['search_by'] = create_select_form('search_by', $t, $search_by);

    // filter by
    if (!empty($cfg['search_filterby'])) {
        $film = explode(',', $cfg['search_filtermask']);
        array_unshift($film, 'None');
        $val['filter_by'] = create_select_form('filter_by', $film, $filter_by);
        $cfg['filter_form'] = quick_tpl($tpl_section['qform_search_filter'], $val);
    } else {
        $cfg['filter_form'] = '';
    }

    // date
    if (!empty($cfg['search_start_date']) && !empty($cfg['search_end_date'])) {
        $start = date_param('start_date', 'get');
        if (empty($start)) {
            $start = 'today';
        }
        $val['start_date'] = date_form('start_date', $start);

        $end = date_param('end_date', 'get');
        if (empty($end)) {
            $end = 'today';
        }
        $val['end_date'] = date_form('end_date', $end);
        $val['andor'] = create_select_form('andor', $andor_def, $andor);

        $cfg['date_form'] = quick_tpl($tpl_section['qform_search_date_2'], $val);
    } elseif (!empty($cfg['search_start_date']) && empty($cfg['search_end_date'])) {
        $start = date_param('start_date', 'get');
        if (empty($start)) {
            $start = 'today';
        }
        $val['start_date'] = date_form('start_date', $start);
        $val['andor'] = create_select_form('andor', $andor_def, $andor);

        $cfg['date_form'] = quick_tpl($tpl_section['qform_search_date_1'], $val);
    } else {
        $cfg['date_form'] = '';
    }

    // other
    if ($cfg['cmd_list_enable']) {
        $cfg['switch_list'] = quick_tpl($tpl_section['qform_switch_list'], $cfg);
    } else {
        $cfg['switch_list'] = '';
    }

    // get result (if keyword !empty)
    if (!empty($keyword)) {
        $cfg['keyword'] = $keyword;
        $result = qform_search_result($def, $cfg);
    } else {
        $cfg['keyword'] = '';
        $result = quick_tpl($tpl_section['qform_search_result_none'], $cfg);
    }

    $head = quick_tpl($tpl_section['qform_search'], $cfg);
    if (!empty($cfg['header'])) {
        $head = $cfg['header'].$head;
    }
    return $head.$result;
}


###############
###
### Execute search form and display results
###
###############


function qform_search_result($def, $cfg, $list_mode = false)
{
    global $config, $lang, $tpl_section, $tpl_block, $txt;

    // init
    $keyword = get_param('keyword');
    $search_by = get_param('search_by');
    $start = date_param('start_date');
    $end = date_param('end_date');
    $andor = get_param('andor');
    $filter_by = get_param('filter_by');
    $orderby = get_param('orderby');
    $sortby = get_param('sortby');
    $p = get_param('p');
    $script = str_replace('&', '&amp;', $_SERVER['REQUEST_URI']);

    // remove + from search_by
    $d = explode('+', $search_by);
    $search_by = $d[0];

    // explode search_key to array
    $j = $jj = array();
    $i = 0;
    $a = explode(',', $cfg['search_key']);
    foreach ($a as $b => $c) {
        $d = explode('+', $c);
        if (!empty($d[1])) {
            $e = $d;
            array_shift($e);
            foreach ($e as $f => $g) {
                $jj[$i] = $g;
            }
            $j[$i] = $d[0];
        } else {
            $j[$i] = $c;
        }
        $i++;
    }
    $cfg['search_key'] = implode(',', $j);
    if (!empty($jj)) {
        $cfg['search_key'] = $cfg['search_key'].','.implode(',', $jj);
    }

    // result masking
    if (!empty($cfg['search_result_mask'])) {
        $k = explode(',', $cfg['search_result_mask']);
        $result_mask = array_pair($j, $k);
    }

    // result url masking
    if (!empty($cfg['search_result_url'])) {
        $k = explode(',', $cfg['search_result_url']);
        $result_url = array_pair($j, $k);
    }

    // Prepare layout
    if (empty($cfg['action'])) {
        $t = parse_url(urldecode(cur_url()));
        $cfg['action'] = basename($t['path']);
    }

    // create title
    $cfg['block_title'] = $cfg['block_result'] = '';
    $k = explode(',', $cfg['search_key_mask']);
    $cfg['colspan'] = count($k) + 1;
    $foo = 0;

    $sort_def = array_pair($j, $j);
    $sort = sortby_icon($sort_def);

    foreach ($k as $val) {
        $fiel = $j[$foo];
        $t['align'] = 'left';
        $t['title'] = $val;
        $t['sortby'] = $sort['sortby_'.$fiel];

        // cell title formatting
        if (!empty($def[$fiel]['format'])) {
            $format = $def[$fiel]['format'];
        } else {
            $format = 'default';
        }
        if (substr($format, 0, 7) == 'numeric') {
            $t['align'] = 'right';
        } elseif ($format == 'currency') {
            $t['align'] = 'right';
        }
        $cfg['block_title'] .= quick_tpl($tpl_section['qform_search_title_row'], $t);
        $foo++;
    }

    // 'edit' label
    if ($cfg['cmd_update_enable']) {
        $cfg['block_title'] .= quick_tpl($tpl_section['qform_search_edit_title'], $t);
    }

    // build search query
    $cfg['keyword'] = $keyword;
    $sql_where = '';
    $key = strtok($keyword, " ");
    while ($key) {
        $sql_where .= "$search_by LIKE '%".$key."%' AND ";
        $key = strtok(" ");
    }
    $sql_where = '('.substr($sql_where, 0, -5).')';

    // date param
    if ($andor == 'and') {
        $andor = 'AND';
    } else {
        $andor = 'OR';
    }
    if (!empty($start) && empty($end)) {
        $sql_where .= " $andor ($cfg[search_date_field] >= '$start')";
    }
    if (!empty($start) && !empty($end)) {
        $sql_where .= " $andor ($cfg[search_date_field] >= '$start' AND $cfg[search_date_field] <= '$end')";
    }

    // apply filter
    $filq = '';
    if ($filter_by) {
        $filb = explode(',', $cfg['search_filterby']);
        array_unshift($filb, 'Dummy');
        $filq = str_replace('|', ',', $filb[$filter_by]);
        $sql_where = "($sql_where) AND ($filq)";
    }

    // hidden filter
    if (!empty($cfg['search_hidden_filter'])) {
        $sql_where .= empty($sql_where) ? "($cfg[search_hidden_filter])" : " AND ($cfg[search_hidden_filter]) ";
        $filq .= empty($filq) ? "($cfg[search_hidden_filter])" : " AND ($cfg[search_hidden_filter]) ";
    }

    // search!
    if ($orderby == 'd') {
        $orderby = 'DESC';
    } else {
        $orderby = 'ASC';
    }
    if (empty($sortby)) {
        $sss = '';
    } else {
        $sss = "$sortby $orderby";
    }				// sql sort method

    // if list_mode, simply replace sql_where with filq (filter)
    if ($list_mode) {
        $result = sql_multipage($cfg['table'], $cfg['search_key'], $filq, $sss, $p);
    } else {
        $result = sql_multipage($cfg['table'], $cfg['search_key'], $sql_where, $sss, $p);
    }

    // create result
    foreach ($result as $val) {
        $tmp = '';

        foreach ($val as $key => $value) {
            if (in_array($key, $j) && !empty($key)) {
                // get field type
                foreach ($def as $t) {
                    if ($t['field'] == $key) {
                        $type = $t['type'];
                        if (!empty($t['format'])) {
                            $format = $t['format'];
                        } else {
                            $format = 'default';
                        }
                    }
                }

                // filter output
                $t['align'] = 'left';
                $t['result'] = $value;

                if (empty($type)) {
                    $type = '';
                }
                if ($type == 'date') {
                    $format = 'date';
                }
                if (($type == 'wysiwyg') || ($type == 'text') || ($type == 'code')) {
                    $t['result'] = line_wrap(strip_tags($t['result']), 200);
                }
                if (($type == 'image') || ($type == 'img') || ($type == 'image_resize') || ($type == 'img_resize')) {
                    if (!empty($t['result'])) {
                        $t['result'] = '<img src="'.$cfg['img_folder'].'/'.$t['result'].'" alt="'.$t['result'].'" width="150" />';
                    }
                }
                if (($type == 'thumb')) {
                    if (!empty($t['result'])) {
                        $t['result'] = '<img src="'.$cfg['thumb_folder'].'/'.$t['result'].'" alt="'.$t['result'].'" width="150" />';
                    }
                }
                // cell content formatting
                if (substr($format, 0, 7) == 'numeric') {
                    $digit = substr($format, 8);
                    $t['result'] = num_format($t['result'], $digit);
                    $t['align'] = 'right';
                }
                if ($format == 'date') {
                    $t['result'] = convert_date($t['result']);
                }
                if ($format == 'currency') {
                    $t['result'] = num_format($t['result'], 0, 1);
                    $t['align'] = 'right';
                }


                // apply mask
                if (!empty($result_mask[$key])) {
                    $qw = $result_mask[$key];
                    global $$qw;
                    if (isset(${$qw}[$t['result']])) {
                        $t['result'] = ${$qw}[$t['result']];
                    } else {
                        $t['result'] = '';
                    }
                }

                // apply url mask
                if (!empty($result_url[$key])) {
                    $t['result'] = sprintf($lang['l_open_url'], str_replace('__KEY__', $t['result'], $result_url[$key]), $t['result']);
                }

                // output
                if (substr($t['result'], 0, 6) == 'guest*') {
                    $t['result'] = '(Guest)';
                }

                // see if current result row has sub_result
                $j_idx = array_search($key, $j);
                if (!empty($jj[$j_idx])) {
                    $t['result'] = '<b>'.$t['result'].'</b><br />'.$val[$jj[$j_idx]];
                }

                $tmp .= quick_tpl($tpl_section['qform_search_result_row'], $t);
            }
        }

        $t['primary_val'] = $val[$cfg['primary_key']];
        $t['action'] = $cfg['action'];
        $t['edit_target'] = '_self';

        if ($cfg['cmd_update_enable']) {
            if (empty($cfg['search_edit'])) {
                $t['edit_url'] = "$cfg[action]id=$t[primary_val]";
            } else {
                $t['edit_url'] = str_replace('__KEY__', $t['primary_val'], $cfg['search_edit']);
                if (!empty($cfg['search_edit_target'])) {
                    $t['edit_target'] = $cfg['search_edit_target'];
                }
            }
            $tmp .= quick_tpl($tpl_section['qform_search_edit_result'], $t);
        }
        $cfg['block_result'] .= '<tr>'.$tmp.'</tr>';
    }

    // pagination
    $cfg['pagination'] = $txt['pagination'];

    // new item
    $cfg['new_item_form'] = '';
    $cfg['add_button_label'] = empty($cfg['add_button_label']) ? 'Add New Entry' : $cfg['add_button_label'];

    if (!empty($cfg['cmd_new_enable'])) {
        $cfg['new_item_form'] = quick_tpl($tpl_section['qform_new_item'], $cfg);
    }

    $result = quick_tpl($tpl_section['qform_search_result'], $cfg);

    // additional header & footer
    if (!empty($cfg['footer'])) {
        $result = $result.$cfg['footer'];
    }

    return $result;
}


###############
###
### Display (list) all item in a table
###
###############


// instead of creating a whole new list function, we simply hack into search_result.
function qform_list($def, $cfg)
{
    global $config, $tpl_section, $lang;

    $filter_by = get_param('filter_by');

    // action
    if (empty($cfg['action'])) {
        $t = parse_url(urldecode(cur_url()));
        $cfg['action'] = basename($t['path']);
    }

    if (strpos($cfg['action'], '?')) {
        $cfg['action'] .= '&';
    } else {
        $cfg['action'] .= '?';
    }

    // add some hidden values
    $cfg['hidden_value'] = '';
    $foo = url_query_to_array($cfg['action']);
    foreach ($foo as $hkey => $hval) {
        $cfg['hidden_value'] .= "<input type=\"hidden\" name=\"$hkey\" value=\"$hval\" />\n";
    }

    // template
    load_section($cfg['tpl_file']);

    // filter by
    if (!empty($cfg['search_filterby'])) {
        $film = explode(',', $cfg['search_filtermask']);
        array_unshift($film, 'None');
        $val['filter_by'] = create_select_form('filter_by', $film, $filter_by, '', false, 'onchange=this.form.submit()');
        $cfg['filter_form'] = quick_tpl($tpl_section['qform_search_filter'], $val);
    } else {
        $cfg['filter_form'] = '';
    }

    // date (if seach_by_date is defined, then show date)
    if (!empty($cfg['search_date_field'])) {
        $cfg['search_key'] .= ','.$cfg['search_date_field'];
        $cfg['search_key_mask'] .= ','.$lang['l_date'];
    }

    // other
    if ($cfg['cmd_search_enable']) {
        $cfg['switch_search'] = quick_tpl($tpl_section['qform_switch_search'], $cfg);
    } else {
        $cfg['switch_search'] = '';
    }

    $head = quick_tpl($tpl_section['qform_list'], $cfg);
    $result = qform_search_result($def, $cfg, true);

    if (!empty($cfg['header'])) {
        $head = $cfg['header'].$head;
    }

    return $head.$result;
}


###############
###
### Remove an uploaded file from an item, and update as necessary.
###
###############


// remove uploaded files
function qform_remove_file($def, $cfg)
{
    global $config;
    if ($config['demo_mode']) {
        msg_die($cfg['msg']['ok']);
    }

    $field = get_param('field');
    $primary_val = get_param('primary_val');
    $idx = get_param('idx');

    // get field type
    foreach ($def as $t) {
        if ($t['field'] == $field) {
            $type = $t['type'];
            $prefix = (!empty($t['prefix'])) ? $t['prefix'] : '';
        }
    }

    // get filename
    $res = sql_query("SELECT $field FROM $cfg[table] WHERE $cfg[primary_key] = '$primary_val' LIMIT 1");
    $row = sql_fetch_array($res);

    if (!empty($row[$field]) || ($type == 'img_series') || ($type == 'img_set')) {
        $fn = $row[$field];

        // remove file
        $fn = $row[$field];
        if ($type == 'file') {
            @unlink($cfg['file_folder'].'/'.$fn);
        }
        if (($type == 'img') || ($type == 'image') || ($type == 'img_resize') || ($type == 'image_resize')) {
            @unlink($cfg['img_folder'].'/'.$fn);
        }
        if ($type == 'thumb') {
            @unlink($cfg['img_folder'].'/'.$fn);
            @unlink($cfg['thumb_folder'].'/'.$fn);
        }
        if (($type == 'img_series') || ($type == 'img_set')) {
            $x = get_param('idx');
            $ok = false;
            $i = $x;
            $fn = $prefix.'_'.$primary_val.'_'.$i;
            unlink("$cfg[img_folder]/$fn.jpg");
            unlink("$cfg[thumb_folder]/$fn.jpg");

            while (!$ok) {
                $i++;
                $fn_old = $prefix.'_'.$primary_val.'_'.$i;
                $fn_new = $prefix.'_'.$primary_val.'_'.($i - 1);

                if (file_exists("$cfg[img_folder]/$fn_old.jpg")) {
                    rename("$cfg[img_folder]/$fn_old.jpg", "$cfg[img_folder]/$fn_new.jpg");
                    rename("$cfg[thumb_folder]/$fn_old.jpg", "$cfg[thumb_folder]/$fn_new.jpg");
                } else {
                    $ok = true;
                }
            }
        }

        // update db
        $old = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$primary_val' LIMIT 1");
        sql_query("UPDATE $cfg[table] SET $field='' WHERE $cfg[primary_key] = '$primary_val' LIMIT 1");
        if (!empty($cfg['enable_log'])) {
            // create log - get new values
            $new = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$primary_val' LIMIT 1");
            if ($old != $new) {
                if (empty($cfg['detailed_log'])) {
                    $foo = $old[$cfg['log_title']];
                    $old = $new = '';
                    $old[$cfg['log_title']] = $foo;
                }
                qform_log($primary_val, $old[$cfg['log_title']], LOG_DEL_FILE, $old, $new, $cfg['table']);
            }
        }
    }

    msg_die($cfg['msg']['ok']);
}


###############
###
### Remove an item, along with its uploaded files
###
###############


// remove item from db
function qform_remove_item($def, $cfg)
{
    global $config, $db_prefix;

    // do
    $primary_val = get_param('primary_val');
    $idx = get_param('idx');

    // remove_item can also remove multiple items, simple use: $_GET['primary_val'] = '1,2,3,4,5,6...';
    $pv_arr = explode(',', $primary_val);
    if (empty($pv_arr)) {
        $pv_arr = array($primary_val);
    }

    // get data
    foreach ($pv_arr as $primary_val) {
        $res = sql_query("SELECT * FROM $cfg[table] WHERE $cfg[primary_key] = '$primary_val' LIMIT 1");
        $old_values = $row = sql_fetch_array($res);

        // remove files
        foreach ($def as $key=>$val) {
            @$fn = $row[$val['field']];
            if ($val['type'] == 'file') {
                @unlink($cfg['file_folder'].'/'.$fn);
            }
            if (($val['type'] == 'img') || ($val['type'] == 'image') || ($val['type'] == 'img_resize') || ($val['type'] == 'image_resize')) {
                @unlink($cfg['img_folder'].'/'.$fn);
            }
            if ($val['type'] == 'thumb') {
                @unlink($cfg['img_folder'].'/'.$fn);
                @unlink($cfg['thumb_folder'].'/'.$fn);
            }
            if (($val['type'] == 'img_series') || ($val['type'] == 'img_set')) {
                $ok = false;
                $i = 0;
                while (!$ok) {
                    $i++;
                    $fn = $val['prefix'].'_'.$primary_val.'_'.$i;
                    if (!file_exists("$cfg[img_folder]/$fn.jpg")) {
                        $ok = true;
                    } else {
                        unlink("$cfg[img_folder]/$fn.jpg");
                        unlink("$cfg[thumb_folder]/$fn.jpg");
                    }
                }
            }
        }

        // remove from table...
        $old = sql_qquery("SELECT * FROM $cfg[table] WHERE $cfg[primary_key]='$primary_val' LIMIT 1");

        if (!empty($cfg['enable_log'])) {
            $log_info = sql_qquery("SELECT $cfg[log_title] FROM $cfg[table] WHERE $cfg[primary_key] = '$primary_val' LIMIT 1");
        }
        sql_query("DELETE FROM $cfg[table] WHERE $cfg[primary_key] = '$primary_val' LIMIT 1");
        if (!empty($cfg['enable_log'])) {
            $new = array();
            qform_log($primary_val, $log_info[0], LOG_DEL, $old, $new, $cfg['table']);
        }

        // remove permalink
        if (!empty($cfg['permalink_script'])) {
            sql_query("DELETE FROM ".$db_prefix."permalink WHERE target_script='$cfg[permalink_script]' AND target_idx='$primary_val' LIMIT 1");
        }
    }

    // cache
    if (!empty($cfg['auto_recache']) || !empty($cfg['recache']) || !empty($cfg['rebuild_cache'])) {
        qcache_clear();
    }

    // hurray! done!
    $strip = array('qform_cmd', 'id', 'primary_val');
    $url = str_replace('&amp;', '&', urldecode(clean_get_query($strip)));

    if (empty($cfg['post_process'])) {
        msg_die($cfg['msg']['ok'], $url);
    } else {
        if (function_exists($cfg['post_process'])) {
            call_user_func($cfg['post_process'], $cfg['cmd'], $primary_val, false, $old_values, $old_values, false);
        } else {
            redir($cfg['post_process']."&qform_cmd=$cfg[cmd]&qform_id=$primary_val");
        }
    }
}


###############
###
### Frontend, control central, HQ, base, whatever (something like that) to give command to qform.
###
###############


// manage commands
// $tpl_mode = full or popup
function qform_manage($def, $cfg, $title = array())
{
    global $config, $txt;

    $cmd = get_param('qform_cmd');
    $id = get_param('id');

    //  get cmd from POST
    if (empty($cmd)) {
        $cmd = post_param('qform_cmd');
    }
    if (empty($id)) {
        $id = post_param('primary_val');
    }

    // manage cmd
    if (empty($cmd)) {
        $cmd = $cfg['cmd_default'];
    }
    if (!empty($id)) {
        $cmd = 'update';
    }
    if (post_param('qform_process')) {
        $cmd = 'process';
    }		// id not required for NEW cmd

    // logging
    if (!isset($cfg['enable_log'])) {
        $cfg['enable_log'] = $config['enable_qform_log'];
    }
    if (!isset($cfg['detailed_log'])) {
        $cfg['detailed_log'] = $config['enable_detailed_log'];
    }
    if (empty($cfg['log_title'])) {
        $cfg['enable_log'] = $cfg['detailed_log'] = '';
    }

    // default vars
    if (!isset($cfg['pre_process'])) {
        $cfg['pre_process'] = '';
    }
    if (!isset($cfg['auto_save_changes'])) {
        $cfg['auto_save_changes'] = true;
    }
    if (!isset($cfg['update_ignore_value'])) {
        $cfg['update_ignore_value'] = false;
    }
    if (!isset($cfg['cmd_save_enable'])) {
        $cfg['cmd_save_enable'] = true;
    }

    switch ($cmd) {
        case 'search':
            if (function_exists($cfg['pre_process'])) {
                call_user_func($cfg['pre_process'], 'search', false);
            }
            $cfg['title'] = empty($title['search']) ? 'Search' : $title['search'];
            if ($cfg['cmd_search_enable']) {
                return qform_search($def, $cfg);
            } else {
                just_die('Search disabled!');
            }
        break;


        case 'list':
            if (function_exists($cfg['pre_process'])) {
                call_user_func($cfg['pre_process'], 'list', false);
            }
            $cfg['title'] = empty($title['list']) ? 'List' : $title['list'];
            if ($cfg['cmd_list_enable']) {
                return qform_list($def, $cfg);
            } else {
                just_die('List disabled!');
            }
        break;


        case 'new':
            if (function_exists($cfg['pre_process'])) {
                call_user_func($cfg['pre_process'], 'new', false);
            }
            $cfg['title'] = empty($title['new']) ? 'New Item' : $title['new'];
            if ($cfg['cmd_new_enable']) {
                $cfg['cmd'] = 'new';					// cmd: new, update, search
                $output = qform_compile($def, $cfg);
                return $output;
            } else {
                just_die('New item not allowed.');
            }
        break;


        case 'update':
            $cfg['title'] = empty($title['update']) ? 'Update Item' : $title['update'];
            if ($cfg['cmd_update_enable']) {
                $cfg['cmd'] = 'update';
                $cfg['primary_val'] = get_param('id');
                if (function_exists($cfg['pre_process'])) {
                    call_user_func($cfg['pre_process'], 'update', $id);
                }
                $output = qform_compile($def, $cfg);
                return $output;
            } else {
                just_die('Item update not allowed.');
            }
        break;


        case 'process':
            $id = post_param('primary_val');
            if (!$cfg['cmd_new_enable'] && !$id) {
                just_die('New not allowed');
            }
            if (!$cfg['cmd_update_enable'] && $id) {
                just_die('Edit not allowed');
            }
            if (!$cfg['cmd_save_enable'] && $id) {
                just_die('Save not allowed');
            }
            if (function_exists($cfg['pre_process'])) {
                call_user_func($cfg['pre_process'], $id ? 'update' : 'new', $id);
            }
            $output = qform_process($def, $cfg);
            if (!$cfg['auto_save_changes']) {
                return $output;
            }
        break;


        case 'remove_item':
            if ($cfg['cmd_remove_enable']) {
                $cfg['cmd'] = 'remove_item';
                $id = get_param('primary_val');
                if (function_exists($cfg['pre_process'])) {
                    call_user_func($cfg['pre_process'], 'remove_item', $id);
                }
                if (!$cfg['auto_save_changes']) {
                    return array('qqq');
                }
                qform_remove_item($def, $cfg);
            } else {
                just_die('Item removal not allowed.');
            }
        break;


        case 'remove_file':
            $id = get_param('primary_val');
            $cfg['cmd'] = 'remove_file';
            if (function_exists($cfg['pre_process'])) {
                call_user_func($cfg['pre_process'], 'remove_file', $id);
            }
            qform_remove_file($def, $cfg);
        break;


        default:
            just_die('Unknown command type of <b>'.$cmd.'</b>!');
        break;
    }
}


// to build data definition for qform ($qform_def)
// $table => table name to build
// $simple => create simple array (eg: array (x => y)) instead of complex array (eg: array[x][y])
// $utf8 => divide column length by 3
// $val => 'sql' = use 'sql' string (aka SQL stored value). 'val' = use $val['field_name']
function qform_build($table, $simple = false, $utf8 = true, $val = 'sql')
{
    global $dbh;
    $res = sql_query("SELECT * FROM $table");
    $fields = mysqli_num_fields($res);
    $rows = mysqli_num_rows($res);
    $i = 0;
    echo "Your '".$table."' table has ".$fields." fields and ".$rows." records <br />";
    echo "Copy & paste the following to create qform_def: <br /><hr />";

    $mysql_data_type_hash = array(1=>'tinyint',2=>'smallint',3=>'int',4=>'float',5=>'double',7=>'timestamp',8=>'bigint',9=>'mediumint',10=>'date',
    11=>'time',12=>'datetime',13=>'year',16=>'bit',252=>'text',253=>'varchar',254=>'char',246=>'decimal');
    while ($i < $fields) {
        $tbl = mysqli_fetch_field_direct($res, $i);
        $type  = $mysql_data_type_hash[$tbl->type];
        $name  = $tbl->name;
        $len   = $tbl->length;
        $flags = $tbl->flags;
        $ftitle = ucwords(strtolower(str_replace('_', ' ', $name)));
        $ffield = $name;
        $fsize = 0;

        if (($type == 'blob') || ($type == 'text')) {
            $ftype = 'text';
            $fsize = '500,200';
        } elseif ($type == 'date') {
            $ftype = 'date';
        } elseif ($type == 'time') {
            $ftype = 'time';
        } else {
            $ftype = 'varchar';
            if ($utf8) {
                $len = $len / 3;
            }
            $fsize = $len;
        }

        if ($val == 'val') {
            $var = "\$val['$ffield']";
        } else {
            $var = "'sql'";
        }

        echo "<p>// $name :: $type :: $len<br />";

        if ($simple) {
            echo "\$qform_def['$name'] = array ('title' => '$ftitle',<br />\n"
                ."'field' => '$ffield',<br />\n"
                ."'type' => '$ftype',<br />\n";
            if ($fsize) {
                echo "'size' => '$fsize',<br />\n";
            }
            echo "'value' => $var);\n"
                ."</p>";
        } else {
            echo "\$qform_def['$name']['title'] = '$ftitle';<br />\n"
                ."\$qform_def['$name']['field'] = '$ffield';<br />\n"
                ."\$qform_def['$name']['type'] = '$ftype';<br />\n";
            if ($fsize) {
                echo "\$qform_def['$name']['size'] = '$fsize';<br />\n";
            }
            echo "\$qform_def['$name']['value'] = 'sql';\n"
                ."</p>";
        }
        $i++;
    }
    echo '<hr />';
}
