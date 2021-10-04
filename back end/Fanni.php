 <?php

class API{
	function Select(){
$host = "SG2NWPLS14SQL-v09.shr.prod.sin2.secureserver.net";
$username="lifenew";
$password="Mido@445544";
$database="newlife2020";
$connectionInfo = array( "Database"=>"newlife2020", "UID"=>"lifenew", "PWD"=>"dd5*uT02","CharacterSet" => "UTF-8");
$conn = sqlsrv_connect($host,$connectionInfo);



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
 


  