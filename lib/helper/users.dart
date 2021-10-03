import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:untitled/constants.dart';

import '../helper/api_helper.dart';
import '../models/customer_model.dart';
import '../models/fanni_mandoob_model.dart';
import '../models/user_model.dart';
import 'exceptions.dart';

class Users {
  addUserInDataBase({
    @required Id,
    @required username,
    @required gmail,
    @required pass,
    @required type,
    @required login,
  }) async {
    try {
      var response = await ApiProvider()
          .postRequestDio(endPoint: ServerVars.addUser, body: {
        'id': Id,
        'username': username,
        'gmail': gmail,
        'pass': pass,
        'type': type,
        'login': login
      });
      print(response);
    } on SocketException catch (_) {} on ApiException catch (e) {
      print(e);
      kToastErrorMessage(e.toString());
    } catch (e) {
      print(e);
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<bool> addUserInFirebase(email, password, context, _auth) async {
    late final newUser;
    late bool ret;
    await ApiProvider.getConnection();
    if ((SpUtil.getBool('connectivity'))!) {
      try {
        newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          ret = true;
          //Navigator.pop(context);
          print('success1!!');
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Your user add successful!",
            text: " $email: الأسم  " + "\n" + " $password: الباسورد ",
          );
        }
      } catch (e) {
        ret = false;
        List<String> FirebaseAuthException = e.toString().split(']');
        Navigator.pop(context);

        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "User was not added successfully!",
          text: FirebaseAuthException[1],
        );
        print(e);
      }
    } else {
      ret = false;
    }
    return ret;
  }

  deletUser({@required gmail}) async {
    await ApiProvider.getConnection();
    if ((SpUtil.getBool('connectivity'))!) {
      try {
        var response = await ApiProvider()
            .getRequest("${ServerVars.deletUser}" + '?gmail=$gmail', true);
        print(response);
      } on SocketException catch (_) {} on ApiException catch (e) {
        kToastErrorMessage(e.toString());
      } catch (e) {
        kToastErrorMessage(ApiException.unknownErr);
      }
    }
  }

  Future<List<UserModel>?> getUserFromDataBase() async {
    try {
      var Users =
          await ApiProvider().getRequest("${ServerVars.getUsers}", false);

      List<UserModel> allUser = [];
      if (Users != null) {
        for (var data in Users) {
          allUser.add(UserModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<FanniMandoobModel>?> getMandoobFromDataBase() async {
    try {
      var Mandoobs =
          await ApiProvider().getRequest("${ServerVars.getMandoob}", false);

      List<FanniMandoobModel> allUser = [];
      if (Mandoobs != null) {
        for (var data in Mandoobs) {
          allUser.add(FanniMandoobModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print(e);
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<FanniMandoobModel>?> getFanniFromDataBase() async {
    try {
      var Fanni =
          await ApiProvider().getRequest("${ServerVars.getFanni}", false);
      List<FanniMandoobModel> allUser = [];
      if (Fanni != null) {
        for (var data in Fanni) {
          allUser.add(FanniMandoobModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<String>?> getLoginIDFromDataBase(gmail) async {
    try {
      var data = await ApiProvider()
          .getRequest("${ServerVars.getLoginId}" + '?gmail=$gmail', true);
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      var x = jsonDecode(data);
      print(x.toString() == '[]');
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');

      List<String> User = [];
      if (x.toString() != '[]') {
        var Id = jsonDecode(data)[0]['id'];
        var Name = jsonDecode(data)[0]['name'];
        var Login = jsonDecode(data)[0]['login'];
        User.add(Id.toString());
        User.add(Name.toString());
        User.add(Login.toString());
      }
      return User;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeest&&&');
      print(e);
      print('teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeest&&&');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  signLogin(mail) async {
    try {
      //CollectionModel
      var signLogin = await ApiProvider()
          .getRequest(ServerVars.signLogin + '?mail=$mail', true);
      print(signLogin);
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  signLogout(mail) async {
    try {
      //CollectionModel
      var signLogout = await ApiProvider()
          .getRequest(ServerVars.signLogout + '?mail=$mail', true);
      print(signLogout);
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<CustomerModel>?> getUsersOfMandoobFromDataBase(
      id, count, countR) async {
    try {
      var Users = await ApiProvider().getRequest(
          "${ServerVars.getUsersOfMandoob}" + '?MandoobID=$id,$countR,$count',
          false);

      List<CustomerModel> allUser = [];
      if (Users != null) {
        for (var data in Users) {
          allUser.add(CustomerModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');
      print(e);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<CustomerModel>?> getUsersFromDataBaseByName(id, name) async {
    try {
      print(id);
      print(name);
      var Users = await ApiProvider()
          .getRequest("${ServerVars.SearshByName}" + '?name=$id,$name', false);

      List<CustomerModel> allUser = [];
      if (Users != null) {
        for (var data in Users) {
          allUser.add(CustomerModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');
      print(e);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<CustomerModel>?> getUsersFromDataBaseByPhone(id, phone) async {
    try {
      print(id);
      print(phone);
      var Users = await ApiProvider().getRequest(
          "${ServerVars.searchByPhone}" + '?phone=$id,$phone', false);

      List<CustomerModel> allUser = [];
      if (Users != null) {
        for (var data in Users) {
          allUser.add(CustomerModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');
      print(e);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<CustomerModel>?> getUsersFromDataBaseByCode(id, code) async {
    try {
      print(id);
      print(code);
      var Users = await ApiProvider()
          .getRequest("${ServerVars.searchByCode}" + '?code=$id,$code', false);

      List<CustomerModel> allUser = [];
      if (Users != null) {
        for (var data in Users) {
          allUser.add(CustomerModel.fromJson(data));
        }
        return allUser;
      } else
        return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');
      print(e);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }

  Future<List<CustomerModel>?> getUsersFromDataBaseByAddres(id, addres) async {
    try {
      print(id);
      print(addres);
      var Users = await ApiProvider().getRequest(
          "${ServerVars.searchByAddres}" + '?addres=$id,$addres', false);

      List<CustomerModel> allUser = [];
      if (Users != null) {
        for (var data in Users) {
          allUser.add(CustomerModel.fromJson(data));
        }
      }
      return allUser;
    } on SocketException catch (_) {} on ApiException catch (e) {
      kToastErrorMessage(e.toString());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');
      print(e);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrror');

      kToastErrorMessage(ApiException.unknownErr);
    }
  }
}
