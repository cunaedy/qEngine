<div>
	<!-- BEGINMODULE slideshow -->
	theme=theme-welcome
	cat_id=0
	<!-- ENDMODULE -->
</div>

<div id="welcome" class="container">
	<!-- BEGINMODULE page_gallery -->
	// Welcome text
	page_id = 1
	body = 1
	<!-- ENDMODULE -->

	<h3 style="padding-top:10px">{$l_site_news}</h3>
	<!-- BEGINMODULE page_gallery -->
	// Display list of 5 pages from group 2 (news), all categories
	group_id = news
	title = 1
	style = list
	orderby = page_date
	sort = desc
	<!-- ENDMODULE -->

	<ul class="list_1">
		<li><a href="{$site_url}/{$news_url}">{$l_all_news}</a></li>
	</ul>
</div>