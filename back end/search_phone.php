 <?php

class API{
	function Select(){

$host = "SG2NWPLS14SQL-v09.shr.prod.sin2.secureserver.net";
$username="lifenew";
$password="Mido@445544";
$database="newlife2020";
$connectionInfo = array( "Database"=>"newlife2020", "UID"=>"lifenew", "PWD"=>"dd5*uT02","CharacterSet" => "UTF-8");
$conn = sqlsrv_connect($host,$connectionInfo);
		 $myPhone =$_GET['phone'];	
		
		list($ID, $Phone) = explode(',', $myPhone);	
		if($ID != '-1')
		{

    		$sql = "select Phone2,ManNm,ComName,Address,Phone,Mobile,fanniNm,Installdate from AllCustData_Vi where Phone = '$Phone' and MandoobID = '$ID' ";
		}
		else{  

			$sql = "select Phone2,ComName,ManNm,Address,Phone,Mobile,fanniNm,Installdate from AllCustData_Vi where Phone = '$Phone' ";
		}

    
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
$users = array();
//header('Content-Type: application/json');
		$i=0;
   while( $row = sqlsrv_fetch_array( $stmt) ) {
             $users[$i]=
		array(
					'customer_id'=>$row['Phone2'],
				 	'customer_name'=>$row['ComName'],
				 	'address'=>$row['Address'],
				 	'phone'=>$row['Phone'],
				 	'mohafza'=>$row['Mobile'],
				 	'fanniNm'=>$row['fanniNm'],
				 	'installdate'=>$row['Installdate'],
				 	'manNm'=>$row['ManNm'],
				 
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