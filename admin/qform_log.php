<?php
// part of qEngine
require './../includes/admin_init.php';
require './../includes/finediff.php';
admin_check('site_log');

$cmd = get_param('cmd');
$w = get_param('w');
$h = get_param('h');
$pid = get_param('pid');
$log_id = get_param('log_id');
$p = get_param('p', 1);

// def
$act_def = array(
    1 => '<span title="New Item"><span class="oi oi-file"></span><span class="oi oi-plus small"></span></span>',
    2 => '<span title="Edit Item"><span class="oi oi-file"></span><span class="oi oi-pencil small"></span></span>',
    3 => '<span title="Delete Item"><span class="oi oi-file"></span><span class="oi oi-remove small"></span></span>',
    4 => '<span title="File Upload"><span class="oi oi-cloud"></span><span class="oi oi-data-transfer-upload"></span></span>',
    5 => '<span title="File Removal"><span class="oi oi-cloud"></span><span class="oi oi-x small"></span></span>',
    6 => '<span title="Restore Item"><span class="oi oi-file"></span><span class="oi oi-refresh small"></span></span>'
);

$act_desc_def = array(
    1 => 'New Item',
    2 => 'Edit Item',
    3 => 'Delete Item',
    4 => 'File Upload',
    5 => 'File Removal',
    6 => 'Restore Item'
);

//
$enable_detailed_log = $config['enable_detailed_log'];

