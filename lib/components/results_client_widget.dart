import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/components/body_dialog.dart';
import 'package:untitled/helper/collection.dart';
import 'package:untitled/models/collection_model.dart';
import 'package:untitled/models/tanbeahat_model.dart';

import '../constants.dart';
import '../models/customer_model.dart';
import 'card.dart';
import 'custom_dialog.dart';

class ResultsClientWidget extends StatefulWidget {
  List<CustomerModel> allUser = [];
  ResultsClientWidget({
    required this.allUser,
  });

  @override
  _ResultsClientWidgetState createState() => _ResultsClientWidgetState();
}

class _ResultsClientWidgetState extends State<ResultsClientWidget> {
  List<TanbeahatModel> Tanbeahat = [];
  int total_qest = 0;
  int total_cash = 0;
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
                        for (int i = 0; i < Tanbeahat.length; i++) {
                          total_qest =
                              total_qest + int.parse(Tanbeahat[i].Qest_Val);
                          print(Tanbeahat[i].State);
                          if (Tanbeahat[i].State != '1') {
                            total_cash =
                                total_cash + int.parse(Tanbeahat[i].Qest_Val);
                          }
                        }
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
                                          'أقساط العميل : ${widget.allUser[index].username}',
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
                                          'أجمالى الأقساط : $total_qest',
                                          style: kTextStyle2,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'المبلغ المتبقى : $total_cash',
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
                                      return CustomCard(
                                        onTape: () {},
                                        color: Tanbeahat[index].State == '1'
                                            ? Colors.lightGreen.shade400
                                            : Colors.red.shade400,
                                        leading: Tanbeahat[index].Qest_Val,
                                        lead: false,
                                        title: '',
                                        subtitle: '',
                                        trailing: Tanbeahat[index].Custname,
                                        onPressed: Tanbeahat[index].State ==
                                                    '1' ||
                                                SpUtil.getString('type') ==
                                                    'sup' ||
                                                SpUtil.getString('type') ==
                                                    'com'
                                            ? () {}
                                            : () async {
                                                CollectionModel x =
                                                    CollectionModel(
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
                                                          builder: (context,
                                                              setState) {
                                                        return CustomDialog(
                                                          collection: x,
                                                          search_from_collectors:
                                                              false,
                                                          address: '',
                                                          CustID:
                                                              Tanbeahat[index]
                                                                  .Cust_ID,
                                                          name: Tanbeahat[index]
                                                              .Custname,
                                                          date: Tanbeahat[index]
                                                              .Date,
                                                          code: Tanbeahat[index]
                                                              .Qest_ID,
                                                          cash: Tanbeahat[index]
                                                              .Qest_Val,
                                                          maintenance: false,
                                                          client: false,
                                                          saved: false,
                                                          saved_counter: 0,
                                                        );
                                                      });
                                                    });
                                              },
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
