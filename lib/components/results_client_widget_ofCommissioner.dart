import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/body_dialog.dart';
import 'package:untitled/helper/collection.dart';
import 'package:untitled/models/collection_model.dart';
import 'package:untitled/models/tanbeahat_model.dart';

import '../constants.dart';
import '../models/customer_model.dart';
import 'card.dart';
import 'custom_dialog.dart';

class ResultsClientWidgetOFCommissioner extends StatefulWidget {
  List<CustomerModel> allUser = [];
  ResultsClientWidgetOFCommissioner({
    required this.allUser,
  });

  @override
  _ResultsClientWidgetOFCommissionerState createState() =>
      _ResultsClientWidgetOFCommissionerState();
}

class _ResultsClientWidgetOFCommissionerState
    extends State<ResultsClientWidgetOFCommissioner> {
  List<TanbeahatModel> Tanbeahat = [];
  int total_qest = 0;
  int total_cash = 0;
  int total_Inv = 0;
  int Mokadima = 0;
  List<int> Residuals = [];
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.allUser.length > 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: widget.allUser.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    onTape: () async {
                      Tanbeahat = (await Collection()
                          .getAllCollection(widget.allUser[index].id))!;
                      setState(() {
                        total_qest = 0;
                        total_cash = 0;
                        total_Inv = 0;
                        Mokadima = 0;
                        if (Tanbeahat.length > 0) {
                          Mokadima = int.parse(Tanbeahat[0].Mokadima);
                        }
                        for (int i = 0; i < Tanbeahat.length; i++) {
                          total_qest =
                              total_qest + int.parse(Tanbeahat[i].Qest_Val);
                          Residuals.add(total_qest);
                          print(Tanbeahat[i].State);
                          if (Tanbeahat[i].State != '1') {
                            total_cash =
                                total_cash + int.parse(Tanbeahat[i].Qest_Val);
                          }
                        }
                        total_Inv = total_qest + Mokadima;
                        print(total_cash);
                        print(total_qest);
                        print(Tanbeahat.length);
                      });
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return BodyDialog(
                                body: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'كشف حساب العميل : ${widget.allUser[index].username}',
                                          style: kTextStyle2,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'مقدم التعاقد : ${Mokadima}',
                                          style: kTextStyle2,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'اجمالى العقد : ${total_Inv}',
                                          style: kTextStyle2,
                                        ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'أجمالى المسدد : ${total_qest - total_cash}',
                                          style: kTextStyle2,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'المبلغ الغير مسدد : $total_cash',
                                          style: kTextStyle2,
                                        ),
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
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: Tanbeahat.length,
                                    itemBuilder: (Context, index) {
                                      int ResidualOfBian = total_Inv -
                                          Mokadima -
                                          Residuals[index];
                                      List<String> dateOfQest =
                                          Tanbeahat[index].Date.split('/');
                                      String Bian = ' قسط رقم ' +
                                          ' ${Tanbeahat[index].QestNumber} ' +
                                          'شهر ' +
                                          ' ${dateOfQest[1]} ' +
                                          'المتبقى  ' +
                                          ' $ResidualOfBian ';
                                      return Container(
                                        margin: EdgeInsets.only(
                                            top: 15, left: 10, right: 10),
                                        padding: EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Tanbeahat[index].State == '1'
                                              ? Colors.lightGreen.shade400
                                              : Colors.red.shade400,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.4),
                                                blurRadius: 5,
                                                offset: Offset(0, 2)),
                                          ],
                                        ),
                                        child: ExpansionTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            child: Text(
                                              '${Tanbeahat[index].QestNumber}',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          title: Text(
                                            Bian,
                                            style: TextStyle(
                                              fontSize: 19,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 19,
                                            ),
                                          ),
                                          trailing: Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 19,
                                            ),
                                          ),
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ميعاد القسط : ${Tanbeahat[index].Date}',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                  ),
                                                ),
                                                Text(
                                                  'المبلغ المطلوب للسداد: ${Tanbeahat[index].Cash}',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                  ),
                                                ),
                                                Text(
                                                  'حالة السداد : ${Tanbeahat[index].State == '1' ? 'تم تسديده' : 'لم يتم التسديد بعد'}',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            });
                          });
                    },
                    color: Colors.white,
                    leading: '',
                    lead: true,
                    title: widget.allUser[index].mandoobName,
                    subtitle: widget.allUser[index].fanniName,
                    trailing: widget.allUser[index].username,
                    onPressed: () async {
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

                      await showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return CustomDialog(
                                collection: x,
                                search_from_collectors: true,
                                address: widget.allUser[index].address,
                                CustID: widget.allUser[index].mohafza,
                                name: widget.allUser[index].username,
                                date: widget.allUser[index].date,
                                code: widget.allUser[index].fanniName,
                                cash: widget.allUser[index].phone,
                                maintenance: false,
                                client: true,
                                saved: false,
                                saved_counter:
                                    int.parse(widget.allUser[index].id),
                              );
                            });
                          });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
      replacement: Center(
        child: Text(
          'No search result is found',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
