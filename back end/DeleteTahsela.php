<?php

class API{
	function Select(){

$host = "SG2NWPLS14SQL-v09.shr.prod.sin2.secureserver.net";
$username="lifenew";
$password="Mido@445544";
$database="newlife2020";
$connectionInfo = array( "Database"=>"newlife2020", "UID"=>"lifenew", "PWD"=>"Mido@445544","CharacterSet" => "UTF-8");
$conn = sqlsrv_connect($host,$connectionInfo);
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