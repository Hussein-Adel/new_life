 <?php

class API{
	function Select(){

include "connect.php";
		
		$mail =$_GET['gmail'];
		
    $sql = "select  ID,Name,IS_Login from AppUsers where GMail = '$mail' ";
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
				 	'login'=>$row['IS_Login'],
				 
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
