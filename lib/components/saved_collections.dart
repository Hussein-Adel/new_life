import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/models/collection_model.dart';
import 'package:untitled/models/sianat_model.dart';

import 'collections_result_widget.dart';

class SavedCollections extends StatefulWidget {
  List<CollectionModel> Collections = [];
  List<SianatModel> Sianat = [];
  SavedCollections({required this.Collections, required this.Sianat});
  @override
  _SavedCollectionsState createState() => _SavedCollectionsState();
}

class _SavedCollectionsState extends State<SavedCollections> {
  @override
  int totalCollections() {
    int total = 0;
    for (int i = 0; i < widget.Collections.length; i++) {
      total = total + int.parse(widget.Collections[i].Cash);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '  التحصيلات ',
                        style: kTextStyle.copyWith(fontSize: 19.5),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 25,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Divider(
                    thickness: 0.8,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '  اجمالى التحصيلات :',
                        style: kTextStyle.copyWith(fontSize: 19.5),
                      ),
                      Text(
                        '${totalCollections()}',
                        style: kTextStyle.copyWith(fontSize: 19.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Divider(
                    thickness: 0.8,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: widget.Collections.length != 0
                      ? CollectionsResultsWidget(
                          Collections: widget.Collections,
                          searchInput: 'Collections',
                          Sianat: [],
                        )
                      : Center(
                          child: Text(
                            'There is no saved collections yet',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                ),
              ],
            )));
  }
}
