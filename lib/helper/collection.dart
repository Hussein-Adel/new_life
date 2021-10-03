import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/models/sianat_model.dart';
import 'package:untitled/models/tanbeahat_model.dart';

import '../helper/api_helper.dart';
import '../models/collection_model.dart';
import 'exceptions.dart';

class Collection {
  addCollectionInDataBase({
    @required date,
    @required username,
    @required emlpoyename,
    @required qest_id,
    @required cust_code,
    @required qest_val,
    @required paid,
    @required notes,
    @required fann_ID,
    @required fanni_Nm,
    @required make_siana,
    @required takm,
    @required shamaaOla,
    @required otherSiana,
    @required costOfSiana,
    @required paid_CashOfSiana,
  }) async {
    bool? search = await seaech_Tahsela(qest_id);
    print(search);
    if (search == true) {
      kToastErrorMessage(' لقد تم تسديد هذا القسط من قبل ');
    } else {
      try {
        var response = await ApiProvider()
            .postRequestDio(endPoint: ServerVars.addcollection, body: {
          'date': date,
          'username': username,
          'emlpoyename': emlpoyename,
          'qest_id': qest_id,
          'cust_code': cust_code,
          'qest_val': qest_val,
          'paid': paid,
          'make_siana': make_siana,
          'siana_type': '0',
          'siana_val': costOfSiana,
          'paid_For_siana': paid_CashOfSiana,
          'mantika': '0',
          'notes': notes,
          'confirmed': 'false',
          'fann_ID': fann_ID,
          'fanni_Nm': fanni_Nm,
          'add_To_Salary': 'false',
          'takm': takm,
          'shamaa_Ola': shamaaOla,
          'other_Sianat': otherSiana,
        });
        print('teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeest170000');
        if (response == 200) {
          kToastSuccessMessage('تم تسديد القسط $qest_id بنجاح ');
        } else {
          kToastErrorMessage('لم يتم تسديد القسط حاول مرة اخرى');
        }
        print(response);

        // UserModel newComment = UserModel.fromJson(response['data']);
      } on SocketException catch (_) {} on ApiException catch (e) {
        kToastErrorMessage(e.toString());
      } catch (e) {
        kToastErrorMessage(ApiException.unknownErr);
      }
    }
  }

  addSianaInDataBase({
    @required date,
    @required fanniID,
    @required fanniName,
    @required custID,
    @required custName,
    @required takm,
    @required shamaaOla,
    @required otherSiana,
    @required cost,
    @required paid_Cash,
    @required notes,
  }) async {
    try {
      var response = await ApiProvider()
          .postRequestDio(endPoint: ServerVars.addSiana, body: {
        'move_date': date,
        'fanni_ID': fanniID,
        'fanni_Nm': fanniName,
        'cust_ID': custID,
        'cust_Nm': custName,
        'takm': takm,
        'shamaa_Ola': shamaaOla,
        'other_Siana': otherSiana,
        'cost': cost,
        'paid_Cash': paid_Cash,
        'notes': notes,
      });

      print('teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeest');
      print(response);
      // UserModel newComment = UserModel.fromJson(response['data']);
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<String>?> getTanbeha(id) async {
    try {
      var Tanbeha = await ApiProvider()
          .getRequest(ServerVars.getTanbeha + '?ID=$id', true);
      List<String> allCollection = [];
      if (Tanbeha != null) {
        var ID = jsonDecode(Tanbeha)[0]['ID'];
        var Cash = jsonDecode(Tanbeha)[0]['Cash'];
        var CustID = jsonDecode(Tanbeha)[0]['CustID'];
        var Custnm = jsonDecode(Tanbeha)[0]['Custnm'];
        var DateOfDue = jsonDecode(Tanbeha)[0]['DateOfDue'];
        allCollection.add(ID.toString());
        allCollection.add(Cash.toString());
        allCollection.add(CustID.toString());
        allCollection.add(Custnm.toString());
        allCollection.add(DateOfDue.toString());
        return allCollection;
      } else {
        allCollection.add(id.toString());
        allCollection.add(' ');
        allCollection.add(' ');
        allCollection.add(' ');
        allCollection.add(' ');
        return allCollection;
      }
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<CollectionModel>?> getCollection(id) async {
    try {
      //CollectionModel
      var Collection = await ApiProvider()
          .getRequest(ServerVars.getTahsealat + '?id=$id', false);
      List<CollectionModel> Collections = [];
      if (Collection != null) {
        for (var data in Collection) {
          Collections.add(CollectionModel.fromJson(data));
        }

        return Collections;
      } else {
        return Collections;
      }
    } on SocketException catch (_) {} on ApiException catch (e) {
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      print(e);
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      print(e);
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<TanbeahatModel>?> getAllCollection(code) async {
    try {
      //CollectionModel
      var Collection = await ApiProvider()
          .getRequest(ServerVars.getAllTanbeahat + '?code=$code', false);

      List<TanbeahatModel> Collections = [];
      print(Collection);
      if (Collection != null) {
        for (var data in Collection) {
          Collections.add(TanbeahatModel.fromJson(data));
        }
        return Collections;
      } else {
        return [];
      }
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<SianatModel>?> getSianat(id) async {
    try {
      //CollectionModel
      var Sianat = await ApiProvider()
          .getRequest(ServerVars.getSianat + '?id=$id', false);
      List<SianatModel> Collections = [];
      if (Sianat != null) {
        for (var data in Sianat) {
          Collections.add(SianatModel.fromJson(data));
        }

        return Collections;
      } else {
        return Collections;
      }
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  confirmCollection(id) async {
    try {
      //CollectionModel
      var confirm =
          await ApiProvider().getRequest(ServerVars.confirm + '?id=$id', true);
      print(confirm);
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  addTOSalaryCollection(id) async {
    try {
      //CollectionModel
      var confirm = await ApiProvider()
          .getRequest(ServerVars.addToSalary + '?id=$id', true);
      print(confirm);
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  deleteCollection(code) async {
    try {
      //CollectionModel
      var delete = await ApiProvider()
          .getRequest(ServerVars.deleteTahsela + '?id=$code', true);
      print(delete);
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<bool?> seaech_Tahsela(id) async {
    try {
      //CollectionModel
      var Collection = await ApiProvider()
          .getRequest(ServerVars.seaech_Tahsela + '?id=$id', true);
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      var x = jsonDecode(Collection);
      print(x.toString() == '[]');
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');

      if (x.toString() != '[]') {
        var ID = jsonDecode(Collection)[0]['Qest_ID'];
        print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIID');
        print(ID);
        print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIID');

        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {} on ApiException catch (e) {
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      print(e);
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      print(e);
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
      kToastErrorMessage(ApiException.unknownErr);
    }
  }
}
