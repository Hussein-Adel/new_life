 <?php

class API{
	function Select(){

include "connect.php";
		 $sql;
		$Qest_ID =$_GET['id'];
		
		$sql = "select Qest_ID from Tahsealat where Qest_ID = $Qest_ID ";	
		
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
$users = array();
		$i=0;
		
   while( $row = sqlsrv_fetch_array( $stmt) ) {
             $users[$i]=array(
				 'Qest_ID'=>$row['Qest_ID'],
			 );
	   $i =$i +1;
        }
        return json_encode($users);
sqlsrv_close($conn);

	}
	}
	$api = new API;
	header('Content-Type: application/json');
	echo $api->Select();

?>