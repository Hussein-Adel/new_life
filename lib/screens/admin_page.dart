import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/helper/api_helper.dart';
import 'package:untitled/models/user_model.dart';

import '../components/body_dialog.dart';
import '../constants.dart';
import '../helper/users.dart';
import '../models/fanni_mandoob_model.dart';

class AdminPage extends StatefulWidget {
  static const String id = 'admin_page';

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<UserModel> allUser = [];
  List<UserModel> allCollectors = [];
  List<UserModel> allCommissioner = [];
  List<FanniMandoobModel> Mandoob = [];
  List<FanniMandoobModel> Fanni = [];

  getUsers() async {
    allUser = (await Users().getUserFromDataBase())!;
  }

  late String valueChoseforMandoob = '';
  late List listOfMandoob = [];
  getMandoob() async {
    Mandoob = (await Users().getMandoobFromDataBase())!;
    for (int i = 0; i < Mandoob.length; i++) {
      setState(() {
        listOfMandoob.add(Mandoob[i].username);
      });
    }

    for (int y = 0; y < listOfMandoob.length; y++) {
      for (int x = 0; x < allUser.length; x++) {
        if (listOfMandoob[y] == allUser[x].username) {
          listOfMandoob.removeAt(y);
        }
      }
    }
    setState(() {
      valueChoseforMandoob = listOfMandoob[0];
    });
  }

  late String valueChoseforFanni = '';
  late List listOfFanni = [];
  getFanni() async {
    Fanni = (await Users().getFanniFromDataBase())!;
    for (int i = 0; i < Fanni.length; i++) {
      setState(() {
        listOfFanni.add(Fanni[i].username);
      });
    }

    for (int y = 0; y < listOfFanni.length; y++) {
      for (int x = 0; x < allUser.length; x++) {
        if (listOfFanni[y] == allUser[x].username) {
          listOfFanni.removeAt(y);
        }
      }
    }
    setState(() {
      valueChoseforFanni = listOfFanni[0];
    });
  }

