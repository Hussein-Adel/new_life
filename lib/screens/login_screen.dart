import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sp_util/sp_util.dart';

import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../helper/users.dart';
import 'admin.dart';
import 'collectors.dart';
import 'commissioner.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner = false;
  late List<String> User = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/logo.jpeg'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    labelText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    labelText: 'Enter your password',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    on_pressed: () async {
                      String type;
                      List<String> x = email.split('.');
                      print(x.length);
                      type = x[x.length - 1];
                      print(type);
                      setState(() {
                        showSpinner = true;
                      });
                      if (email == '' || password == '') {
                        setState(() {
                          showSpinner = false;
                          email = '';
                          password = '';
                        });
                        kToastErrorMessage(
                            'Your Email or Password is empty ...');
                      }
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        if (user != null) {
                          print('gggggggggggggggggggggggggggggggg');
                          User = (await Users().getLoginIDFromDataBase(email))!;
                          print('gggggggggggggggggggggggggggggggg2');
                          print(User);
                          print('gggggggggggggggggggggggggggggggg3');
                          if (User[2].toString() == '0' ||
                              User[2].toString() == 'null') {
                            await Users().signLogin(email);
                            type == 'ad'
                                ? SpUtil.putString('id', '-1')
                                : type == 'sup'
                                    ? SpUtil.putString('id', '-1')
                                    : SpUtil.putString(
                                        'id', User[0].toString());
                            type == 'ad'
                                ? SpUtil.putString('name', 'Admin')
                                : type == 'sup'
                                    ? SpUtil.putString('name', 'Supervisor')
                                    : SpUtil.putString('name', User[1]);
                            SpUtil.putString('email', email);
                            SpUtil.putString('password', password);
                            SpUtil.putString('type', type);
                            SpUtil.putInt('counter', 0);
                            SpUtil.putInt('counter_of_siana', 0);
                            if (type == 'ad') {
                              Navigator.pushReplacementNamed(context, Admin.id);
                            } else if (type == 'col') {
                              Navigator.pushReplacementNamed(
                                  context, Collectors.id);
                            } else if (type == 'com' || type == 'sup') {
                              Navigator.pushReplacementNamed(
                                  context, Commissioner.id);
                            }
                          } else {
                            setState(() {
                              showSpinner = false;
                            });
                            kToastErrorMessage(
                                'للأسف لا يمكنك تسجيل الدخول لهذا الحساب لقد تم تسجيل الدخول لهاذا الحساب مسبقا ');
                          }
                        }
                      } catch (e) {
                        print('a7777777777777777777777777777777777777777a');
                        print(e);

                        setState(() {
                          showSpinner = false;
                        });

                        List<String> FirebaseAuthException =
                            e.toString().split(']');
                        print('a7777777777777777777777777777777777777777a2');

                        kToastErrorMessage(FirebaseAuthException);
                        print('a7777777777777777777777777777777777777777a3');

                        kToastErrorMessage(FirebaseAuthException[1]);
                      }
                    },
                    my_text: 'Log In',
                    my_color: Colors.lightBlueAccent)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
