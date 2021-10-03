import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/helper/api_helper.dart';

import '../constants.dart';
import '../helper/collection.dart';
import '../models/collection_model.dart';

class CustomDialog extends StatefulWidget {
  bool client;
  bool maintenance;
  bool saved;
  int saved_counter;
  String code;
  String CustID;
  String name;
  String cash;
  String date;
  String address;
  bool search_from_collectors;
  CollectionModel collection;

  CustomDialog(
      {required this.client,
      required this.maintenance,
      required this.saved,
      required this.saved_counter,
      required this.cash,
      required this.code,
      required this.CustID,
      required this.date,
      required this.name,
      required this.address,
      required this.search_from_collectors,
      required this.collection});
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool checkBoxValueOfFollowTheCandle = false;
  bool checkBoxValueOfCandle = false;
  bool checkBoxValueOfCandleKit = false;
  bool checkBoxValueOfPayment = true;
  late int counter;
  bool showSpinner = false;
  bool connectivity = true;
  String remarks = '';
  String repair = '';
  String priceOfCandl = '';
  String pricePayed = '';
  String pricePayedForCandl = '';
  String customerID = '';
  String customerName = '';
  bool sent = false;

  bool save = false;
  TextEditingController installmentController = new TextEditingController();
  TextEditingController CandleController = new TextEditingController();
  TextEditingController CandlePaidController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();
  TextEditingController repairController = new TextEditingController();
  TextEditingController customerNameController = new TextEditingController();
  TextEditingController customerIDController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await ApiProvider.getConnection();
      connectivity = SpUtil.getBool('connectivity')!;
    });

    installmentController.text = widget.cash;
    if (widget.saved && widget.maintenance) {
      remarksController.text = widget.address;
      remarks = widget.address;
      installmentController.text = widget.CustID;
      widget.date = widget.date.split(' ')[0];
      widget.collection.Make_siana == '1'
          ? checkBoxValueOfFollowTheCandle = true
          : checkBoxValueOfFollowTheCandle = false;
      widget.collection.Shamaa_Ola == '1'
          ? checkBoxValueOfCandle = true
          : checkBoxValueOfCandle = false;
      widget.collection.Takm == '1'
          ? checkBoxValueOfCandleKit = true
          : checkBoxValueOfCandleKit = false;
      priceOfCandl = widget.collection.Siana_val;
      CandleController.text = widget.collection.Siana_val;
      repairController.text = widget.collection.Other_Sianat;
      repair = widget.collection.Other_Sianat;
      CandlePaidController.text = widget.collection.Paid_For_siana;
      pricePayedForCandl = widget.collection.Paid_For_siana;
    } else if (widget.saved) {
      if (widget.saved_counter > 0) {
        sent = false;
        getdata();
      } else {
        sent = true;
        remarksController.text = widget.address;
        installmentController.text = widget.CustID;
        widget.date = widget.date.split(' ')[0];
        widget.collection.Make_siana == '1'
            ? checkBoxValueOfFollowTheCandle = true
            : checkBoxValueOfFollowTheCandle = false;
        widget.collection.Shamaa_Ola == '1'
            ? checkBoxValueOfCandle = true
            : checkBoxValueOfCandle = false;
        widget.collection.Takm == '1'
            ? checkBoxValueOfCandleKit = true
            : checkBoxValueOfCandleKit = false;
        priceOfCandl = widget.collection.Siana_val;
        CandleController.text = widget.collection.Siana_val;
        repairController.text = widget.collection.Other_Sianat;
        repair = widget.collection.Other_Sianat;
        CandlePaidController.text = widget.collection.Paid_For_siana;
        pricePayedForCandl = widget.collection.Paid_For_siana;
      }
    }
  }

  getdata() {
    widget.date = SpUtil.getString('date${widget.saved_counter}').toString();
    widget.name =
        SpUtil.getString('username${widget.saved_counter}').toString();
    SpUtil.getString('emlpoyename${widget.saved_counter}');
    widget.code = SpUtil.getString('qest_id${widget.saved_counter}').toString();
    SpUtil.getString('cust_code${widget.saved_counter}');
    widget.cash =
        SpUtil.getString('qest_val${widget.saved_counter}').toString();
    installmentController.text =
        SpUtil.getString('paid${widget.saved_counter}').toString();
    remarksController.text =
        SpUtil.getString('notes${widget.saved_counter}').toString();
    SpUtil.getString('fann_ID${widget.saved_counter}');
    SpUtil.getString('fanni_Nm${widget.saved_counter}');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Dialog(
          insetPadding:
              EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.client
                    ? [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'أسم العميل : ${widget.name}',
                                style: kTextStyle2,
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'الكود : ${widget.saved_counter} ',
                          style: kTextStyle2,
                        ),
                        Text(
                          'العنوان : ${widget.address}',
                          style: kTextStyle2,
                        ),
                        Text(
                          'الهاتف : ${widget.cash}',
                          style: kTextStyle2,
                        ),
                        Text(
                          'المحافطة  : ${widget.CustID} ',
                          style: kTextStyle2,
                        ),
                        Text(
                          'الفني  : ${widget.code} ',
                          style: kTextStyle2,
                        ),
                        Text(
                          'تاريخ التعاقد  :  ${widget.date}',
                          style: kTextStyle2,
                        ),
                      ]
                    : [
                        Row(
                          children: [
                            Text(
                              'أسم العميل : ',
                              style: kTextStyle,
                            ),
                            Text(
                              widget.name,
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'تاريخ التسديد :',
                              style: kTextStyle,
                            ),
                            Text(
                              widget.date,
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'قيمة القسط :',
                              style: kTextStyle,
                            ),
                            Text(
                              widget.cash,
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'كود القسط :',
                              style: kTextStyle,
                            ),
                            Text(
                              widget.code,
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'المبلغ المدفوع : ',
                                style: kTextStyle,
                              ),
                              Container(
                                width: width * 0.35,
                                child: TextField(
                                  decoration: sent
                                      ? kTextFieldDecoration.copyWith(
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                        )
                                      : kTextFieldDecoration,
                                  readOnly: sent,
                                  controller: installmentController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    pricePayed = val;
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
                                'الملاحظات : ',
                                style: kTextStyle,
                              ),
                              Container(
                                width: width * 0.35,
                                child: TextField(
                                  readOnly: sent,
                                  controller: remarksController,
                                  decoration: sent
                                      ? kTextFieldDecoration.copyWith(
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                        )
                                      : kTextFieldDecoration,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: (val) {
                                    remarks = val;
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
                                'أضافة صيانة : ',
                                style: kTextStyle,
                              ),
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                value: this.checkBoxValueOfFollowTheCandle,
                                onChanged: (value) {
                                  setState(() {
                                    sent
                                        ? checkBoxValueOfFollowTheCandle =
                                            checkBoxValueOfFollowTheCandle
                                        : checkBoxValueOfFollowTheCandle =
                                            value!;
                                    if (value == false) {
                                      priceOfCandl = '';
                                      CandleController.text = '';
                                      repairController.text = '';
                                      repair = '';
                                      CandlePaidController.text = '';
                                      pricePayedForCandl = '';
                                      checkBoxValueOfCandle = false;
                                      checkBoxValueOfCandleKit = false;
                                    }
                                  });
                                },
                                checkColor: Colors.green,
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        checkBoxValueOfFollowTheCandle
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'متابعة الشمع : ',
                                          style: kTextStyle,
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              value: this.checkBoxValueOfCandle,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (!sent ||
                                                      widget.maintenance) {
                                                    checkBoxValueOfCandle =
                                                        value!;
                                                    if (value == true) {
                                                      checkBoxValueOfCandleKit =
                                                          false;
                                                      CandleController.text =
                                                          '20';
                                                      CandlePaidController
                                                          .text = '20';
                                                      priceOfCandl = '20';
                                                      pricePayedForCandl = '20';
                                                    } else {
                                                      CandleController.text =
                                                          '';
                                                      CandlePaidController
                                                          .text = '';
                                                      priceOfCandl = '';
                                                      pricePayedForCandl = '';
                                                    }
                                                  }
                                                });
                                              },
                                              checkColor: Colors.green,
                                              activeColor: Colors.white,
                                            ),
                                            Text(
                                              'شمعة أولي',
                                              style: kTextStyle,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              value:
                                                  this.checkBoxValueOfCandleKit,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (!sent ||
                                                      widget.maintenance) {
                                                    checkBoxValueOfCandleKit =
                                                        value!;
                                                    if (value == true) {
                                                      checkBoxValueOfCandle =
                                                          false;
                                                      CandleController.text =
                                                          '90';
                                                      CandlePaidController
                                                          .text = '90';
                                                      priceOfCandl = '90';
                                                      pricePayedForCandl = '90';
                                                    } else {
                                                      CandleController.text =
                                                          '';
                                                      CandlePaidController
                                                          .text = '';
                                                      priceOfCandl = '';
                                                      pricePayedForCandl = '';
                                                    }
                                                  }
                                                });
                                              },
                                              checkColor: Colors.green,
                                              activeColor: Colors.white,
                                            ),
                                            Text(
                                              ' طقم شمع ',
                                              style: kTextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'حساب الشمع : ',
                                          style: kTextStyle,
                                        ),
                                        Container(
                                          width: width * 0.35,
                                          child: TextField(
                                            controller: CandleController,
                                            decoration: sent
                                                ? kTextFieldDecoration.copyWith(
                                                    border:
                                                        OutlineInputBorder(),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.0),
                                                    ),
                                                  )
                                                : kTextFieldDecoration,
                                            readOnly: sent,
                                            keyboardType: TextInputType.number,
                                            onChanged: (val) {
                                              priceOfCandl = val;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'صيانات أخري : ',
                                          style: kTextStyle,
                                        ),
                                        Container(
                                          width: width * 0.35,
                                          child: TextField(
                                            controller: repairController,
                                            decoration: sent
                                                ? kTextFieldDecoration.copyWith(
                                                    border:
                                                        OutlineInputBorder(),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.0),
                                                    ),
                                                  )
                                                : kTextFieldDecoration,
                                            readOnly: sent,
                                            keyboardType:
                                                TextInputType.multiline,
                                            onChanged: (val) {
                                              repair = val;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'المدفوع للصيانة : ',
                                          style: kTextStyle,
                                        ),
                                        Container(
                                          width: width * 0.35,
                                          child: TextField(
                                            controller: CandlePaidController,
                                            decoration: sent
                                                ? kTextFieldDecoration.copyWith(
                                                    border:
                                                        OutlineInputBorder(),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.0),
                                                    ),
                                                  )
                                                : kTextFieldDecoration,
                                            readOnly: sent,
                                            keyboardType: TextInputType.number,
                                            onChanged: (val) {
                                              pricePayedForCandl = val;
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
                                ],
                              )
                            : SizedBox(),
                        sent
                            ? SizedBox()
                            : Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        showSpinner = true;
                                        pricePayed == ''
                                            ? pricePayed =
                                                installmentController.text
                                            : pricePayed = pricePayed;
                                        priceOfCandl == ''
                                            ? priceOfCandl =
                                                CandleController.text
                                            : priceOfCandl = priceOfCandl;

                                        pricePayedForCandl == ''
                                            ? pricePayedForCandl =
                                                CandlePaidController.text
                                            : pricePayedForCandl =
                                                pricePayedForCandl;
                                      });

                                      if (widget.maintenance) {
                                        await Collection()
                                            .deleteCollection(widget.code);

                                        DateTime now = new DateTime.now();
                                        String date =
                                            '${now.year.toString()} / ${now.month.toString()} / ${now.day.toString()}';
                                        await Collection()
                                            .addCollectionInDataBase(
                                          date: date,
                                          username: widget.name,
                                          emlpoyename: SpUtil.getString('name'),
                                          qest_id: widget.code,
                                          cust_code: widget.CustID,
                                          qest_val: widget.cash,
                                          paid: pricePayed,
                                          notes: remarks,
                                          fann_ID: SpUtil.getString('id'),
                                          fanni_Nm: SpUtil.getString('name'),
                                          make_siana:
                                              checkBoxValueOfFollowTheCandle,
                                          takm: checkBoxValueOfCandleKit,
                                          shamaaOla: checkBoxValueOfCandle,
                                          otherSiana: repair,
                                          costOfSiana: priceOfCandl,
                                          paid_CashOfSiana: pricePayedForCandl,
                                        );
                                      } else {
                                        DateTime now = new DateTime.now();
                                        String date =
                                            '${now.year.toString()} / ${now.month.toString()} / ${now.day.toString()}';

                                        counter = SpUtil.getInt('counter')!;
                                        SpUtil.putInt('counter', counter + 1);
                                        SpUtil.putString('date$counter', date);
                                        SpUtil.putString(
                                            'username$counter', widget.name);
                                        SpUtil.putString('emlpoyename$counter',
                                            (SpUtil.getString('name'))!);
                                        SpUtil.putString(
                                            'qest_id$counter', widget.code);
                                        SpUtil.putString(
                                            'cust_code$counter', widget.CustID);
                                        SpUtil.putString(
                                            'qest_val$counter', widget.cash);
                                        SpUtil.putString(
                                            'paid$counter', pricePayed);
                                        SpUtil.putString(
                                            'notes$counter', remarks);
                                        SpUtil.putString('fann_ID$counter',
                                            (SpUtil.getString('id'))!);
                                        SpUtil.putString('fanni_Nm$counter',
                                            (SpUtil.getString('name'))!);
                                        SpUtil.putBool('sent$counter', false);

                                        SpUtil.putBool('make_siana$counter',
                                            checkBoxValueOfFollowTheCandle);
                                        SpUtil.putBool('takm$counter',
                                            checkBoxValueOfCandleKit);
                                        SpUtil.putBool('shamaaOla$counter',
                                            checkBoxValueOfCandle);
                                        SpUtil.putString(
                                            'otherSiana$counter', repair);
                                        SpUtil.putString('costofcandl$counter',
                                            priceOfCandl);
                                        SpUtil.putString('paid_Cash$counter',
                                            pricePayedForCandl);

                                        await Collection()
                                            .addCollectionInDataBase(
                                          date: date,
                                          username: widget.name,
                                          emlpoyename: SpUtil.getString('name'),
                                          qest_id: widget.code,
                                          cust_code: widget.CustID,
                                          qest_val: widget.cash,
                                          paid: pricePayed,
                                          notes: remarks,
                                          fann_ID: SpUtil.getString('id'),
                                          fanni_Nm: SpUtil.getString('name'),
                                          make_siana:
                                              checkBoxValueOfFollowTheCandle,
                                          takm: checkBoxValueOfCandleKit,
                                          shamaaOla: checkBoxValueOfCandle,
                                          otherSiana: repair,
                                          costOfSiana: priceOfCandl,
                                          paid_CashOfSiana: pricePayedForCandl,
                                        );
                                      }
                                      setState(() {
                                        showSpinner = false;
                                        save = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.015),
                                      margin: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          widget.maintenance
                                              ? 'تعديل'
                                              : connectivity
                                                  ? 'تسديد'
                                                  : ' حفظ ',
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
                                          MediaQuery.of(context).size.width *
                                              0.015),
                                      margin: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                              )
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
