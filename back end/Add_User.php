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
 
if ($_SERVER['REQUEST_METHOD'] == "POST"){
      $id =$_POST['id'];
      $name =$_POST['username'];
      $GMail =$_POST['gmail'];
      $Pass =$_POST['pass'];
      $Type =$_POST['type'];
	  $Login =$_POST['login'];

$query = "INSERT INTO  dbo.AppUsers
        (ID , Name , GMail,Pass,Type,IS_Login)
        VALUES(?,?,?,?,?,?)";
$params = array($id,$name,$GMail,$Pass,$Type,$Login);
$result =sqlsrv_query($conn, $query, $params);	
}
sqlsrv_close($conn);
?>
