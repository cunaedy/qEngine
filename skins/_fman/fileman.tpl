<script>
	function confirm_delete(filename) {
		c = window.confirm("Do you wish to delete '" + filename + "'?\nThis process can not be undone!");
		if (!c) return false;
		document.location = "fileman.php?cmd=del&fn=" + filename + "&chdir={$cur_path}";
	}

	function confirm_rename(filename) {
		newname = filename;
		c = window.prompt("Enter a new name for '" + filename + "'?", newname);
		if (!c) return false;
		document.location = "fileman.php?cmd=ren&fn=" + filename + "&newfn=" + c + "&chdir={$cur_path}";
	}

	function confirm_copy(filename) {
		newname = 'copy_of_' + filename;
		c = window.confirm("Copy '" + filename + "' to '" + newname + "'?\nYou can rename later.");
		if (!c) return false;
		document.location = "fileman.php?cmd=copy&fn=" + filename + "&chdir={$cur_path}";
	}

	function confirm_mkdir() {
		c = window.prompt("Enter a new directory name", "new folder");
		if (!c) return false;
		document.location = "fileman.php?cmd=mkdir&fn=" + c + "&chdir={$cur_path}";
	}

	function confirm_new() {
		c = window.prompt("Enter a new file name", "newfile.ext");
		if (!c) return false;
		document.location = "fileman.php?cmd=new&fn=" + c + "&chdir={$cur_path}";
	}

	function confirm_rmdir(filename) {
		c = window.confirm("Do you wish to delete '" + filename + "'?\nThis process can not be undone!");
		if (!c) return false;
		document.location = "fileman.php?cmd=rmdir&fn=" + filename + "&chdir={$cur_path}";
	}

	function confirm_rendir(filename) {
		newname = filename;
		c = window.prompt("Enter a new name for '" + filename + "'?", newname);
		if (!c) return false;
		document.location = "fileman.php?cmd=rendir&fn=" + filename + "&newfn=" + c + "&chdir={$cur_path}";
	}

	function confirm_move(filename) {
		window.open("tree.php?cmd=move&chdir={$cur_path}&fn=" + filename, "tree",
			"toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=350,height=450");
	}

	function browse() {
		window.open("tree.php?cmd=browse&chdir={$cur_path}&fn=", "tree",
			"toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=350,height=450");
	}
</script>

<h1><img src="./../../skins/_fman/images/fman.png" style="width:64px" alt="fman" /> File Manager</h1>
<div class="card">
	<div class="card-header">
		{$where}
	</div>
	<table id="fman_list" class="table table-condensed table-bordered">
		<tr>
			<th width="45%">Name</th>
			<th width="12%" class="text-right">Size</th>
			<th width="20%" class="text-right">Date Modified</th>
			<th width="25%" class="text-right">Tools</th>
		</tr>

		<!-- BEGINBLOCK fileman_item -->
		<tr>
			<td>{$name}</td>
			<td class="text-right">{$size}</td>
			<td class="text-right">
				<small>{$mtime}</smallfont>
			</td>
			<td class="text-right">{$tools}</td>
		</tr>
		<!-- ENDBLOCK -->

		<tr>
			<td colspan="4" class="text-center">{$num_files} file(s) and {$num_dirs} directory(s) in {$ttl_size} bytes</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center" class="small">
				<img src="./../../skins/_fman/images/view.gif" alt="View" /> view file &nbsp;&nbsp;
				<img src="./../../skins/_fman/images/ren.gif" alt="Rename" /> rename file/folder &nbsp;&nbsp;
				<img src="./../../skins/_fman/images/copy.gif" alt="Copy" /> copy file &nbsp;&nbsp;
				<img src="./../../skins/_fman/images/del.png" alt="Delete" /> delete file/folder &nbsp;&nbsp;
				<img src="./../../skins/_fman/images/edit.gif" alt="Edit" /> edit html/text file &nbsp;&nbsp;
				<img src="./../../skins/_fman/images/move.gif" alt="Move" /> move file
			</td>
		</tr>
	</table>

	<div class="card-footer text-center">
			<a href="#" class="btn btn-light" onClick="browse()">Dir Tree</a>
			<a href="upload.php?chdir={$cur_path}" class="btn btn-light" >Upload</a>
			<a href="#" class="btn btn-light" onClick="confirm_mkdir ()">New Folder</a>
			<a href="#" class="btn btn-light" onClick="confirm_new ()">New File</a>
			<hr>
			<small>Total space: {$max_space} bytes | Used {$used_space} bytes | Free: {$free_space} bytes</small>
	</div>
</div>