<!-- BEGINIF $module_mode == 'comment' -->
<div id="qcomment">
<!-- or use { $n} to display only number of comments -->
<h3>{$nl}</h3>
<p>{$rating_avg}</p>
<!-- BEGINBLOCK comment -->
<div class="comment_box">
	<div class="comment_box_right">
		<div class="comment_title">{$comment_title} {$rating}</div>
		<div>{$comment_body}</div>
		<div class="comment_helpful">{$comment_helpful}<br />{$conc_num}</div>
	</div>
	<div class="comment_box_left">
		<span class="glyphicon glyphicon-user"></span> {$comment_user} <span class="glyphicon glyphicon-time"></span> {$comment_date}
	</div>
	<div style="clear:both"></div>
</div>
<!-- ENDBLOCK -->

<p><a href="{$site_url}/task.php?mod=qcomment&amp;m={$mod_id}&amp;i={$item_id}&amp;t={$safetitle}&amp;u={$safeurl}">More Comments/Post Your Own</a></p>
</div>
<!-- ENDIF -->

<!-- BEGINIF $module_mode == 'rate' -->
<div>
 <form method="get" action="{$site_url}/task.php">
 <input type="hidden" name="mod" value="qcomment" />
 <input type="hidden" name="m" value="{$mod_id}" />
 <input type="hidden" name="i" value="{$item_id}" />
 <input type="hidden" name="t" value="{$item_title}" />
 Average rating  is: {$avg_star} {$avg_rate} of {$freq_rate} votes.<br />Cast your vote: {$rate_select}
 <button type="submit">Rate</button>
 </form>
 </div>
<!-- ENDIF -->

<!-- BEGINIF $module_mode == 'latest' -->
<ul class="list_2 qcomment_latest">
<!-- BEGINBLOCK list -->
<li class="comment_shorten"> {$comment_user} on <a href="{$item_url}">{$item_title}</a><br />
	 &ldquo;{$comment_title}&rdquo; - <small><i>{$comment_date}</i></small></li>
<!-- ENDBLOCK -->
</ul>
<!-- ENDIF -->

<!-- BEGINIF $module_mode == 'most' -->
<ul class="list_2 qcomment_most">
<!-- BEGINBLOCK list -->
<li class="comment_shorten"><a href="{$item_url}">{$item_title}</a> <span class="glyphicon glyphicon-comment"></span> {$total}</li>
<!-- ENDBLOCK -->
</ul>
<!-- ENDIF -->