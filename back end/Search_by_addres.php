 <?php

class API{
	function Select(){

include "connect.php";
		 $addres =$_GET['addres'];	
		
		list($ID, $MyAddres) = explode(',', $addres);
		$test = "%$MyAddres%";	
		if($ID != '-1')
		{

    		$sql = "select Phone2,ManNm,ComName,Address,Phone,Mobile,fanniNm,Installdate,Siana_Code from AllCustData_Vi where Address LIKE N'$test' and MandoobID = '$ID' ";
		}
		else{  
			$sql = "select Phone2,ComName,ManNm,Address,Phone,Mobile,fanniNm,Installdate,Siana_Code from AllCustData_Vi where Address LIKE N'$test' ";
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
				 	'Siana_Code'=>$row['Siana_Code']
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