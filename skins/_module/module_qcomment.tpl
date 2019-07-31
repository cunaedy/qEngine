{$breadcrumb}
{$helpful_js}
{$the_title}
{$comment_box}
<hr />
<p>There are {$num} comments. {$rating_avg}</p>
<hr />
<!-- BEGINIF $current_admin_level -->
<div class="alert alert-warning alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <strong>NOTICE!</strong> All newly approved &amp; newly held comments will be visible the next time you <a href="javascript:location.reload()">refresh</a> this page.
</div>
<!-- ENDIF -->

<!-- BEGINBLOCK comment_quick_approval -->
<div class="comment_box_not_approved" id="comment_{$comment_id}" style="display:block">
		<div class="bg-danger">
			<span class="oi oi-warning"></span> This comment is not yet approved.
			<a href="{$site_url}/task.php?mod=qcomment&amp;approve={$comment_id}" data-ajax-success-callback="refresh_comment" data-ajax-success-arg="{$comment_id}" class="simpleAjax btn btn-sm"><span class="oi oi-check" style="padding-left:10px" title="approve"></span></a>
			<a href="{$site_url}/{$l_admin_folder}/task.php?mod=qcomment&amp;run=edit.php&amp;id={$comment_id}" class="btn btn-sm" target="acp"><span class="oi oi-pencil" style="padding-left:10px" title="edit"></span></a>
			<a href="{$site_url}/task.php?mod=qcomment&amp;trash={$comment_id}" data-ajax-success-callback="hide_comment" data-ajax-success-arg="{$comment_id}" class="simpleAjax btn btn-sm"><span class="oi oi-trash" style="padding-left:10px" title="remove"></span></a>
		</div>
	<div class="comment_box_right">
		<div class="comment_title">{$comment_title} {$rating}</div>
		<div>{$comment_body}</div>
	</div>
	<div class="comment_box_left">
		<!-- BEGINIF $detail -->
		<span class="oi oi-person"></span> {$comment_user} <span class="oi oi-clock"></span> {$comment_date}
		<!-- ENDIF -->
	</div>
</div>
<!-- ENDBLOCK -->

<!-- BEGINBLOCK comment -->
<div class="comment_box" id="comment_{$comment_id}">
	<div class="comment_box_right">
		<!-- BEGINIF $current_admin_level -->
		<div class="bg-warning">
			<a href="{$site_url}/task.php?mod=qcomment&amp;m=pagecomment&amp;hold={$comment_id}" data-ajax-success-callback="hide_comment" data-ajax-success-arg="{$comment_id}" class="simpleAjax btn btn-sm"><span class="oi oi-x" style="padding-left:10px" title="hold"></span></a>
			<a href="{$site_url}/{$l_admin_folder}/task.php?mod=qcomment&amp;run=edit.php&amp;id={$comment_id}" class="btn btn-sm" target="acp"><span class="oi oi-pencil" style="padding-left:10px" title="edit"></span></a>
			<a href="{$site_url}/task.php?mod=qcomment&amp;m=pagecomment&amp;trash={$comment_id}" data-ajax-success-callback="hide_comment" data-ajax-success-arg="{$comment_id}" class="simpleAjax btn btn-sm"><span class="oi oi-trash" style="padding-left:10px" title="remove"></span></a>
		</div>
		<!-- ENDIF -->
		<div class="comment_title">{$comment_title} {$rating}</div>
		<div>{$comment_body}</div>
	</div>
	<div class="comment_box_left">
		<!-- BEGINIF $detail -->
		<span class="oi oi-person"></span> {$comment_user} <span class="oi oi-clock"></span> {$comment_date}
		<!-- ENDIF -->
		<!-- BEGINIF $conc -->
		<a href="#qcomment_form" onclick="init_comment_box('conc','{$conc_id}','{$conc_title_encrypted}','re:{$conc_title}')" class="btn btn-sm"><span class="oi oi-comment-square" style="padding-left:10px" title="reply"></span></a>
		<!-- ENDIF -->
	</div>
	<div style="clear:both">
		<!-- BEGINIF $helpful -->
		<div style="float:left; padding-top:7px">{$comment_helpful}</div>
		<!-- ENDIF -->
		<!-- BEGINIF $helpful_js -->
		<div style="float:right">Did you find this comment helpful?
			<button type="button" name="yes" value="1" class="image" onclick="sendIt('{$comment_id}', 'yes')"><span class="oi oi-thumb-up"></span></button>
			<button type="button" name="no" value="1" class="image" onclick="sendIt('{$comment_id}', 'no')"><span class="oi oi-thumb-down"></span></button>
		</div>
		<!-- ENDIF -->
		<div style="clear:both"></div>
	</div>

	<!-- BEGINIF $conc -->
	<div style="height:15px"></div>
	 {$conc_msg}
	<!-- ENDIF -->
</div>
<!-- ENDBLOCK -->

<script>
	function hide_comment (n)
	{
		$('#comment_'+n).hide (400)
	}

	function refresh_comment (n)
	{
		$('#comment_'+n).hide (400)
	}
</script>