  int getId(String name, bool fanni) {
    int id = 0;
    for (int i = 0; i < (fanni ? Fanni.length : Mandoob.length); i++) {
      if ((fanni ? Fanni[i].username : Mandoob[i].username) == name) {
        id = (fanni ? Fanni[i].id : Mandoob[i].id);
      }
    }
    return id;
  }

  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getUsers();
      setState(() {
        print(allUser.length);
      });
      await getFanni();
      await getMandoob();
    });

    showSpinner = false;
  }

  bool coll = true;
  final _auth = FirebaseAuth.instance;

  String type = 'empty';
  bool add = false;
  String email = 'empty';
  String password = 'empty';
  String nameOfAdminOrSupervisor = '';
  bool showSpinner = false;
  bool checkBoxValueOfCollectors = false;
  bool checkBoxValueOfSupervisor = false;
  bool checkBoxValueOfCommissioner = false;
  bool checkBoxValueOfAdmin = false;
  TextEditingController installmentController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  addUser(
    String mail,
    String pass,
    String type,
    String name,
  ) async {
    double width = MediaQuery.of(context).size.width;
    ApiProvider.getConnection();
    if ((SpUtil.getBool('connectivity'))!) {
      email = 'empty';
      emailController.text = '';
      passwordController.text = '';
      password = 'empty';
      nameController.text = '';
      nameOfAdminOrSupervisor = 'empty';
      checkBoxValueOfAdmin = false;
      checkBoxValueOfSupervisor = false;
      checkBoxValueOfCommissioner = false;
      checkBoxValueOfCollectors = false;
      if (type != 'false') {
        emailController.text = mail;
        email = mail;
        passwordController.text = pass;
        password = pass;
        nameController.text = name;
        nameOfAdminOrSupervisor = name;
        if (type == 'ad') {
          checkBoxValueOfAdmin = true;
        } else if (type == 'sup') {
          checkBoxValueOfSupervisor = true;
        } else if (type == 'col') {
          checkBoxValueOfCollectors = true;
        } else if (type == 'com') {
          checkBoxValueOfCommissioner = true;
        }
      }
      await showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: BodyDialog(
                  body: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اسم المستخدم : ',
                            style: kTextStyle,
                          ),
                          Container(
                            width: width * 0.35,
                            child: TextField(
                              controller: emailController,
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'أكتب الاسم'),
                              keyboardType: TextInputType.multiline,
                              onChanged: (val) {
                                email = val;
                              },
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الرقم السرى : ',
                            style: kTextStyle,
                          ),
                          Container(
                            width: width * 0.35,
                            child: TextField(
                              controller: passwordController,
                              decoration:
                                  kTextFieldDecoration.copyWith(labelText: ''),
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                password = val;
                              },
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'صلاحيات المستخدم : ',
                      style: kTextStyle2,
                    ),
                    SizedBox(
                      height: 25.0,
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.35,
                            child: Text(
                              ' مدير : ',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              value: this.checkBoxValueOfAdmin,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValueOfAdmin = value!;
                                  if (value == true) {
                                    checkBoxValueOfCollectors = !value;
                                    checkBoxValueOfCommissioner = !value;
                                    checkBoxValueOfSupervisor = !value;
                                  }
                                });
                              },
                              checkColor: Colors.green,
                              activeColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.35,
                            child: Text(
                              ' مفوض : ',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              value: this.checkBoxValueOfCommissioner,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValueOfCommissioner = value!;
                                  if (value == true) {
                                    checkBoxValueOfCollectors = !value;
                                    checkBoxValueOfAdmin = !value;
                                    checkBoxValueOfSupervisor = !value;
                                  }
                                });
                              },
                              checkColor: Colors.green,
                              activeColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.35,
                            child: Text(
                              ' فنى : ',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              value: this.checkBoxValueOfCollectors,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValueOfCollectors = value!;
                                  if (value == true) {
                                    checkBoxValueOfCommissioner = !value;
                                    checkBoxValueOfAdmin = !value;
                                    checkBoxValueOfSupervisor = !value;
                                  }
                                });
                              },
                              checkColor: Colors.green,
                              activeColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.35,
                            child: Text(
                              ' مشرف : ',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              value: this.checkBoxValueOfSupervisor,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValueOfSupervisor = value!;
                                  if (value == true) {
                                    checkBoxValueOfCommissioner = !value;
                                    checkBoxValueOfAdmin = !value;
                                    checkBoxValueOfCollectors = !value;
                                  }
                                });
                              },
                              checkColor: Colors.green,
                              activeColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    checkBoxValueOfCommissioner || checkBoxValueOfCollectors
                        ? DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            iconSize: 36,
                            hint: Text('اختار موظف'),
                            value: checkBoxValueOfCollectors
                                ? valueChoseforFanni
                                : valueChoseforMandoob,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValueOfCollectors
                                    ? valueChoseforFanni = newValue.toString()
                                    : valueChoseforMandoob =
                                        newValue.toString();
                              });
                            },
                            items: checkBoxValueOfCollectors
                                ? listOfFanni.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList()
                                : listOfMandoob.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'الأسم : ',
                                  style: kTextStyle,
                                ),
                                Container(
                                  width: width * 0.35,
                                  child: TextField(
                                    controller: nameController,
                                    decoration: kTextFieldDecoration.copyWith(
                                        labelText: ''),
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (val) {
                                      nameOfAdminOrSupervisor = val;
                                    },
                                    style: TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            bool checkname = false;
                            if (checkBoxValueOfAdmin ||
                                checkBoxValueOfSupervisor) {
                              if (nameOfAdminOrSupervisor != 'empty')
                                checkname = true;
                            } else {
                              checkname = true;
                            }

                            late int id;
                            if (email != 'empty' &&
                                password != 'empty' &&
                                checkname &&
                                (checkBoxValueOfAdmin ||
                                    checkBoxValueOfSupervisor ||
                                    checkBoxValueOfCommissioner ||
                                    checkBoxValueOfCollectors)) {
                              setState(() {
                                showSpinner = true;
                              });

                              if (checkBoxValueOfAdmin) {
                                id = -1;
                                type = 'ad';
                                email = email + '@gmail.' + type;
                              } else if (checkBoxValueOfSupervisor) {
                                id = 0;
                                type = 'sup';
                                email = email + '@gmail.' + type;
                              } else if (checkBoxValueOfCommissioner) {
                                id = getId(valueChoseforMandoob, false);
                                type = 'com';
                                email = email + '@gmail.' + type;
                              } else if (checkBoxValueOfCollectors) {
                                id = getId(valueChoseforFanni, true);
                                type = 'col';
                                email = email + '@gmail.' + type;
                              }
                              add = await Users().addUserInFirebase(
                                  email, password, context, _auth);
                              Navigator.pop(context);

                              add
                                  ? await Users().addUserInDataBase(
                                      Id: id,
                                      username: checkBoxValueOfAdmin ||
                                              checkBoxValueOfSupervisor
                                          ? nameOfAdminOrSupervisor
                                          : checkBoxValueOfCollectors
                                              ? valueChoseforFanni
                                              : valueChoseforMandoob,
                                      gmail: email,
                                      pass: password,
                                      type: type,
                                      login: false,
                                    )
                                  : kToastErrorMessage('user did not added');

                              Navigator.pop(context);
                              setState(
                                () {
                                  showSpinner = false;
                                },
                              );
                            } else if (email == 'empty') {
                              kToastErrorMessage('أدخل اسم المستخدم');
                            } else if (password == 'empty') {
                              kToastErrorMessage(
                                  'أدخل الرقم السرى الخاص بالمستخدم');
                            } else if (nameOfAdminOrSupervisor == 'empty') {
                              kToastErrorMessage(
                                  'أدخل الأسم الخاص بالمدير او المشرف');
                            } else if (!checkBoxValueOfAdmin &&
                                !checkBoxValueOfSupervisor &&
                                !checkBoxValueOfCommissioner &&
                                !checkBoxValueOfCollectors) {
                              kToastErrorMessage('أختار نوع المستخدم');
                            } else
                              print('aaaa7777777777777777777777777777777aaaa');
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.015),
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Text(
                                'تأكيد',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.015),
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Text(
                                'ألغاء',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ],
                ),
              );
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    showSpinner = false;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await addUser(
              '',
              '',
              'false',
              '',
            );
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          brightness: Brightness.dark,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'المستخدمين ',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: allUser.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: allUser[index].type == 'col'
                            ? Colors.deepPurpleAccent
                            : allUser[index].type == 'com'
                                ? Colors.deepOrangeAccent
                                : allUser[index].type == 'ad'
                                    ? Colors.lightGreenAccent.withOpacity(0.75)
                                    : Colors.white24,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.4),
                              blurRadius: 5,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: MediaQuery.of(context).size.width * 0.06,
                          child: Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.width * 0.1,
                            color: Colors.teal.withOpacity(0.8),
                          ),
                        ),
                        title: Text(
                          allUser[index].username,
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        subtitle: Text(
                          allUser[index].type == 'col'
                              ? 'فنى'
                              : allUser[index].type == 'com'
                                  ? 'مفوض'
                                  : allUser[index].type == 'ad'
                                      ? 'مدير'
                                      : 'مشرف',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        trailing: SizedBox(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${allUser[index].id} : ID',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  '${allUser[index].password} : Password',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              Text(
                                '${allUser[index].gmail} : Gmail ',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Users().deletUser(
                                    gmail: allUser[index].gmail,
                                  );

                                  final newuser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: allUser[index].gmail,
                                          password: allUser[index].password);
                                  if (newuser != null) {
                                    User? user = await _auth.currentUser;
                                    AuthCredential credential =
                                        EmailAuthProvider.credential(
                                            email: allUser[index].gmail,
                                            password: allUser[index].password);
                                    await user!
                                        .reauthenticateWithCredential(
                                            credential)
                                        .then(
                                      (value) {
                                        value.user!.delete().then(
                                          (res) {
                                            kToastSuccessMessage(
                                                ' User Delete Success!!! ');
                                            print(' User Delete Success!!! ');
                                          },
                                        );
                                      },
                                    ).catchError((onError) =>
                                            kToastSuccessMessage(' $onError '));
                                  }
                                  final trueuser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: SpUtil.getString('email')!,
                                          password:
                                              SpUtil.getString('password')!);
                                  if (trueuser != null)
                                    print(
                                        'SignInWithEmailAndPassword Success!!!');
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Center(
                                    child: Text(
                                      ' حذف ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Users().deletUser(
                                    gmail: allUser[index].gmail,
                                  );
                                  final newuser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: allUser[index].gmail,
                                          password: allUser[index].password);
                                  if (newuser != null) {
                                    User? user = await _auth.currentUser;
                                    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhh323');
                                    print(user!.email);
                                    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhh323');

                                    AuthCredential credential =
                                        EmailAuthProvider.credential(
                                            email: allUser[index].gmail,
                                            password: allUser[index].password);
                                    await user
                                        .reauthenticateWithCredential(
                                            credential)
                                        .then(
                                      (value) {
                                        value.user!.delete().then(
                                          (res) {
                                            kToastSuccessMessage(
                                                ' User Delete Success!!! ');
                                            print(' User Delete Success!!! ');
                                          },
                                        );
                                      },
                                    ).catchError((onError) =>
                                            kToastSuccessMessage(' $onError '));
                                    final trueuser =
                                        await _auth.signInWithEmailAndPassword(
                                            email: SpUtil.getString('email')!,
                                            password:
                                                SpUtil.getString('password')!);
                                    if (trueuser != null)
                                      print(
                                          'SignInWithEmailAndPassword Success!!!');
                                  }
                                  List<String> gmail =
                                      allUser[index].gmail.split('@');
                                  await addUser(
                                    gmail[0],
                                    allUser[index].password,
                                    allUser[index].type,
                                    allUser[index].username,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Center(
                                    child: Text(
                                      'تعديل',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                    //CustomCard();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
