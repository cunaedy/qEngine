<div class="container">
	{$module_box_T1}

	<div class="row">
		<div id="body_left" class="col-sm-12 col-md-8">
			{$module_box_T2}
			{$main_body}
		</div>
		<div id="body_right" class="col-sm-12 col-md-4">
			<div class="body_right_content">
			<h3>{$l_site_news}</h3>
			<!-- BEGINMODULE page_gallery -->
			group_id = NEWS
			title = 1
			summary = 1
			style = list
			orderby = page_id
			sort = desc
			<!-- ENDMODULE -->
			</div>

			<h3>Latest Comments</h3>
			<!-- BEGINMODULE qcomment -->
			mode = latest
			mod_id = pagecomment
			items = 5
			<!-- ENDMODULE -->

			<h3>Most Commented</h3>
			<!-- BEGINMODULE qcomment -->
			mode = most
			mod_id = pagecomment
			items = 10
			<!-- ENDMODULE -->


			<div class="body_right_content">
			{$module_box_L1}
			</div>

			<div class="body_right_content">
			{$module_box_L2}
			</div>

			<div class="body_right_content">
			{$module_box_R1}
			</div>

			<div class="body_right_content">
			{$module_box_R2}
			</div>
		</div>
	</div>
</div>