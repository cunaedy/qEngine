{$breadcrumb}

<!-- BEGINIF $enable_inline_edit -->
<form method="post" action="{$site_url}/{$l_admin_folder}/page.php">
<input type="hidden" name="isAjax" value="1" />
<input type="hidden" name="qadmin_cmd" value="update" />
<input type="hidden" name="qadmin_process" value="1" />
<input type="hidden" name="primary_key" value="page_id" />
<input type="hidden" name="primary_val" value="{$page_id}" />
<input type="hidden" name="permalink" value="{$permalink}" />
<!-- ENDIF -->

<h1 id="page_title" class="editable">{$page_title}</h1>

<!-- BEGINIF $enable_twitter_share -->
<a href="https://twitter.com/share" class="twitter-share-button" data-lang="en" style="vertical-align:text-bottom !important;margin-top:5px !important">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
<!-- ENDIF -->

<!-- BEGINIF $enable_facebook_like -->
<div class="fb-like" data-href="{$current_url}" data-layout="button_count" data-action="like" data-show-faces="false" data-share="true" style="vertical-align:top !important"></div>
<!-- ENDIF -->
<div style="clear:both"></div>

<!-- BEGINIF $attachment -->
<div id="page_attachment">
	<div class="l1"><span class="oi oi-paperclip"></span></div>
	<div style="float:left"><a href="{$site_url}/page.php?dn={$page_id}" class="popiframe">{$page_attachment}</a> ({$page_attachment_size} KB, {$l_downloaded} {$page_attachment_stat}&times;)</div>
	<div style="clear:both"></div>
</div>
<!-- ENDIF -->

<!-- BEGINIF $main_image -->
<img src="{$site_url}/public/image/{$page_image}" alt="{$page_title}" class="pg_main_image" />
<!-- ENDIF -->

<!-- BEGINIF $main_image_thumb -->
<a href="{$site_url}/public/image/{$page_image}" class="lightbox"><img src="{$site_url}/public/thumb/{$page_image_th}" alt="{$page_title}" class="pg_main_image" /></a>
<!-- ENDIF -->

<div style="margin-top:20px"></div>
<div id="page_body" class="editable">
{$page_body}
</div>
{$pagination}
<!-- BEGINIF $enable_inline_edit -->
</form>
<!-- ENDIF -->
<hr />
<!-- BEGINIF $page_gallery -->
<h3>{$l_page_gallery}</h3>
<div>
<!-- BEGINBLOCK gallery -->
<a href="{$site_url}/public/image/{$image}" class="lightbox"><img src="{$site_url}/public/thumb/{$image}" alt="image" /></a>
<!-- ENDBLOCK -->
</div>
<div style="clear:both"></div>
<!-- ENDIF -->

<div style="margin-top:6px" id="page_info">
<!-- BEGINIF $author --><div>{$l_posted_by}: <a href="{$site_url}/page.php?author={$page_author}">{$page_author}</a></div><!-- ENDIF -->
<!-- BEGINIF $page_date --><div>{$l_posted_on}: {$page_date} @ {$page_time}</div><!-- ENDIF -->
<!-- BEGINIF $page_date --><div>{$l_last_updated}: {$update_date} @ {$update_time}</div><!-- ENDIF -->
</div>

<!-- BEGINIF $sub_page -->
<h3>{$l_related_page}</h3>
<!-- BEGINBLOCK list -->
<div style="float:left; width:50px; margin-right:10px; height:50px;">{$page_image_small}</div><div style="float:left; width:500px"><a href="{$site_url}/{$page_url}">{$page_title}</a></div>
<div style="clear:both"></div>
<!-- ENDBLOCK -->
<!-- ENDIF -->

<!-- BEGINIF $allow_comment -->
<!-- BEGINMODULE qcomment -->
mode = comment
mod_id = {$comment_mid}
item_id = {$page_id}
title = {$page_title}
<!-- ENDMODULE -->
<!-- ENDIF -->

<!-- BEGINIF $enable_page_facebook_comment -->
<h2 style="margin-top:30px">{$l_facebook_comment}</h2>
<div class="fb-comments" data-href="{$current_url}" data-width="100%"></div>
<div style="clear:both"></div>
<!-- ENDIF -->