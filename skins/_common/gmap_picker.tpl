<script src="http://maps.googleapis.com/maps/api/js?key={$gmap_api}"></script>

<form style="max-width:550px">
	<fieldset class="gllpLatlonPicker">
		<input type="hidden" class="gllpZoom" id="gllpZoom" value="{$zoom}" />
		<div class="card">
			<div class="card-header"><span class="oi oi-map-marker"></span> Pick Your Location</div>
			<table class="table">
				<tr>
					<td>
						<div class="gllpMap" style="width:auto;height:250px;border:solid 1px #000">Google Maps</div>
					</td>
				</tr>
				<tr>
					<td>Please pick your location from the map above. You can either move the marker, or double click the location.</td>
				</tr>
				<tr>
					<td>
						<div class="float-left">
							<div class="form-row">
								<div class="col-auto">
									<input type="text" class="gllpSearchField form-control"> </div>
								<div class="col-auto"><button type="button" class="gllpSearchButton btn btn-light input-sm"><span class="oi oi-magnifying-glass"></span></button></div>
							</div>
						</div>
						<div class="float-right"><button type="button" class="gllpUpdateButton btn btn-primary" onclick="tada()">Confirm Location</button></div>

					</td>
				</tr>
				<tr>
					<td>
						<div class="form-row">
							<div class="col-auto">Lat/Lon</div>
							<div class="col-4"><input type="text" class="gllpLatitude form-control" id="gllpLatitude" value="{$lat}" placeholder="&phi;" /></div>
							<div class="col-auto">&deg;</div>
							<div class="col-4"><input type="text" class="gllpLongitude form-control" id="gllpLongitude" value="{$lon}" placeholder="&lambda;" /></div>
							<div class="col-auto">&deg;</div>
							<div class="col-auto"><button type="button" class="gllpUpdateButton btn btn-light" id="gllpUpdateButton"><span class="oi oi-reload"></span></button></div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</fieldset>
</form>

<script>
	function tada() {
		var lat = $('#gllpLatitude').val();
		var lon = $('#gllpLongitude').val();
		var win = (window.opener ? window.opener : window.parent);

		<
		!--BEGINIF $mode == 'latlon1'-- >
			win.document.getElementById('{$fid}').value = lat + ',' + lon;
		win.$.colorbox.close(); <
		!--ENDIF-- >

		<
		!--BEGINIF $mode == 'latlon2'-- >
			win.document.getElementById('{$fid}_lat').value = lat;
		win.document.getElementById('{$fid}_lon').value = lon;
		win.$.colorbox.close(); <
		!--ENDIF-- >
	}

	$(function () {
		if (navigator && navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
				function (position) {
					$("#gllpLatitude").val(position.coords.latitude);
					$("#gllpLongitude").val(position.coords.longitude);
					$("#gllpZoom").val(12);
					$("#gllpUpdateButton").trigger('click');
				},
				function (error) {
					// alert(error.message);
				}, {
					enableHighAccuracy: true,
					timeout: 5000
				})
		}
	});
</script>