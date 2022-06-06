<?php

class API{
	function Select(){

include "connect.php";
		 $sql;
		$mail =$_GET['mail'];
		$sql = "update AppUsers set IS_Login = 'False' where GMail = '$mail' ";	
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );

sqlsrv_close($conn);

	}
	}
	$api = new API;
	header('Content-Type: application/json');
	echo $api->Select();

?>