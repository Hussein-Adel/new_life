import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/helper/users.dart';

import '../components/admin_button.dart';
import 'admin_page.dart';
import 'collection_screen.dart';
import 'collectors.dart';
import 'commissioner.dart';
import 'login_screen.dart';

class Admin extends StatelessWidget {
  static const String id = 'admin_screen';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await _auth.signOut();
            await Users().signLogout(SpUtil.getString('email'));
            Navigator.pushReplacementNamed(context, LoginScreen.id);
            SpUtil.remove('email');
            SpUtil.remove('password');
            SpUtil.remove('type');
          },
        ),
        brightness: Brightness.dark,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المحصلين',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AdminScreenWidget(
                iconData: Icons.person,
                title: 'المفوضين',
                color: Colors.orangeAccent,
                onPress: () async {
                  Navigator.pushNamed(context, Commissioner.id);
                },
              ),
              AdminScreenWidget(
                iconData: Icons.money_rounded,
                title: 'المحصلين',
                color: Colors.orangeAccent,
                onPress: () {
                  Navigator.pushNamed(context, Collectors.id);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AdminScreenWidget(
                iconData: Icons.supervised_user_circle_outlined,
                title: 'المستخدمين',
                color: Colors.orangeAccent,
                onPress: () {
                  Navigator.pushNamed(context, AdminPage.id);
                },
              ),
              AdminScreenWidget(
                iconData: Icons.attach_money_rounded,
                title: 'التحصيلات',
                color: Colors.orangeAccent,
                onPress: () {
                  Navigator.pushNamed(context, CollectionScreen.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
