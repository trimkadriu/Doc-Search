<?php
	function print_alert($type, $title, $message) {
		echo "<div class=\"alert alert-{$type}\"> <strong>{$title}</strong> {$message}</div>";
	}
?>