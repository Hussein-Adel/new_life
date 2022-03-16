 <?php

$host = "SG2NWPLS14SQL-v09.shr.prod.sin2.secureserver.net";
$username="lifenew";
$password="Mido@445544";
$database="newlife2020";
$connectionInfo = array( "Database"=>"newlife2020", "UID"=>"lifenew", "PWD"=>"Mido@445544","CharacterSet" => "UTF-8");
$conn = sqlsrv_connect($host,$connectionInfo);

if( $conn ) {
     echo "Connection established.<br />";
}else{
     echo "Connection could not be established.<br />";
     die( print_r( sqlsrv_errors(), true));
}

 
  echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest1111<br/>';

if ($_SERVER['REQUEST_METHOD'] == "POST"){
      $Move_date =$_POST['move_date'];
      $Fanni_ID =$_POST['fanni_ID'];
      $Fanni_Nm =$_POST['fanni_Nm'];
      $Cust_ID =$_POST['cust_ID'];
      $Cust_Nm =$_POST['cust_Nm'];
      $Takm =$_POST['takm'];
      $Shamaa_Ola =$_POST['shamaa_Ola'];
	  $Other_Siana =$_POST['other_Siana'];
      $Cost =$_POST['cost'];
      $Paid_Cash =$_POST['paid_Cash'];
      $Notes =$_POST['notes'];



$query = "INSERT INTO dbo.Sianat
        (Move_date,Fanni_ID,Fanni_Nm,Cust_ID,Cust_Nm,Takm,Shamaa_Ola,Other_Siana,Cost,Paid_Cash,Notes)
        VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		

echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest22222<br/>';
$params = array($Move_date,$Fanni_ID,$Fanni_Nm,$Cust_ID,$Cust_Nm,$Takm,$Shamaa_Ola,$Other_Siana,$Cost,$Paid_Cash,$Notes);
echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest33333<br/>';
$result =sqlsrv_query($conn, $query,$params);
echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest44444<br/>';
	echo '<br/>teeeeeeeeeeeeeeeeeeeeeeeeeeeest55555<br/>';
	
}
sqlsrv_close($conn);
?>