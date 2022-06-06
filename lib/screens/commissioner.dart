import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/components/results_client_widget_ofCommissioner.dart';

import '../constants.dart';
import '../helper/users.dart';
import '../models/customer_model.dart';
import 'login_screen.dart';

class Commissioner extends StatefulWidget {
  static const String id = 'commissioner_screen';
  const Commissioner({Key? key}) : super(key: key);

  @override
  _CommissionerState createState() => _CommissionerState();
}

class _CommissionerState extends State<Commissioner> {
  bool searchMode = false;
  String inputChanged = '';
  String hint = 'أبحث';
  bool isLoading = false;
  late Timer _timer;
  bool search = true;
  final _auth = FirebaseAuth.instance;

  bool checkBoxValueOfName = false;
  bool checkBoxValueOfAddres = false;
  bool checkBoxValueOfPhone = false;
  bool checkBoxValueOfCode = false;
  bool save = false;

  timer() {
    _timer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
        print(isLoading);
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      });
    });
  }

  List<CustomerModel> allUser = [];
  List<CustomerModel> someUser = [];
  List<CustomerModel> searchUser = [];

  int count = 0;
  @override
  void initState() {
    loadingWidget = SizedBox.shrink();
    someUser.clear();
    allUser.clear();
    searchUser.clear();
    count = 0;

    super.initState();
  }

  late Widget loadingWidget;
  int counter_of_user = 0;
  int currentIndex = 0;

  getdata() async {
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });
    if (SpUtil.getString('id') == '-1') {
      someUser = (await Users().getUsersOfMandoobFromDataBase(
          SpUtil.getString('id'), count * 50, (count + 1) * 50))!;
      if (someUser.isNotEmpty) {
        for (int i = 0; i < someUser.length; i++) {
          if (someUser[i].id == '') {
            someUser[i].id = 0.toString();
            print(someUser[i].id);
            allUser.add(someUser[i]);
          } else if (someUser[i].username == '') {
            someUser[i].username = ' ';
            allUser.add(someUser[i]);
          } else if (someUser[i].address == '') {
            someUser[i].address = ' ';
            allUser.add(someUser[i]);
          } else if (someUser[i].phone == '') {
            someUser[i].phone = ' ';
            allUser.add(someUser[i]);
          } else if (someUser[i].mohafza == '') {
            someUser[i].mohafza = ' ';
            allUser.add(someUser[i]);
          } else if (someUser[i].fanniName == '') {
            someUser[i].fanniName = ' ';
            allUser.add(someUser[i]);
          } else if (someUser[i].Siana_Code == '') {
            someUser[i].Siana_Code = ' ';
            allUser.add(someUser[i]);
          } else if (someUser[i].date == '') {
            someUser[i].date = ' ';
            allUser.add(someUser[i]);
          } else {
            allUser.add(someUser[i]);
          }
        }
      }
      count++;
    } else {
      someUser = (await Users()
          .getUsersOfMandoobFromDataBase(SpUtil.getString('id'), 0, 0))!;
      allUser = someUser;
    }
    setState(() {
      loadingWidget = SizedBox.shrink();
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
      print(someUser.length);
      print(allUser.length);
      print(searchUser.length);
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
    });
  }

  getSearchDataByName(name) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });
    if (SpUtil.getString('id') == '-1') {
      someUser = (await Users()
          .getUsersFromDataBaseByName(SpUtil.getString('id'), name))!;
      if (someUser.isNotEmpty) {
        for (int i = 0; i < someUser.length; i++) {
          if (someUser[i].id == '') {
            someUser[i].id = 0.toString();
            searchUser.add(someUser[i]);
          } else if (someUser[i].username == '') {
            someUser[i].username = ' ';
            searchUser.add(someUser[i]);
          } else if (someUser[i].address == '') {
            someUser[i].address = ' ';
            searchUser.add(someUser[i]);
          } else if (someUser[i].phone == '') {
            someUser[i].phone = ' ';
            searchUser.add(someUser[i]);
          } else if (someUser[i].mohafza == '') {
            someUser[i].mohafza = ' ';
            searchUser.add(someUser[i]);
          } else if (someUser[i].fanniName == '') {
            someUser[i].fanniName = ' ';
            searchUser.add(someUser[i]);
          } else if (someUser[i].Siana_Code == '') {
            someUser[i].Siana_Code = ' ';
            searchUser.add(someUser[i]);
          } else if (someUser[i].date == '') {
            someUser[i].date = ' ';
            searchUser.add(someUser[i]);
          } else {
            searchUser.add(someUser[i]);
          }
        }
      }
      count++;
    } else {
      someUser = (await Users()
          .getUsersFromDataBaseByName(SpUtil.getString('id'), name))!;
      searchUser = someUser;
    }
    setState(() {
      loadingWidget = SizedBox.shrink();
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
      print(someUser.length);
      print(allUser.length);
      print(searchUser.length);
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
    });
  }

  getSearchDataByPhone(phone) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });
    someUser = (await Users()
        .getUsersFromDataBaseByPhone(SpUtil.getString('id'), phone))!;
    if (someUser.isNotEmpty) {
      for (int i = 0; i < someUser.length; i++) {
        if (someUser[i].id == '') {
          someUser[i].id = 0.toString();
          searchUser.add(someUser[i]);
        } else if (someUser[i].username == '') {
          someUser[i].username = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].address == '') {
          someUser[i].address = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].phone == '') {
          someUser[i].phone = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].mohafza == '') {
          someUser[i].mohafza = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].fanniName == '') {
          someUser[i].fanniName = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].Siana_Code == '') {
          someUser[i].Siana_Code = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].date == '') {
          someUser[i].date = ' ';
          searchUser.add(someUser[i]);
        } else {
          searchUser.add(someUser[i]);
        }
      }
    }
    count++;

    setState(() {
      loadingWidget = SizedBox.shrink();
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
      print(someUser.length);
      print(allUser.length);
      print(searchUser.length);
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
    });
  }

  getSearchDataByCode(code) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });
    someUser = (await Users()
        .getUsersFromDataBaseByCode(SpUtil.getString('id'), code))!;
    if (someUser.isNotEmpty) {
      for (int i = 0; i < someUser.length; i++) {
        if (someUser[i].id == '') {
          someUser[i].id = 0.toString();
          searchUser.add(someUser[i]);
        } else if (someUser[i].username == '') {
          someUser[i].username = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].address == '') {
          someUser[i].address = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].phone == '') {
          someUser[i].phone = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].mohafza == '') {
          someUser[i].mohafza = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].fanniName == '') {
          someUser[i].fanniName = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].Siana_Code == '') {
          someUser[i].Siana_Code = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].date == '') {
          someUser[i].date = ' ';
          searchUser.add(someUser[i]);
        } else {
          searchUser.add(someUser[i]);
        }
      }
    }
    count++;

    setState(() {
      loadingWidget = SizedBox.shrink();
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
      print(someUser.length);
      print(allUser.length);
      print(searchUser.length);
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
    });
  }

  getSearchDataByAddres(Addres) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });

    someUser = (await Users()
        .getUsersFromDataBaseByAddres(SpUtil.getString('id'), Addres))!;
    if (someUser.isNotEmpty) {
      for (int i = 0; i < someUser.length; i++) {
        if (someUser[i].id == '') {
          someUser[i].id = 0.toString();
          searchUser.add(someUser[i]);
        } else if (someUser[i].username == '') {
          someUser[i].username = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].address == '') {
          someUser[i].address = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].phone == '') {
          someUser[i].phone = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].mohafza == '') {
          someUser[i].mohafza = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].fanniName == '') {
          someUser[i].fanniName = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].Siana_Code == '') {
          someUser[i].Siana_Code = ' ';
          searchUser.add(someUser[i]);
        } else if (someUser[i].date == '') {
          someUser[i].date = ' ';
          searchUser.add(someUser[i]);
        } else {
          searchUser.add(someUser[i]);
        }
      }
    }
    count++;

    setState(() {
      loadingWidget = SizedBox.shrink();
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
      print(someUser.length);
      print(searchUser.length);
      print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SpUtil.getString('type') == 'ad'
                ? Icon(Icons.arrow_back_ios_rounded)
                : Icon(Icons.logout),
            onPressed: () async {
              if (SpUtil.getString('type') == 'ad') {
                Navigator.pop(context);
              } else {
                await _auth.signOut();
                await Users().signLogout(SpUtil.getString('email'));
                Navigator.pushReplacementNamed(context, LoginScreen.id);
                SpUtil.remove('email');
                SpUtil.remove('password');
                SpUtil.remove('type');
              }
            },
          ),
          brightness: Brightness.dark,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'المفوض',
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
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.0835,
                width: MediaQuery.of(context).size.width * 0.92,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          search = false;
                          searchMode = false;
                          inputChanged = '';
                        });
                        await getdata();
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: !search ? kSecondaryColor : kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(15)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Text(
                            ' كل العملاء ',
                            style: TextStyle(
                              color: !search ? Colors.white : kSecondaryColor,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          search = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: search ? kSecondaryColor : kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(15)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Text(
                            'بحث عن عميل',
                            style: TextStyle(
                              color: search ? Colors.white : kSecondaryColor,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !search,
                child: ResultsClientWidgetOFCommissioner(
                  allUser: allUser,
                ),
                replacement: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 10),
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 0.25,
                          child: Text(
                            'بحث بالأسم :',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          value: this.checkBoxValueOfName,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValueOfName = value!;
                              if (value == true) {
                                hint = 'أبحث بالأسم';
                                checkBoxValueOfCode = false;
                                checkBoxValueOfAddres = false;
                                checkBoxValueOfPhone = false;
                              }
                            });
                          },
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                        ),
                        Container(
                          width: width * 0.25,
                          child: Text(
                            'بحث بالهاتف :',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          value: this.checkBoxValueOfPhone,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValueOfPhone = value!;
                              if (value == true) {
                                hint = 'أبحث بالهاتف';
                                checkBoxValueOfCode = false;
                                checkBoxValueOfAddres = false;
                                checkBoxValueOfName = false;
                              }
                            });
                          },
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 0.25,
                          child: Text(
                            'بحث بالعنوان :',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          value: this.checkBoxValueOfAddres,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValueOfAddres = value!;
                              if (value == true) {
                                hint = 'أبحث بالعنوان';
                                checkBoxValueOfCode = false;
                                checkBoxValueOfPhone = false;
                                checkBoxValueOfName = false;
                              }
                            });
                          },
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                        ),
                        Container(
                          width: width * 0.25,
                          child: Text(
                            'بحث بالكود :',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          value: this.checkBoxValueOfCode,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValueOfCode = value!;
                              if (value == true) {
                                hint = 'أبحث بالكود';
                                checkBoxValueOfName = false;
                                checkBoxValueOfAddres = false;
                                checkBoxValueOfPhone = false;
                              }
                            });
                          },
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 15),
                      child: Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            onChanged: (val) {
                              inputChanged = val;
                            },
                            /*
                            onTap: () async {
                              checkBoxValueOfName = false;
                              checkBoxValueOfAddres = false;
                              checkBoxValueOfPhone = false;
                              checkBoxValueOfCode = false;
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return BodyDialog(
                                        body: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: width * 0.4,
                                                child: Text(
                                                  'بحث بالأسم :',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                              ),
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                value: this.checkBoxValueOfName,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkBoxValueOfName =
                                                        value!;
                                                    if (value == true) {
                                                      checkBoxValueOfCode =
                                                          false;
                                                      checkBoxValueOfAddres =
                                                          false;
                                                      checkBoxValueOfPhone =
                                                          false;
                                                    }
                                                  });
                                                },
                                                checkColor: Colors.green,
                                                activeColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: width * 0.4,
                                                child: Text(
                                                  'بحث بالهاتف :',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                              ),
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                value:
                                                    this.checkBoxValueOfPhone,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkBoxValueOfPhone =
                                                        value!;
                                                    if (value == true) {
                                                      checkBoxValueOfCode =
                                                          false;
                                                      checkBoxValueOfAddres =
                                                          false;
                                                      checkBoxValueOfName =
                                                          false;
                                                    }
                                                  });
                                                },
                                                checkColor: Colors.green,
                                                activeColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: width * 0.4,
                                                child: Text(
                                                  'بحث بالعنوان :',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                              ),
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                value:
                                                    this.checkBoxValueOfAddres,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkBoxValueOfAddres =
                                                        value!;
                                                    if (value == true) {
                                                      checkBoxValueOfCode =
                                                          false;
                                                      checkBoxValueOfPhone =
                                                          false;
                                                      checkBoxValueOfName =
                                                          false;
                                                    }
                                                  });
                                                },
                                                checkColor: Colors.green,
                                                activeColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: width * 0.4,
                                                child: Text(
                                                  'بحث بالكود :',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                              ),
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                value: this.checkBoxValueOfCode,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkBoxValueOfCode =
                                                        value!;
                                                    if (value == true) {
                                                      checkBoxValueOfName =
                                                          false;
                                                      checkBoxValueOfAddres =
                                                          false;
                                                      checkBoxValueOfPhone =
                                                          false;
                                                    }
                                                  });
                                                },
                                                checkColor: Colors.green,
                                                activeColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (checkBoxValueOfName ||
                                                      checkBoxValueOfAddres ||
                                                      checkBoxValueOfPhone ||
                                                      checkBoxValueOfCode ==
                                                          true) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.015),
                                                  margin: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: Colors.blue,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        offset: Offset(
                                                            0.0, 1.0), //(x,y)
                                                        blurRadius: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Center(
                                                    child: Text(
                                                      'تأكيد',
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.015),
                                                  margin: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: Colors.blue,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        offset: Offset(
                                                            0.0, 1.0), //(x,y)
                                                        blurRadius: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Center(
                                                    child: Text(
                                                      'ألغاء',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            },
                            */
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 25.0),
                              hintText: hint,
                              hintStyle: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 17,
                                  fontFamily: 'amiri-regular'),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () async {
                              if (inputChanged != "") {
                                if (checkBoxValueOfName) {
                                  await getSearchDataByName(inputChanged);
                                } else if (checkBoxValueOfPhone) {
                                  await getSearchDataByPhone(inputChanged);
                                } else if (checkBoxValueOfCode) {
                                  await getSearchDataByCode(inputChanged);
                                } else if (checkBoxValueOfAddres) {
                                  await getSearchDataByAddres(inputChanged);
                                  search = true;
                                } else {
                                  kToastErrorMessage('أختار نوع البحث');
                                }
                              } else {
                                kToastErrorMessage(
                                    'أكتب بيانات العميل الذي تبحث عنه');
                              }
                            },
                            child: Icon(
                              Icons.search,
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ]),
                    )
                  ]),
                ),
              ),
              Visibility(
                visible: searchUser.length > 0,
                child: ResultsClientWidgetOFCommissioner(
                  allUser: searchUser,
                ),
                replacement: Container(
                  height: 20.0,
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  child: Center(child: loadingWidget),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
