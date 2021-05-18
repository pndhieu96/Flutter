// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter_fetch_data/networking/AppException.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3";

  Future<dynamic> get(String url) async {
    print('Api post, url $_baseUrl/$url');
    var responseJson;
    try{
      final response = await http.get(Uri.parse('$_baseUrl/$url'));
      print(response.statusCode);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }

    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}