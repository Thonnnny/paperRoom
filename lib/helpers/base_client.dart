import 'dart:async';

import 'dart:convert';
import 'package:freshbuyer/helpers/exception_handler.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  static const int timeOutDuration = 35;
  bool internet = true;
  //GET
  Future<dynamic> get(String url, dynamic header) async {
    var uri = Uri.parse(url);
    try {
      var response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      internet = true;

      return _processResponse(response);
    } catch (e) {
      internet = false;

      // ignore: avoid_print
      print(ExceptionHandlers().getExceptionString(e));
    }
  }

  //POST
  Future<dynamic> post(String url, dynamic payloadObj, dynamic header) async {
    var uri = Uri.parse(url);
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      internet = true;
      print('******************this is response post***************');
      print(response.body);
      return _processResponse(response);
    } catch (e) {
      // ignore: avoid_print
      print(ExceptionHandlers().getExceptionString(e));
    }
  }

  //PATCH
  Future<dynamic> patch(String url, dynamic payloadObj, dynamic header) async {
    var uri = Uri.parse(url);
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .patch(uri, body: payload, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      internet = true;

      return _processResponse(response);
    } catch (e) {
      // ignore: avoid_print
      print(ExceptionHandlers().getExceptionString(e));
    }
  }

  //PUT
  Future<dynamic> put(String url, dynamic payloadObj, dynamic header) async {
    var uri = Uri.parse(url);
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .put(uri, body: payload, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      internet = true;

      return _processResponse(response);
    } catch (e) {
      // ignore: avoid_print
      print(ExceptionHandlers().getExceptionString(e));
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 400: //Bad request
      case 401: //Unauthorized
      case 403: //Forbidden
      case 404: //Resource Not Found
      case 500:
        var responseJson = response.body;
        return responseJson;
      default:
        throw FetchDataException('Algo salio mal ${response.statusCode}');
    }
  }
}
