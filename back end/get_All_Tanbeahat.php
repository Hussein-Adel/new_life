 <?php

class API{
	function Select(){

include "connect.php";
		 $Code =$_GET['code'];	
		
		  			$sql = "select ID,DateOfDue,PaidDate,Cash,CustID,Custnm,Paid,AlarmState,Mokadima,QestID,InvTot from dbo.TanbeahatFatra_Open2 where CustCode	 = '$Code' ";
    
    $params = array();
    $options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
    $stmt = sqlsrv_query( $conn, $sql , $params, $options );
$users = array();
//header('Content-Type: application/json');
		$i=0;
   while( $row = sqlsrv_fetch_array( $stmt) ) {
             $search[$i]=array(
				'Custnm'=>$row['Custnm'],
				'DateOfDue'=>$row['DateOfDue'],
				'Cash'=>$row['Cash'],
				'ID'=>$row['ID'],
				'CustID'=>$row['CustID'],
				'Paid'=>$row['Paid'],
				'AlarmState'=>$row['AlarmState'],
				'Mokadima'=>$row['Mokadima'],
				'QestID'=>$row['QestID'],
				'InvTot'=>$row['InvTot'],
				'PaidDate'=>$row['PaidDate'],
                                );
	   $i =$i +1;
        }
        return json_encode($search);
sqlsrv_close($conn);

	}
	}
	$api = new API;
	header('Content-Type: application/json');
	echo $api->Select();

?>