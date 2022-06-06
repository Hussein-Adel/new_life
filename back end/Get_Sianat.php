 <?php

class API{
	function Select(){

include "connect.php";
		 $sql;
		$Fann_ID =$_GET['id'];
		if($Fann_ID != '-1')
		{
			 $sql = "select Move_date,Fanni_Nm,Cust_ID,Cust_Nm,Takm,Shamaa_Ola,Other_Siana,Cost,Paid_Cash,Notes from Sianat where Fann_ID = $Fann_ID ";
		}
		else
		{
			 $sql = "select Move_date,Fanni_Nm,Cust_ID,Cust_Nm,Takm,Shamaa_Ola,Other_Siana,Cost,Paid_Cash,Notes from Sianat " ;
		}
		
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
$users = array();
		$i=0;
		
   while( $row = sqlsrv_fetch_array( $stmt) ) {
	   //Move_date,Fanni_Nm,Cust_ID,Cust_Nm,Takm,Shamaa_Ola,Other_Siana,Cost,Paid_Cash,Notes
             $users[$i]=array(
				 'Move_date'=>$row['Move_date'],
				 'Fanni_Nm'=>$row['Fanni_Nm'],
				 'Cust_ID'=>$row['Cust_ID'],
				 'Cust_Nm'=>$row['Cust_Nm'],
				 'Takm'=>$row['Takm'],
				 'Shamaa_Ola'=>$row['Shamaa_Ola'],
				 'Other_Siana'=>$row['Other_Siana'],
				 'Cost'=>$row['Cost'],
				 'Paid_Cash'=>$row['Paid_Cash'],
				 'Notes'=>$row['Notes'],
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