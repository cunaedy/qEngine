{$breadcrumb}
<!-- BEGINIF $tpl_mode == 'cat' -->
<div class="card">
	<div class="card-header"><h1 style="margin:0">{$cat_name}</h1></div>
	<div class="card-body">
		<div style="margin:0 10px 0 0; float:left;"><img src="{$site_url}/{$cat_image}" alt="{$cat_name}" /></div>
		<div>{$cat_details}</div>
		<div style="clear:both"></div>
	</div>
<!-- ELSE -->
<div class="card">
	<div class="card-header"><h1 style="margin:0">{$l_article_by} {$page_author}</h1></div>
<!-- ENDIF -->

<!-- BEGINIF $all_cat_list -->
<div class="table-responsive">
	<table class="table" width="100%">
	<tr>
		<th colspan="2">{$l_other_cat}</th>
	</tr>
	<tr>
		<td colspan="2">
	<!-- BEGINBLOCK cat_list -->
			<a href="{$site_url}/{$cat_url}" style="padding-right:20px"><img src="{$cat_image}" alt="{$cat_name}" width="30" /> <b>{$cat_name}</b></a>
	<!-- ENDBLOCK -->
		</ul></td>
	</tr>
	<tr>
		<th colspan="2">{$l_contents}</th>
	</tr>
	</table>
</div>
<!-- ENDIF -->

	<div class="table-responsive">
	<table class="table">
	<tr>
		<th width="15%"></th>
		<th width="70%">{$l_title} {$sortby_t}</th>
		<th class="text-right" width="15%">{$l_date} {$sortby_d}</th>
	</tr>
	<!-- BEGINBLOCK list -->
	<tr>
		<td class="text-center"><a href="{$site_url}/{$page_url}"><img src="{$page_image_thumb}" width="50" alt="{$page_title}" /></a></td>
		<td><a href="{$site_url}/{$page_url}">{$page_title}</a> {$page_pinned} {$page_attachment} {$page_locked}<div class="small"><span class="oi oi-person"></span> <a href="{$site_url}/page.php?author={$page_author}">{$page_author}</a></div></td>
		<td class="text-right">{$page_date}</td>

	</tr>
	<!-- ENDBLOCK -->
	</table>
	</div>

</div>
{$pagination}

<form method="get" action="{$site_url}/page.php" id="sortby">
	<input type="hidden" name="cmd" value="list" />
	<input type="hidden" name="cid" value="{$cid}" />
	<input type="hidden" name="author" value="{$page_author}" />
	<input type="hidden" name="sort" value="t" id="sortby_value" />
</form>


<script>
function sortby (w)
{
	$('#sortby_value').val(w);
	$('#sortby').submit();
}
</script>