 <?php

include "connect.php";
 
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
