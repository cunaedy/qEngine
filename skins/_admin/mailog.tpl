<script>
    function confirm_delete() {
        c = window.confirm("Do you wish to clear all logs?\nThis process can not be undone!");
        if (!c) return false;
        document.location = "mailog.php?mode=delall&AXSRF_token={$axsrf}";
    }
</script>

<div class="card">
    <div class="card-header">Email Log</div>
<!-- BEGINIF $tpl_mode == 'list' -->
    <table class="table table-bordered">
        <tr>
            <th width="5%">ID</th>
            <th width="20%">Sent</th>
            <th width="25%">Recipient</th>
            <th width="30%">Subject</th>
            <th width="5%">Remove</th>
        </tr>

        <!-- BEGINBLOCK log_item -->
        <tr>
            <td><a href="mailog.php?mode=detail&amp;log_id={$log_id}">{$log_id}</a></td>
            <td>{$log_time}</td>
            <td>{$log_address}</td>
            <td><a href="mailog.php?mode=detail&amp;log_id={$log_id}">{$log_subject}</a></td>
            <td class="text-center"><a href="mailog.php?mode=del&amp;log_id={$log_id}&amp;AXSRF_token={$axsrf}"><span class="oi oi-x"></span></a></td>
        </tr>
        <!-- ENDBLOCK -->

    </table>
    <div class="card-footer">
        {$pagination}
        <form method="get" action="mailog.php" style="margin-top:5px" class="form">
            <input type="hidden" name="mode" value="search" />
            <div class="form-row">
                <div class="col-auto">
                    <label>Search for:</label>
                </div>
                <div class="col-auto">
                    <input type="text" name="keyword" size="20" value="{$keyword}" class="form-control" />
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <a href="#page" onclick="confirm_delete()" class="btn btn-danger alert-link"><span class="oi oi-x"></span> Remove all logs</a>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- ENDIF -->

<!-- BEGINIF $tpl_mode == 'detail' -->
<table class="table table-bordered" id="result">
    <tr>
        <th colspan="2"><a href="mailog.php"><span class="oi oi-chevron-left"></span> Back</a></th>
    </tr>
    <tr>
        <td>Log ID/Sent Date</td>
        <td>{$log_id} / {$log_time}</td>
    </tr>
    <tr>
        <td>Recipient</td>
        <td>{$log_address}</td>
    </tr>
    <tr>
        <td>Subject</td>
        <td>{$log_subject}</td>
    </tr>
    <tr>
        <td valign="top">Message</td>
        <td>{$log_body}</td>
    </tr>
    <tr>
        <td>Remove</td>
        <td><a href="mailog.php?mode=del&amp;log_id={$log_id}&AXSRF_token={$axsrf}"><span class="oi oi-x"></span> Click Here to Remove this Log</a></td>
    </tr>
</table>
</div>
<!-- ENDIF -->