// log
switch ($cmd) {
    case 'restore':
        axsrf_check();
        $row = sql_qquery("SELECT * FROM " . $db_prefix . "qform_log WHERE log_id = '$log_id' LIMIT 1");
        if (empty($row) || empty($row['log_previous'])) {
            msg_die('Log not available!');
        }
        $old = (unserialize(gzuncompress(base64_decode($row['log_previous']))));
        if (empty($old)) {
            msg_die('Previous values not available!');
        }
        if (($row['log_action'] == 1) || ($row['log_action'] == 4) || ($row['log_action'] == 5)) {
            msg_die('Unfortunately qEngine can\'t restore changed files or item creation.');
        }

        // create sql
        $sql = array();
        foreach ($old as $k => $v) {
            if (!is_numeric($k)) {
                $sql[] = "$k='" . addslashes($v) . "'";
            }
        }

        if (!empty($sql)) {
            // get primary field
            $tbl = sql_qquery("show index from $row[log_table] where Key_name = 'PRIMARY'");
            if (!$tbl || empty($tbl['Column_name'])) {
                msg_die('This feature is not supported by this version of MySQL!');
            }

            // save current values for logging
            $current = sql_qquery("SELECT * FROM $row[log_table] WHERE $tbl[Column_name] = '$row[log_pid]' LIMIT 1");

            // special treatment for measure_value => karena log disimpan per baris & kolom, sementara measure_value disimpan 1 value = 1 row
            if ($row['log_table'] == $db_prefix . 'measure_value') {
                foreach ($old as $k => $v) {
                    if (!is_numeric($k)) {
                        $vv = addslashes($v);
                        if ($row['log_action'] == 3) {
                            sql_query("INSERT INTO " . $db_prefix . "measure_value SET field_value='$vv', field_id='$k', entry_id='$row[log_pid]', field_time=UNIX_TIMESTAMP()");
                        } else {
                            sql_query("UPDATE " . $db_prefix . "measure_value SET field_value='$vv', field_time=UNIX_TIMESTAMP() WHERE field_id='$k' AND entry_id='$row[log_pid]' LIMIT 1");
                        }
                    }
                }
            } else {
                $sql = implode(', ', $sql);

                // restore
                if ($row['log_action'] == 3) {
                    sql_query("INSERT INTO $row[log_table] SET $sql");
                } else {
                    sql_query("UPDATE $row[log_table] SET $sql WHERE $tbl[Column_name] = '$row[log_pid]' LIMIT 1");
                }
                $result = mysqli_affected_rows($dbh);

                // sub log must be executed also
                $primary_def = array();
                $ressub = sql_query("SELECT * FROM " . $db_prefix . "qform_log WHERE log_parent='$log_id'");
                while ($sub = sql_fetch_array($ressub)) {
                    $sql = array();
                    $subold = (unserialize(gzuncompress(base64_decode($sub['log_previous']))));
                    foreach ($subold as $k => $v) {
                        if (!is_numeric($k)) {
                            $sql[] = "$k='" . addslashes($v) . "'";
                        }
                    }
                    $sql = implode(', ', $sql);

                    // get primary field
                    if (empty($primary_def[$sub['log_table']])) {
                        $tbl = sql_qquery("show index from $sub[log_table] where Key_name = 'PRIMARY'");
                        $primary = $primary_def[$sub['log_table']] = $tbl['Column_name'];
                    } else {
                        $primary = $primary_def[$sub['log_table']];
                    }

                    if ($sub['log_action'] == 3) {
                        sql_query("INSERT INTO $sub[log_table] SET $sql");
                    } else {
                        sql_query("UPDATE $sub[log_table] SET $sql WHERE $primary = '$sub[log_pid]' LIMIT 1");
                    }
                    $result = mysqli_affected_rows($dbh);
                }
            }

            // restore success?
            if ($result) {
                qform_log($row['log_pid'], $row['log_title'], 6, $current, $old, $row['log_table']);
                msg_die(sprintf('This entry has been restored. Some values may need to be restored manually!'));
            } else {
                msg_die(sprintf('Restore failed! Item may have been removed, or no restore necessary.'));
            }
        }
        break;


    case 'delall':
        axsrf_check();
        sql_query("TRUNCATE TABLE " . $db_prefix . "qform_log");
        msg_die('ok');
        break;

    case 'del':
        axsrf_check();
        sql_query("DELETE FROM " . $db_prefix . "qform_log WHERE log_id = '$log_id' LIMIT 1");
        msg_die('ok');
        break;


    case 'detail':
        $tpl_mode = 'detail';
        $tpl = load_tpl('adm', 'qform_log.tpl');
        $res = sql_query("SELECT * FROM " . $db_prefix . "qform_log WHERE log_id = '$log_id' LIMIT 1");
        $row = sql_fetch_array($res);
        if (empty($row)) {
            redir($config['site_url'] . '/' . $config['admin_folder'] . '/qform_log.php');
        }
        $row['log_time'] = date('Y-m-d H:m:s', $row['log_date']);
        $row['log_action_def'] = $act_def[$row['log_action']] . ' ' . $act_desc_def[$row['log_action']];
        $row['axsrf'] = axsrf_value();
        $tbl = $row['log_table'];

        //
        if ($row['log_table'] == $db_prefix . 'measure_value') {
            // special case for measure_value log
            // - log pid
            $log_pid = $row['log_pid'];

            // - form id
            $foo = sql_qquery("SELECT form_id FROM " . $db_prefix . "measure_entry WHERE idx='$log_pid' LIMIT 1");
            if (!$foo) {
                die('Invalid LOG_PID!');
            }
            $form_id = $foo['form_id'];

            // - get list of field
            $res = sql_query("SELECT idx, field_name FROM " . $db_prefix . "measure_field WHERE form_id='$form_id'");
            while ($foo = sql_fetch_array($res)) {
                $fn = 'field_' . $form_id . '_' . $foo['idx'];
                $qform_log_field[$tbl][$fn] = $foo['field_name'];
            }
        }

        // comparison table
        $no_details = false;
        if (!empty($row['log_previous'])) {
            $old = (unserialize(gzuncompress(base64_decode($row['log_previous']))));

            if (($row['log_action'] == 1) || ($row['log_action'] == 3)) {
                $new = $old;
            } else {
                if (!empty($row['log_now'])) {
                    $new = (unserialize(gzuncompress(base64_decode($row['log_now']))));
                } else {
                    $new = array();
                }
            }

            if (!is_array($old)) {
                $old = array($old);
            }
            $keys = array_keys(array_merge($old, $new));
            $row['values'] = "<table class=\"table table-bordered\" border=\"0\" width=\"100%\">\n";

            if (($row['log_action'] == 1) || ($row['log_action'] == 3)) {
                $row['values'] .= "<tr><th width=\"20%\">Field ID</th><th width=\"40%\">Original Values</th></tr>\n";
            } else {
                $row['values'] .= "<tr><th width=\"20%\">Field ID</th><th width=\"40%\">Original Values</th><th width=\"40%\">Entered Values <span class=\"oi oi-info help tips\" title=\"Click the column to see the differences.\"></span></th></tr>\n";
            }
            foreach ($keys as $k => $v) {
                if (!is_numeric($v)) {
                    $nv = $v;
                    $o = isset($old[$v]) ? $old[$v] : '';
                    $n = isset($new[$v]) ? $new[$v] : '';
                    if ($o != $n) {
                        $op = FineDiff::getDiffOpcodes($o, $n);
                        $c = html_unentities(FineDiff::renderDiffToHTMLFromOpcodes($o, $op));
                        $row['values'] .= "<tr><th>$nv</th><td>$o</td><td class=\"qform_log_changes\" onclick=\"reveal('$v')\"><div id=\"$v-new\">$n</div><div id=\"$v-change\" style=\"display:none\">$c</div></td></tr>\n";
                    } else {
                        if (($row['log_action'] == 1) || ($row['log_action'] == 3)) {
                            $row['values'] .= "<tr><td>$nv</td><td>$o</td></tr>\n";
                        } else {
                            $row['values'] .= "<tr><td>$nv</td><td>$o</td><td>$n</td></tr>\n";
                        }
                    }
                }
            }
            $row['values'] .= "</table>\n";
        } else {
            $row['values'] = '';
        }
        $txt['main_body'] = quick_tpl($tpl, $row);
        flush_tpl('adm');
        break;


    default:
        $tpl_mode = 'list';
        $tpl = load_tpl('adm', 'qform_log.tpl');
        $txt['block_log_item'] = '';
        $sortby = get_param('sortby');
        $orderby = get_param('orderby');
        if (empty($sortby) && empty($orderby)) {
            $_GET['sortby'] = 'idx';
            $_GET['orderby'] = 'd';
        }

        $where = array();
        if ($w == 'date') {
            $s = convert_date($h, 'unix');
            $f = convert_date($h, 'unix', 1);
            $where[] = "(log_date >= '$s') AND (log_date <= '$f')";
        } elseif ($w == 'file') {
            $where[] = "log_file='$h'";
        } elseif ($w == 'user') {
            $where[] = "log_user='$h'";
        } elseif ($w == 'action') {
            $where[] = "log_action='$h'";
        } elseif ($w == 'pid') {
            $where[] = "(log_file='$h') AND (log_pid='$pid')";
        } elseif ($w == 'ip') {
            $where[] = "(log_ip='$h')";
        }

        $where[] = "log_parent='0'";
        $where = implode(' AND ', $where);

        // sort
        $sort_def = array('idx' => 'log_id', 'date' => 'log_date', 'file' => 'log_file', 'title' => 'log_title', 'action' => 'log_action', 'user' => 'log_user');
        $sort = sortby_icon($sort_def);
        $txt = array_merge($txt, $sort);

        $axsrf = axsrf_value();
        $tbl = sql_multipage($db_prefix . 'qform_log', '*', $where, $sort['sql_sort'], $p, $config['site_url'] . '/admin/qform_log.php', 20);
        foreach ($tbl as $row) {
            $row['axsrf'] = axsrf_value();
            $row['log_action_def'] = $act_def[$row['log_action']];
            $row['log_time'] = date('H:i:s', $row['log_date']);
            $row['log_date'] = date('Y-m-d', $row['log_date']);
            $row['log_title'] = $row['log_title'] ? $row['log_title'] : '<i>(untitled)</i>';
            $txt['block_log_item'] .= quick_tpl($tpl_block['log_item'], $row);
        }

        $txt['axsrf'] = axsrf_value();
        $txt['main_body'] = quick_tpl($tpl, $txt);
        flush_tpl('adm');
}
