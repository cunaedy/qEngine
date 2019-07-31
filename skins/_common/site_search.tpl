{$breadcrumb}
<h1>{$l_site_search}</h1>

<form method="get" action="{$site_url}/site_search.php" class="form-inline mb-3">
<input type="hidden" name="mod_id" value="{$mod_id}" />
<input type="text" name="query" value="{$query}" size="50" class="form-control mr-2" /> <button type="submit" class="btn btn-primary">{$l_search}</button>
</form>

<h3>{$l_contents}</h3>
 <!-- BEGINBLOCK page -->
<div style="margin-bottom:10px"><a href="{$site_url}/{$page_url}">{$title}</a><br />
 {$body}</div>
<!-- ENDBLOCK -->
{$pagination}

<!-- BEGINIF $no_result -->
<p>{$l_search_no_result}</p>
<!-- ENDIF -->