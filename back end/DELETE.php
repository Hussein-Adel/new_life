 <?php

class API{
	function Select(){

include "connect.php";
		
		$gmail =$_GET['gmail'];
    $sql =  " DELETE from AppUsers where GMail = '$gmail' ";
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
	return json_encode($gmail);
sqlsrv_close($conn);

	}
	}
	$api = new API;
	header('Content-Type: application/json');
	echo $api->Select();

?>
