import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sp_util/sp_util.dart';
import 'package:untitled/components/results_client_widget.dart';
import 'package:untitled/helper/api_helper.dart';
import 'package:untitled/helper/collection.dart';
import 'package:untitled/helper/users.dart';
import 'package:untitled/models/collection_model.dart';
import 'package:untitled/models/customer_model.dart';
import 'package:untitled/models/sianat_model.dart';

import '../components/custom_dialog.dart';
import '../components/saved_collections.dart';
import '../constants.dart';
import '../models/tanbeahat_model.dart';
import 'login_screen.dart';

class Collectors extends StatefulWidget {
  static const String id = 'collectors_screen';

  @override
  _CollectorsState createState() => _CollectorsState();
}

class _CollectorsState extends State<Collectors> {
  late Timer _timer;
  late int counter;
  bool scan = false;
  bool searchMode = false;
  String inputChanged = '';
  String hint = 'أبحث';
  String code = '';
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  bool checkBoxValueOfName = false;
  bool checkBoxValueOfAddres = false;
  bool checkBoxValueOfPhone = false;
  bool checkBoxValueOfCode = false;
  bool save = false;
  List<CollectionModel> Collections = [];
  List<CollectionModel> AllCollections = [];
  List<CollectionModel> ConfirmedCollections = [];
  List<TanbeahatModel> Tanbeahat = [];
  List<SianatModel> Sianat = [];
  late List<String> data = ['', '', '', '', ''];
  @override
  bool search = false;
  Widget loadingWidget = SizedBox.shrink();
  int count = 0;
  List<CustomerModel> someUser = [];
  List<CustomerModel> searchUser = [];
  List<int> resultScanSavedData = [];

