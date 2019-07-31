<script src="{$site_url}/misc/js/chart.min.js"></script>
<div class="card">
	<div class="card-header"><span class="oi oi-graph"></span> Visitor Statistics</div>
	<div class="card-body">
		<div style="max-width:1900px;height:100%;overflow:hidden">
			<canvas id="canvas" height="300" width="1900"></canvas>
		</div>
	</div>
</div>

<div class="btn-group mt-2 mb-2">
<a href="task.php?mod=qstats&amp;run=stats.php&amp;cmd=detail_day" class="btn btn-light">Daily</a></li>
<a href="task.php?mod=qstats&amp;run=stats.php&amp;cmd=detail_month" class="btn btn-light">Monthly</a></li>
<a href="task.php?mod=qstats&amp;run=stats.php&amp;cmd=detail_year" class="btn btn-light">Yearly</a></li>
</div>

<!-- BEGINIF $tpl_mode == 'detail_day' -->
<div class="card">
	<div class="card-header">Reports</div>
	<div class="card-body">
		<form method="get" action="task.php">
		<input type="hidden" name="mod" value="qstats" />
		<input type="hidden" name="run" value="stats.php" />
		<input type="hidden" name="cmd" value="detail_day" />
		Display reports for month of {$start_date}
		<button type="submit" class="btn btn-primary">Go!</button>
		</form>
	</div>

	<table class="table table-bordered">
		<tr>
			<td colspan="5">Page Views/Visits</td>
		</tr>
		<tr>
			<th>Date</th>
			<th style="text-align:right">Pageviews</th>
			<th style="text-align:right">Visitors</th>
		</tr>
		<!-- BEGINBLOCK list -->
		<tr>
			<td>{$date}</td>
			<td align="right">{$pageview}</td>
			<td align="right">{$visit}</td>
		</tr>
		<!-- ENDBLOCK -->
		<tr>
			<td class="adminbg_r" align="right">Total</td>
			<td class="adminbg_r" style="text-align:right">{$tpv}</td>
			<td class="adminbg_r" style="text-align:right">{$tv}</td>
		</tr>
	</table>
</div>
<!-- ENDIF -->


<!-- BEGINIF $tpl_mode == 'detail_month' -->
<div class="card">
	<div class="card-header">Reports</div>
	<div class="card-body">
		<form method="get" action="task.php">
		<input type="hidden" name="mod" value="qstats" />
		<input type="hidden" name="run" value="stats.php" />
		<input type="hidden" name="cmd" value="detail_month" />
		Display reports for year of {$start_date}
		<button type="submit" class="btn btn-primary">Go!</button>
		</form>
    </div>

	<table class="table table-bordered">
		<tr>
			<td colspan="5">Page Views/Visits</td>
		</tr>
		<tr>
			<th>Month</th>
			<th style="text-align:right">Pageviews</th>
			<th style="text-align:right">Visitors</th>
		</tr>
	<!-- BEGINBLOCK list -->
		<tr>
			<td><a href="task.php?mod=qstats&amp;cmd=detail_day&amp;run=stats.php&amp;start_mm={$mo}&amp;start_yy={$ye}">{$date}</a></td>
			<td align="right">{$pageview}</td>
			<td align="right">{$visit}</td>
		</tr>
	<!-- ENDBLOCK -->
		<tr>
			<td class="adminbg_r" align="right">Total</td>
			<td class="adminbg_r" style="text-align:right">{$tpv}</td>
			<td class="adminbg_r" style="text-align:right">{$tv}</td>
		</tr>
	</table>
</div>
<!-- ENDIF -->


<!-- BEGINIF $tpl_mode == 'detail_year' -->
<div class="card">
	<div class="card-header">Reports</div>
<table class="table table-bordered">
	<tr>
		<td colspan="5">Page Views/Visits</td>
	</tr>
	<tr>
		<th>Year</th>
		<th style="text-align:right">Pageviews</th>
		<th style="text-align:right">Visitors</th>
	</tr>
	<!-- BEGINBLOCK list -->
	<tr>
		<td><a href="task.php?mod=qstats&amp;cmd=detail_month&amp;run=stats.php&amp;start_yy={$date}">{$date}</a></td>
		<td align="right">{$pageview}</td>
		<td align="right">{$visit}</td>
	</tr>
	<!-- ENDBLOCK -->
	<tr>
		<td align="right">Total</td>
		<td style="text-align:right">{$tpv}</td>
		<td style="text-align:right">{$tv}</td>
	</tr>
</table>
</div>
<!-- ENDIF -->

<script>
var lineChartData = {
	labels : [{$chart_x}],
	datasets : [
		{
			label: "Hits",
			fillColor : "rgba(220,220,220,0.2)",
			strokeColor : "rgba(220,220,220,1)",
			pointColor : "rgba(220,220,220,1)",
			pointStrokeColor : "#fff",
			pointHighlightFill : "#fff",
			pointHighlightStroke : "rgba(220,220,220,1)",
			data : [{$chart_y1}]
		},
		{
			label: "Visits",
			fillColor : "rgba(151,187,205,0.2)",
			strokeColor : "rgba(151,187,205,1)",
			pointColor : "rgba(151,187,205,1)",
			pointStrokeColor : "#fff",
			pointHighlightFill : "#fff",
			pointHighlightStroke : "rgba(151,187,205,1)",
			data : [{$chart_y2}]
		}
	]

}

window.onload = function(){
	var ctx = document.getElementById("canvas").getContext("2d");
	window.myLine = new Chart(ctx).Line(lineChartData, { responsive: true });
}
</script>