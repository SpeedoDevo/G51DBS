<?php
	// Define variables to store our username
	$user = 'bxf03u';
	$pass = *****

	// Create a connection to the MySql server
	$conn = mysql_connect('mysql.cs.nott.ac.uk', $user, $pass);
	
	// Check if connection was successful
	if (!$conn)
	{
		die ('Failed to connect to MySQL server: ' . mysql_error());
	}
	
	// Change to correct database on the server
	$select_db_success = mysql_select_db($user, $conn);
	
	// Check database selection was successful
	if (!$select_db_success)
	{
		die ("Failed to select database: " . mysql_error());
	}
?>
