 <?php

class API{
	function Select(){

include "connect.php";

    $sql = "select  * from AppUsers";
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
$users = array();
//header('Content-Type: application/json');
		$i=0;
   while( $row = sqlsrv_fetch_array( $stmt) ) {
             $users[$i]=array(
					'id'=>$row['ID'],
				    'name'=>$row['Name'],
			 		'gmail'=>$row['GMail'],
				    'pass'=>$row['Pass'],
				    'type'=>$row['Type']
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

