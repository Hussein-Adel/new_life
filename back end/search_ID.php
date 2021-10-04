<?php

class API{
	function Select(){
$host = "SG2NWPLS14SQL-v09.shr.prod.sin2.secureserver.net";
$username="lifenew";
$password="Mido@445544";
$database="newlife2020";
$connectionInfo = array( "Database"=>"newlife2020", "UID"=>"lifenew", "PWD"=>"dd5*uT02","CharacterSet" => "UTF-8");
$conn = sqlsrv_connect($host,$connectionInfo);
		
	
     $ID =$_GET['ID'];	
		
$sql = "select ID,DateOfDue,Cash,CustID,Custnm from dbo.TanbeahatFatra_Open2 where ID = $ID ";
	$stmt = sqlsrv_query( $conn, $sql );
$search = array();
		$i=0;
        while( $row = sqlsrv_fetch_array( $stmt) ) {
			 $search[$i]=array(
				'Custnm'=>$row['Custnm'],
				'DateOfDue'=>$row['DateOfDue'],
				'Cash'=>$row['Cash'],
				'ID'=>$row['ID'],
				'CustID'=>$row['CustID'],
				);
              $i=$i+1;
			echo json_encode($search);
        }
				//return json_encode($search);
	
		sqlsrv_close($conn);
	
	}
	}
	$api = new API;
	header('Content-Type: application/json');
	echo $api->Select();

?>
 

