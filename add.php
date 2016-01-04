<?php include 'header.php'; ?>
<?php include 'dbconnect.php'; ?>
<?php
	if (!empty($_POST)) {
		$text = isset($_POST['text']) ? $_POST['text'] : '';
		if(!empty($text)) {
			$sql = "INSERT INTO documents(doc_text) VALUES ($1)";
			$result = pg_prepare($dbconn, "insert_text_query", $sql);
			$result = pg_execute($dbconn, "insert_text_query", array($text));
			print_alert('success', 'Success', 'You successfully added a text');
		}
		else {
			print_alert('danger', 'Error', 'There was an error while adding data');
		}
	}
?>
	<form method="post">
		<label for="text">Text:</label>
		<textarea id="text" name="text" class="form-control" rows="5"></textarea><br/>
		<input class="btn btn-default pull-right" type="submit" value="Add" />
	</form>
<?php include 'footer.php'; ?>