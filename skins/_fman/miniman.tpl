<script>
    function DoTool(filename) {
        c = window.confirm("Do you wish to select '" + filename + "'?");
        if (!c) return false;
        document.location = "{$script}?fn=" + filename;
    }
</script>

<h1><img src="./../../skins/_fman/images/fman.png" style="width:64px" border="0" alt="fman" /> MiniMan</h1>
<div class="card">
    <div class="card-header">
        {$abs_dir}
    </div>
    <table class="table table-condensed">
        <tr>
            <td width="45%" class="fman_list_head">Name</td>
            <td width="12%" class="fman_list_head" align="right">Size</td>
            <td width="20%" class="fman_list_head">Date Modified</td>
            <td class="fman_list_head">View</td>
        </tr>

        <!-- BEGINBLOCK fileman_item -->
        <tr>
            <td><a href="#" onclick="DoTool('{$name}')">{$name}</a></td>
            <td class="text-right">{$size}</td>
            <td><small>{$mtime}</small></td>
            <td><a href="{$path}"><img src="../../skins/_fman/images/view.gif" border="0" alt="view" /></a></td>
        </tr>
        <!-- ENDBLOCK -->

    </table>
</div>