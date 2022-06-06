import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/components/body_dialog.dart';
import 'package:untitled/components/card.dart';
import 'package:untitled/components/custom_dialog.dart';
import 'package:untitled/helper/collection.dart';
import 'package:untitled/models/collection_model.dart';

import '../constants.dart';

class CollectionScreen extends StatefulWidget {
  static const String id = 'collection_screen';
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<CollectionModel> Collections = [];
  List<List<String>> collectors = [];
  List<CollectionModel> Tanbeahat = [];
  List<CollectionModel> ConfirmedCollections = [];
  List<CollectionModel> CollectionsNotConfirmed = [];
  int countOfCollectors = 0;
  int totalOfCollections = 0;
  int countOfCollectorsConfirmed = 0;
  int totalOfCollectionsConfirmed = 0;
  bool confirm = true;
  bool showSpinner = false;
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Collections = (await Collection().getCollection(SpUtil.getString('id')))!;
      splitCollectors();
      setState(() {
        print(Collections.length);
        print(collectors.length);
      });
    });

    // TODO: implement initState
    super.initState();
  }

  int totalCollections(myCollections) {
    int total = 0;
    for (int i = 0; i < myCollections.length; i++) {
      total = total + int.parse(myCollections[i].Cash);
    }
    return total;
  }

  splitCollectors() {
    bool find = false;
    int count = 0;
    int total = 0;
    int countConfirmed = 0;
    int totalConfirmed = 0;

    countOfCollectors = 0;
    totalOfCollections = 0;
    countOfCollectorsConfirmed = 0;
    totalOfCollectionsConfirmed = 0;
    collectors.clear();
    for (int i = 0; i < Collections.length; i++) {
      find = false;
      count = 0;
      total = 0;
      countConfirmed = 0;
      totalConfirmed = 0;
      if (collectors.isNotEmpty) {
        for (int y = 0; y < collectors.length; y++) {
          if (collectors[y][3] == Collections[i].Fanni_ID) {
            find = true;
          }
        }
      }
      if (collectors.isEmpty || find == false) {
        for (int x = 0; x < Collections.length; x++) {
          if (Collections[i].Fanni_ID == Collections[x].Fanni_ID &&
              Collections[x].Confirmed == '0') {
            count++;
            total = total + int.parse(Collections[x].Cash);
            total = total + int.parse(Collections[x].Paid_For_siana);
          } else if (Collections[i].Fanni_ID == Collections[x].Fanni_ID &&
              Collections[x].Confirmed == '1') {
            countConfirmed++;
            totalConfirmed = totalConfirmed + int.parse(Collections[x].Cash);
            totalConfirmed =
                totalConfirmed + int.parse(Collections[x].Paid_For_siana);
          }
        }
      }
      if (!find) {
        countOfCollectors = countOfCollectors + count;
        totalOfCollections = totalOfCollections + total;
        countOfCollectorsConfirmed =
            countOfCollectorsConfirmed + countConfirmed;
        totalOfCollectionsConfirmed =
            totalOfCollectionsConfirmed + totalConfirmed;
        collectors.add([
          Collections[i].Fanni_Name,
          count.toString(),
          total.toString(),
          Collections[i].Fanni_ID,
          countConfirmed.toString(),
          totalConfirmed.toString(),
        ]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
            'التحصيلات والفنين',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
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
                          confirm = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: confirm ? kSecondaryColor : kPrimaryColor,
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
                            ' Confirm ',
                            style: TextStyle(
                              color: confirm ? Colors.white : kSecondaryColor,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          confirm = false;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: !confirm ? kSecondaryColor : kPrimaryColor,
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
                            ' Salary ',
                            style: TextStyle(
                              color: !confirm ? Colors.white : kSecondaryColor,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'عدد التحصيلات ',
                      style: kTextStyle.copyWith(fontSize: 19.5),
                    ),
                    Text(
                      ' ${confirm ? countOfCollectors : countOfCollectorsConfirmed} ',
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اجمالى التحصيلات :',
                      style: kTextStyle.copyWith(fontSize: 19.5),
                    ),
                    Text(
                      '${confirm ? totalOfCollections : totalOfCollectionsConfirmed}',
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
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: collectors.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      color: Colors.white,
                      leading: '',
                      lead: true,
                      title:
                          confirm ? collectors[index][2] : collectors[index][5],
                      subtitle:
                          confirm ? collectors[index][1] : collectors[index][4],
                      trailing: collectors[index][0],
                      onPressed: () async {
                        Tanbeahat = (await Collection()
                            .getCollection(collectors[index][3]))!;
                        if (collectors[index][3] == '-1') {
                          for (int y = 0; y < Tanbeahat.length; y++) {
                            if (Tanbeahat[y].Fanni_ID != '-1') {
                              Tanbeahat.removeAt(y);
                              y--;
                            }
                          }
                        }
                        ConfirmedCollections.clear();
                        CollectionsNotConfirmed.clear();
                        for (int i = 0; i < Tanbeahat.length; i++) {
                          if (Tanbeahat[i].Confirmed == '0' &&
                              Tanbeahat[i].Fanni_ID == collectors[index][3]) {
                            CollectionsNotConfirmed.add(Tanbeahat[i]);
                          } else {
                            ConfirmedCollections.add(Tanbeahat[i]);
                          }
                        }
                        setState(() {
                          print('teeeeeeeeeeeeeeeeeeeeeeeeeest1');
                          print(Tanbeahat.length);
                          print(ConfirmedCollections.length);
                          print(CollectionsNotConfirmed.length);
                          print('teeeeeeeeeeeeeeeeeeeeeeeeeest2');
                        });
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return ModalProgressHUD(
                                  inAsyncCall: showSpinner,
                                  child: BodyDialog(
                                    body: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              'تحصيلات الفني ${collectors[index][0]}',
                                              style: kTextStyle2,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_left_rounded,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          'أجمالى تحصيلات الفنى :  ${totalCollections(confirm ? CollectionsNotConfirmed : ConfirmedCollections)}',
                                          style: kTextStyle2,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
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
                                        itemCount: confirm
                                            ? CollectionsNotConfirmed.length
                                            : ConfirmedCollections.length,
                                        itemBuilder: (Context, index) {
                                          return CustomCard(
                                            onTape: () {},
                                            color: Colors.limeAccent.shade400,
                                            leading: confirm
                                                ? CollectionsNotConfirmed[index]
                                                    .Cash
                                                : ConfirmedCollections[index]
                                                    .Cash,
                                            lead: false,
                                            title: confirm
                                                ? CollectionsNotConfirmed[index]
                                                    .Fanni_Name
                                                : ConfirmedCollections[index]
                                                    .Fanni_Name,
                                            subtitle: confirm
                                                ? CollectionsNotConfirmed[index]
                                                    .Qest_Val
                                                : ConfirmedCollections[index]
                                                    .Qest_Val,
                                            trailing: confirm
                                                ? CollectionsNotConfirmed[index]
                                                    .Custname
                                                : ConfirmedCollections[index]
                                                    .Custname,
                                            onPressed: () async {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return CustomDialog(
                                                        collection: confirm
                                                            ? CollectionsNotConfirmed[
                                                                index]
                                                            : ConfirmedCollections[
                                                                index],
                                                        search_from_collectors:
                                                            false,
                                                        address: confirm
                                                            ? CollectionsNotConfirmed[
                                                                    index]
                                                                .Notes
                                                            : ConfirmedCollections[
                                                                    index]
                                                                .Notes,
                                                        CustID: confirm
                                                            ? CollectionsNotConfirmed[
                                                                    index]
                                                                .Cash
                                                            : ConfirmedCollections[
                                                                    index]
                                                                .Cash,
                                                        name: confirm
                                                            ? CollectionsNotConfirmed[
                                                                    index]
                                                                .Custname
                                                            : ConfirmedCollections[
                                                                    index]
                                                                .Custname,
                                                        date: confirm
                                                            ? CollectionsNotConfirmed[
                                                                    index]
                                                                .Date
                                                            : ConfirmedCollections[
                                                                    index]
                                                                .Date,
                                                        code: confirm
                                                            ? CollectionsNotConfirmed[
                                                                    index]
                                                                .Qest_ID
                                                            : ConfirmedCollections[
                                                                    index]
                                                                .Qest_ID,
                                                        Siana_Code:
                                                            "For Siana Code In User Model",
                                                        cash: confirm
                                                            ? CollectionsNotConfirmed[
                                                                    index]
                                                                .Qest_Val
                                                            : ConfirmedCollections[
                                                                    index]
                                                                .Qest_Val,
                                                        maintenance: false,
                                                        client: false,
                                                        saved: true,
                                                        saved_counter: 0,
                                                      );
                                                    });
                                                  });
                                            },
                                          );
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            showSpinner = true;
                                          });
                                          confirm
                                              ? await Collection()
                                                  .confirmCollection(
                                                      collectors[index][3])
                                              : await Collection()
                                                  .addTOSalaryCollection(
                                                      collectors[index][3]);
                                          setState(() {
                                            showSpinner = false;
                                            Navigator.pop(context);
                                          });
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
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: Center(
                                            child: Text(
                                              confirm ? ' تحصيل ' : ' محاسبة ',
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
                                );
                              });
                            });
                      },
                      onTape: () {},
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
      ),
    );
  }
}
