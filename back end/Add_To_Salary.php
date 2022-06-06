<?php

class API{
	function Select(){
include "connect.php";
		 $sql;
		$Fann_ID =$_GET['id'];
		$sql = "update Tahsealat set Add_To_Salary = 'True' where Fann_ID = $Fann_ID and Confirmed = 'True' and Add_To_Salary = 'False' ";
		
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