 <?php

class API{
	function Select(){
include "connect.php";



  $sql = "select ManID , MandoobNm from dbo.Fanni ";
    $stmt = sqlsrv_query( $conn, $sql );

$users = array();
		$i=0;
   while( $row = sqlsrv_fetch_array( $stmt) ) {
             $users[$i]=array(
					'id'=>$row['ManID'],
				    'name'=>$row['MandoobNm'],
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
 


  