import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/screens/splash_screen.dart';

import 'helper/api_helper.dart';
import 'screens/admin.dart';
import 'screens/admin_page.dart';
import 'screens/collection_screen.dart';
import 'screens/collectors.dart';
import 'screens/commissioner.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await Firebase.initializeApp();
  await ApiProvider.getConnection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        Collectors.id: (context) => Collectors(),
        AdminPage.id: (context) => AdminPage(),
        Commissioner.id: (context) => Commissioner(),
        Admin.id: (context) => Admin(),
        CollectionScreen.id: (context) => CollectionScreen(),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        fontFamily: 'amiri-regular',
        primarySwatch: Colors.blue,
      ),
    );
  }
}
