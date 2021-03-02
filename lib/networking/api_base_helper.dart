import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:topapp/networking/api_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://testapp.pec.ir/api/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException(
          'لطفا از متصل بودن اینترنت اطمینان حاصل فرمایید.');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json;",
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException(
          'لطفا از متصل بودن اینترنت اطمینان حاصل فرمایید.');
    }
    print('api post.');
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      if (response.body.isEmpty) {
        throw FetchDataException('پاسخ نامعتبر است');
      }
      var responseJson = json.decode(response.body.toString());
      return responseJson;

    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'خطا در برقراری ارتباط با سرور : ${response.statusCode}');
  }
}