  timer() {
    _timer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
        searchMode = true;
      });
    });
  }

  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      counter = SpUtil.getInt('counter')!;
      AllCollections =
          (await Collection().getCollection(SpUtil.getString('id')))!;

      splitCollection();
      await ApiProvider.getConnection();
      if ((SpUtil.getBool('connectivity'))!) {
        resultScanSavedData = scanSavedData();
        for (int i = 0; i < resultScanSavedData.length; i++) {
          await getAndSendData(resultScanSavedData[i]);
        }
        for (int i = 0; i < counter; i++) {
          print('teeeeeeeeeeeeeeeeeeeeeeeeeeeeest$i');
          SpUtil.putInt('counter', SpUtil.getInt('counter')! - 1);
          SpUtil.remove('date$counter');
          SpUtil.remove('username$counter');
          SpUtil.remove('emlpoyename$counter');
          SpUtil.remove('qest_id$counter');
          SpUtil.remove('cust_code$counter');
          SpUtil.remove('qest_val$counter');
          SpUtil.remove('paid$counter');
          SpUtil.remove('notes$counter');
          SpUtil.remove('fann_ID$counter');
          SpUtil.remove('fanni_Nm$counter');
          SpUtil.remove('sent$counter');
        }

        print(resultScanSavedData.length);
      }
      setState(() {
        print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
        print(Collections.length);
        print(AllCollections.length);
        print(ConfirmedCollections.length);
        print(resultScanSavedData.length);
        print(SpUtil.getInt('counter')!);
        print('leeeeeeeeeeeeeeeeeeeeeeeeeeeeeength');
      });
    });
    // TODO: implement initState
    super.initState();
  }

  splitCollection() {
    ConfirmedCollections.clear();
    Collections.clear();
    for (int i = 0; i < AllCollections.length; i++) {
      if (SpUtil.getString('id') == '-1') {
        if (AllCollections[i].Confirmed == '1' &&
            AllCollections[i].Fanni_ID == '-1') {
          ConfirmedCollections.add(AllCollections[i]);
        } else if (AllCollections[i].Confirmed == '0' &&
            AllCollections[i].Fanni_ID == '-1') {
          Collections.add(AllCollections[i]);
        }
      } else {
        if (AllCollections[i].Confirmed == '1') {
          ConfirmedCollections.add(AllCollections[i]);
        } else if (AllCollections[i].Confirmed == '0') {
          Collections.add(AllCollections[i]);
        }
      }
    }
  }

  getSearchDataByName(name) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });

    someUser = (await Users().getUsersFromDataBaseByName(-1, name))!;
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

  getSearchDataByPhone(phone) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });

    someUser = (await Users().getUsersFromDataBaseByPhone(-1, phone))!;
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

  getSearchDataByCode(code) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });

    someUser = (await Users().getUsersFromDataBaseByCode(-1, code))!;
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

  getSearchDataByAddres(Addres) async {
    searchUser.clear();
    setState(() {
      loadingWidget = CupertinoActivityIndicator();
    });

    someUser = (await Users().getUsersFromDataBaseByAddres(-1, Addres))!;
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

  List<int> scanSavedData() {
    bool find = false;
    List<int> result = [];
    if (counter > 0) {
      if (Collections.length > 0) {
        for (int i = 0; i < counter; i++) {
          find = false;

          for (int x = 0; x < Collections.length && find == false; x++) {
            if (Collections[x].Qest_ID == SpUtil.getString('qest_id${i}')) {
              find = true;
            }
          }
          for (int y = 0; y < result.length && find == false; y++) {
            if (SpUtil.getString('qest_id${i}') ==
                SpUtil.getString('qest_id${result[y]}')) {
              find = true;
            }
          }
          if (!find) {
            result.add(i);
          }
        }
      } else {
        for (int z = 0; z < counter; z++) {
          result.add(z);
        }
      }
    }
    //Collections
    //counter
    return result;
  }

  getAndSendData(index) async {
    data = (await Collection()
        .getTanbeha((SpUtil.getString('qest_id${index}'))!))!;

    print('heeeeeeeeeeeeeeeer4');
    await Collection().addCollectionInDataBase(
      date: data[4],
      username: data[3],
      emlpoyename: SpUtil.getString('name'),
      qest_id: data[0],
      cust_code: data[2],
      qest_val: data[1],
      paid: SpUtil.getString('paid$index'),
      notes: SpUtil.getString('notes$index'),
      fann_ID: SpUtil.getString('id'),
      fanni_Nm: SpUtil.getString('name'),
      make_siana: SpUtil.getBool('make_siana$index'),
      takm: SpUtil.getBool('takm$index'),
      shamaaOla: SpUtil.getBool('shamaaOla$index'),
      otherSiana: SpUtil.getString('otherSiana$index'),
      costOfSiana: SpUtil.getString('costofcandl$index'),
      paid_CashOfSiana: SpUtil.getString('paid_Cash$index'),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      kToastErrorMessage('لم يتم قرأة ال QR Code');
      print('nothing return.');
    } else {
      setState(() async {
        CollectionModel x = CollectionModel(
            Other_Sianat: '',
            Notes: '',
            Qest_ID: '',
            Date: '',
            Takm: '',
            Cash: '',
            Shamaa_Ola: '',
            Confirmed: '',
            Fanni_ID: '',
            Qest_Val: '',
            Make_siana: '',
            Fanni_Name: '',
            Custname: '',
            Siana_val: '',
            Add_To_Salary: '',
            Cust_ID: '',
            Paid_For_siana: '');

        isLoading = true;
        data = (await Collection().getTanbeha(barcode))!;
        await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return CustomDialog(
                  collection: x,
                  search_from_collectors: false,
                  address: '',
                  CustID: data[2],
                  name: data[3],
                  date: data[4],
                  code: data[0],
                  cash: data[1],
                  maintenance: false,
                  client: false,
                  saved: false,
                  saved_counter: 0,
                );
              });
            });
        isLoading = false;
      });
      //13230

      setState(() async {
        isLoading = true;
        timer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.qr_code_scanner_rounded),
            onPressed: () async {
              setState(() async {
                scan = true;
                await _scan();
                searchMode = false;
                inputChanged = '';
              });
            }),
        appBar: AppBar(
          actions: [
            GFIconBadge(
              child: GFIconButton(
                padding: EdgeInsets.all(15),
                type: GFButtonType.transparent,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SavedCollections(
                        Collections: Collections,
                        Sianat: Sianat,
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                ),
              ),
              counterChild: GFBadge(
                size: 33,
                shape: GFBadgeShape.circle,
                child: Text((Collections.length + Sianat.length).toString()),
              ),
            ),
            GFIconBadge(
              child: GFIconButton(
                padding: EdgeInsets.all(15),
                type: GFButtonType.transparent,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SavedCollections(
                        Collections: ConfirmedCollections,
                        Sianat: [],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.play_for_work_rounded,
                  color: Colors.white,
                ),
              ),
              counterChild: GFBadge(
                size: 33,
                shape: GFBadgeShape.circle,
                child: Text((ConfirmedCollections.length).toString()),
              ),
            ),
            /*
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return CustomDialog(
                          search_from_collectors: false,
                          address: '',
                          CustID: '',
                          name: '',
                          date: '',
                          code: '',
                          cash: '',
                          maintenance: true,
                          client: false,
                          saved: false,
                          saved_counter: 0,
                        );
                      });
                    });
              },
            ),

             */
          ],
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
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 10),
                child: Column(
                  children: [
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
                      child: Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            autofocus: false,
                            keyboardType: TextInputType.multiline,
                            onChanged: (val) {
                              inputChanged = val;
                            },
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
                          padding: EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: () async {
                              if (inputChanged != "") {
                                if (checkBoxValueOfName) {
                                  await getSearchDataByName(inputChanged);
                                  search = true;
                                } else if (checkBoxValueOfPhone) {
                                  await getSearchDataByPhone(inputChanged);
                                  search = true;
                                } else if (checkBoxValueOfCode) {
                                  await getSearchDataByCode(inputChanged);
                                  search = true;
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
                  ],
                ),
              ),
              Container(
                height: 20.0,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: Center(child: loadingWidget),
              ),
              Visibility(
                visible: search,
                child: ResultsClientWidget(
                  allUser: searchUser,
                ),
                replacement: SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
