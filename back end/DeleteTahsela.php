<?php

class API{
	function Select(){

include "connect.php";
		 $sql;
		$ID =$_GET['id'];
		
		$sql = "DELETE from dbo.Tahsealat  where Qest_ID = $ID  and Confirmed = 'False' ";
		
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