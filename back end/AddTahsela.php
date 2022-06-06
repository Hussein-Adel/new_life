 <?php
include "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST"){
      $Move_Date =$_POST['date'];
      $User_Logged =$_POST['username'];
	  $Emlpoye_Name = ['emlpoyename'];
      $Qest_ID =$_POST['qest_id'];
      $Cust_Code =$_POST['cust_code'];
      $Qest_Val =$_POST['qest_val'];
      $Paid =$_POST['paid'];
      $Make_Siana =$_POST['make_siana'];
      $Siana_Type =$_POST['siana_type'];
      $Siana_Val =$_POST['siana_val'];
      $Paid_For_Siana =$_POST['paid_For_siana'];
      $Mantika =$_POST['mantika'];
      $Notes =$_POST['notes'];
	  $Confirmed =$_POST['confirmed'];
	  $Fann_ID =$_POST['fann_ID'];
	  $Fanni_Nm =$_POST['fanni_Nm'];
	  $Add_To_Salary =$_POST['add_To_Salary'];
	  $Takm =$_POST['takm'];
	  $Shamaa_Ola =$_POST['shamaa_Ola'];
	  $other_Sianat =$_POST['other_Sianat'];
  

	
$query = "INSERT INTO dbo.Tahsealat
        (Move_Date,User_Logged,Emlpoye_Name,Qest_ID,Cust_Code,Qest_Val,Paid,Make_Siana,Siana_Type,Siana_Val,Paid_For_Siana,Mantika,Notes,Confirmed,Fann_ID,Fanni_Nm,Add_To_Salary,Takm,Shamaa_Ola,other_Sianat)
        VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		

echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest22222<br/>';
$params = array($Move_Date,$User_Logged,$Emlpoye_Name,$Qest_ID,$Cust_Code,$Qest_Val,$Paid,$Make_Siana,$Siana_Type,$Siana_Val,$Paid_For_Siana,$Mantika,$Notes,$Confirmed,$Fann_ID,$Fanni_Nm,$Add_To_Salary,$Takm,$Shamaa_Ola,$other_Sianat);
echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest33333<br/>';
$result =sqlsrv_query($conn, $query,$params);
echo 'teeeeeeeeeeeeeeeeeeeeeeeeeeeest44444<br/>';
	echo '<br/>teeeeeeeeeeeeeeeeeeeeeeeeeeeest55555<br/>';
	
}
sqlsrv_close($conn);
?>
