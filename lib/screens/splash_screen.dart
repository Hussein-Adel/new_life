import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:untitled/helper/users.dart';

import '../constants.dart';
import 'admin.dart';
import 'collectors.dart';
import 'commissioner.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<String> User = [];
  bool updateOrDelete = false;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (SpUtil.getString('email') != '') {
        User =
            (await Users().getLoginIDFromDataBase(SpUtil.getString('email')))!;
        if (User.isEmpty) {
          setState(() {
            updateOrDelete = true;
          });
          kToastErrorMessage('Your Email Deleted Or Updated ...');
        } else if (User[2].toString() == '0' || User[2].toString() == 'null') {
          setState(() {
            updateOrDelete = true;
          });
          kToastErrorMessage('Your Email Updated  ...');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: SpUtil.getString('email') == ''
          ? LoginScreen()
          : updateOrDelete
              ? LoginScreen()
              : SpUtil.getString('type') == 'ad'
                  ? Admin()
                  : SpUtil.getString('type') == 'col'
                      ? Collectors()
                      : Commissioner(),
      duration: 2750,
      imageSize: 300,
      imageSrc: "assets/logo.jpeg",
      text: "New Life",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 35.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
