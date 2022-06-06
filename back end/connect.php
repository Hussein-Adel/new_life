<?php
 
	 $host = "SQL8003.site4now.net";
			$username = "db_a86AC8_newlife2020_admin";
			$password = "Mido@445544";
			$database = "db_a86ac8_newlife2020";
			$connectionInfo = array("Database" => $database, "UID" => $username, "PWD" => $password, "CharacterSet" => "UTF-8");
			try {
 	
			$conn = sqlsrv_connect($host, $connectionInfo);
  


 }catch(Exception $e) {
 echo $e->getMessage() ;
 }


?>
