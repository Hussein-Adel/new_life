import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/helper/collection.dart';
import 'package:untitled/models/sianat_model.dart';

import '../models/collection_model.dart';
import 'card.dart';
import 'custom_dialog.dart';

class CollectionsResultsWidget extends StatefulWidget {
  List<CollectionModel> Collections = [];
  List<SianatModel> Sianat = [];
  String searchInput;

  CollectionsResultsWidget({
    required this.Collections,
    required this.Sianat,
    required this.searchInput,
  });

  @override
  _CollectionsResultsWidgetState createState() =>
      _CollectionsResultsWidgetState();
}

class _CollectionsResultsWidgetState extends State<CollectionsResultsWidget> {
  int counter = 0;
  int saved_counter = -1;
  bool sent = false;
  Color getcolor(id) {
    sent = false;
    saved_counter = 0;
    counter = SpUtil.getInt('counter')!;
    if (counter == 0) {
      sent = true;
      saved_counter = 0;
      return Color(0xFFEEFF02).withOpacity(0.8);
    } else {
      for (int i = 1; i <= counter && sent == false; i++) {
        if (id == SpUtil.getString('qest_id$i')) {
          sent = true;
          saved_counter = 0;
        } else {
          sent = false;
          saved_counter = i;
        }
      }
      return sent ? Color(0xFFEEFF02) : Color(0xFFF44336);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchInput == 'Collections'
        ? SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.Collections.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.27,
                        child: CustomCard(
                          onTape: () {},
                          color: Colors.limeAccent.shade400,
                          leading: widget.Collections[index].Qest_ID,
                          lead: false,
                          title: widget.Collections[index].Fanni_Name,
                          subtitle: widget.Collections[index].Date,
                          trailing: widget.Collections[index].Custname,
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return CustomDialog(
                                      collection: widget.Collections[index],
                                      search_from_collectors: false,
                                      address: widget.Collections[index].Notes,
                                      CustID: widget.Collections[index].Cash,
                                      name: widget.Collections[index].Custname,
                                      date: widget.Collections[index].Date,
                                      code: widget.Collections[index].Qest_ID,
                                      Siana_Code:
                                          "For Siana Code In User Model",
                                      cash: widget.Collections[index].Qest_Val,
                                      maintenance: false,
                                      client: false,
                                      saved: true,
                                      saved_counter: saved_counter,
                                    );
                                  });
                                });
                          },
                        ),
                        secondaryActions: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.black45,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: IconSlideAction(
                              caption: ' تعديل ',
                              color: Colors.black45.withOpacity(0),
                              icon: Icons.update_outlined,
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return CustomDialog(
                                          collection: widget.Collections[index],
                                          search_from_collectors: false,
                                          address:
                                              widget.Collections[index].Notes,
                                          CustID:
                                              widget.Collections[index].Cash,
                                          name: widget
                                              .Collections[index].Custname,
                                          date: widget.Collections[index].Date,
                                          code:
                                              widget.Collections[index].Qest_ID,
                                          Siana_Code:
                                              "For Siana Code In User Model",
                                          cash: widget
                                              .Collections[index].Qest_Val,
                                          maintenance: true,
                                          client: false,
                                          saved: true,
                                          saved_counter: saved_counter,
                                        );
                                      });
                                    });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: IconSlideAction(
                              caption: ' حذف ',
                              color: Colors.red.withOpacity(0),
                              icon: Icons.delete,
                              onTap: () async {
                                await Collection().deleteCollection(
                                    widget.Collections[index].Qest_ID);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.Sianat.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        onTape: () {},
                        color: Colors.white,
                        leading: widget.Sianat[index].Cust_ID,
                        lead: false,
                        title: widget.Sianat[index].Fanni_Name,
                        subtitle: widget.Sianat[index].Date,
                        trailing: widget.Sianat[index].Custname,
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return CustomDialog(
                                    collection: widget.Collections[0],
                                    search_from_collectors: false,
                                    address: widget.Sianat[index].Notes,
                                    CustID: widget.Sianat[index].Cust_ID,
                                    name: widget.Sianat[index].Custname,
                                    date: widget.Sianat[index].Other_Siana,
                                    code: widget.Sianat[index].Cost,
                                    Siana_Code: "For Siana Code In User Model",
                                    cash: widget.Sianat[index].Paid_Cash,
                                    maintenance: true,
                                    client: false,
                                    saved: true,
                                    saved_counter:
                                        widget.Sianat[index].Shamaa_Ola,
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
          );
  }
}
