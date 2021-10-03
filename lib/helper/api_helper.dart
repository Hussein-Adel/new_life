import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sp_util/sp_util.dart';

import '../constants.dart';
import '../helper/exceptions.dart';

class ApiProvider {
  static const Map<String, String> apiHeaders = {
    "Content-Type": "application/json",
    'Charset': 'utf-8',
    "Accept": "application/json, text/plain, */*",
    "X-Requested-With": "XMLHttpRequest",
  };
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  Future<dynamic> getRequest(String url, bool id, {var parms}) async {
    await getConnection();
    if ((SpUtil.getBool('connectivity'))!) {
      var response;
      Uri uri = Uri.parse("${ServerVars.Global_BASE_URL + url}");

      final requestUrl = uri.replace(queryParameters: parms);

      try {
        response = await http.get(requestUrl, headers: headers);
        print(response.statusCode);
      } catch (e) {
        print('\n $e');
        // if (e.response != null) response = e.response;
      }

      // Response Handling
      if (response.statusCode >= 200 && response.statusCode <= 302) {
        return id ? response.body : jsonDecode(response.body);
      } else {
        throw _apiExceptionGenerator(response.statusCode, response.body);
      }
    }
  }

  Future<dynamic> postRequest({required String endPoint, var body}) async {
    await getConnection();
    if ((SpUtil.getBool('connectivity'))!) {
      var response;

      var urlString = Uri.parse('${ServerVars.Global_BASE_URL}$endPoint');

      try {
        response = await http.post(
          urlString,
          body: jsonEncode(body),
        );
        print(response.statusCode);

        print(jsonDecode(response.body));
      } catch (e) {
        print('\n $e');
        //if (e.response != null) response = e.response;
      }

      // Response Handling
      if (response.statusCode >= 200 && response.statusCode <= 302) {
        return jsonDecode(response.body);
      } else {
        throw _apiExceptionGenerator(response.statusCode, response.body);
      }
    }
  }

  Future<dynamic> postRequestDio({required String endPoint, var body}) async {
    await getConnection();
    if ((SpUtil.getBool('connectivity'))!) {
      var response;
      var urlString = ServerVars.Global_BASE_URL + endPoint;

      try {
        var dio = new Dio();

        var formData = FormData.fromMap(body);

        response = await dio.post(
          urlString,
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
          ),
        );
        print(response.statusCode);
        print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh99');
        print(response);
      } catch (e) {
        print('\n $e');
        //if (e.response != null) response = e.response;
      }

      // Response Handling
      if (response.statusCode >= 200 && response.statusCode <= 302) {
        return response.statusCode;
      } else {
        String error = "";
        if (response.data['errors'] != null) {
          response.data['errors'].values.forEach((errorMessage) {
            error += ("\n${errorMessage[0]}\n");
          });

          Fluttertoast.showToast(
              msg: error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "حدث خطأ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
  }

  Exception _apiExceptionGenerator(int statusCode, var responseBody) {
    var decodedResponse = jsonDecode(responseBody);

    String error = "";

    if (decodedResponse['errors'] != null) {
      decodedResponse['errors'].values.forEach((errorMessage) {
        error += ("\n${errorMessage[0]}\n");
      });

      throw ApiException(
        code: statusCode,
        message: "",
        reason: (error),
      );
    } else {
      throw ApiException(
        code: statusCode,
        reason: "${decodedResponse['message']}",
        message: "",
      );
    }
  }

  static getConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
      kToastErrorMessage('No internet');
    }
    SpUtil.putBool('connectivity', result);
  }
}
