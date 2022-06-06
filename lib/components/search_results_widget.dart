import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/models/collection_model.dart';

import 'card.dart';
import 'custom_dialog.dart';

class SearchResultWidget extends StatefulWidget {
  String searchInput;
  bool saved;
  String dateOfCollection;
  String nameOfClient;
  String code;
  String custId;
  String cash;

  SearchResultWidget({
    required this.searchInput,
    required this.saved,
    required this.dateOfCollection,
    required this.nameOfClient,
    required this.code,
    required this.custId,
    required this.cash,
  });

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  bool save = false;

  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: widget.saved ? SpUtil.getInt('counter') : 1,
                itemBuilder: (context, index) {
                  return CustomCard(
                    onTape: () {},
                    color: Colors.white,
                    leading: widget.saved
                        ? SpUtil.getString('code${index + 1}')!
                        : widget.code,
                    lead: false,
                    title: widget.nameOfClient,
                    subtitle: widget.dateOfCollection,
                    trailing: widget.cash,
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

                      save = false;
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return CustomDialog(
                                collection: x,
                                search_from_collectors: false,
                                address: '',
                                CustID: widget.custId,
                                name: widget.nameOfClient,
                                date: widget.dateOfCollection,
                                code: widget.code,
                                Siana_Code: "",
                                cash: widget.cash,
                                maintenance: false,
                                saved: widget.saved,
                                saved_counter: index + 1,
                                client: false,
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
