 <?php

class API{
	function Select(){

$host = "SG2NWPLS14SQL-v09.shr.prod.sin2.secureserver.net";
$username="lifenew";
$password="Mido@445544";
$database="newlife2020";
$connectionInfo = array( "Database"=>"newlife2020", "UID"=>"lifenew", "PWD"=>"dd5*uT02","CharacterSet" => "UTF-8");
$conn = sqlsrv_connect($host,$connectionInfo);
		 $sql;
		$Fann_ID =$_GET['id'];
		if($Fann_ID != '-1')
		{
			 $sql = "select Move_Date,User_Logged,Qest_ID,Cust_Code,Qest_Val,Paid,Make_Siana,Siana_Val,Paid_For_Siana,Notes,Fanni_Nm,Fann_ID,Confirmed,Takm,Shamaa_Ola,other_Sianat,Add_To_Salary from Tahsealat where Fann_ID = $Fann_ID and Add_To_Salary = 'False' ";
		}
		else{
			 $sql = "select Move_Date,User_Logged,Qest_ID,Cust_Code,Qest_Val,Paid,Make_Siana,Siana_Val,Paid_For_Siana,Notes,Fanni_Nm,Fann_ID,Confirmed,Takm,Shamaa_Ola,other_Sianat,Add_To_Salary from Tahsealat where Add_To_Salary = 'False' ";
		}
		
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
$users = array();
		$i=0;
		
   while( $row = sqlsrv_fetch_array( $stmt) ) {
             $users[$i]=array(
				 'Move_Date'=>$row['Move_Date'],
				 'User_Logged'=>$row['User_Logged'],
				 'Qest_ID'=>$row['Qest_ID'],
				 'Cust_Code'=>$row['Cust_Code'],
				 'Qest_Val'=>$row['Qest_Val'],
				 'Paid'=>$row['Paid'],
				 'Notes'=>$row['Notes'],
				 'Fanni_Name'=>$row['Fanni_Nm'],
				 'Fanni_ID'=>$row['Fann_ID'],
				 'Confirmed'=>$row['Confirmed'],
				 'add_To_Salary'=>$row['Add_To_Salary'],
				 'takm'=>$row['Takm'],
				 'shamaa_Ola'=>$row['Shamaa_Ola'],
				 'other_Sianat'=>$row['other_Sianat'],
				 'make_siana'=>$row['Make_Siana'],
				 'siana_val'=>$row['Siana_Val'],
				 'paid_For_siana'=>$row['Paid_For_Siana'],
				 
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