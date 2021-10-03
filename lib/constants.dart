import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServerVars {
  static const String Global_BASE_URL = "http://new-life.life/";

  ///Mustafa's work
  static const String addUser = "Add_User.php/";
  static const String addcollection = "AddTahsela.php/";
  static const String getUsers = "Get_users.php/";
  static const String getMandoob = "Mandoob.php/";
  static const String getFanni = "Fanni.php/";
  static const String deletUser = "DELETE.php/";
  static const String getTanbeha = "search_ID.php/";
  static const String SearshByName = "Searsh_by_Name.php/";

  ///Hussein's work
  static const String getLoginId = "get_loge_in_user.php/";
  static const String addSiana = "Add_Siana.php/";
  static const String getUsersOfMandoob = "get_users_of_mandoob.php/";
  static const String getTahsealat = "get_Tahsealat.php/";
  static const String getSianat = "Get_Sianat.php/";
  static const String searchByPhone = "search_phone.php/";
  static const String searchByCode = "Searsh_by_Code.php/";
  static const String searchByAddres = "Search_by_addres.php/";
  static const String getAllTanbeahat = "get_All_Tanbeahat.php/";
  static const String confirm = "confirm.php/";
  static const String addToSalary = "Add_To_Salary.php/";
  static const String signLogin = "sign_login.php/";
  static const String signLogout = "signlogout.php/";
  static const String deleteTahsela = "DeleteTahsela.php/";
  static const String seaech_Tahsela = "Seaech_Tahsela.php/";
}

Future<bool?> kToastErrorMessage(var message) {
  return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<bool?> kToastSuccessMessage(var message) {
  return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

const kTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);
const kTextStyle2 = TextStyle(
  fontSize: 19,
  color: Colors.black,
);
const kPrimaryColor = Color(0xFFE5E3E3);
const kSecondaryColor = Color(0xff116dc4);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
