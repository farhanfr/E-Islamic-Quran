import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:e_islamic_quran/api/api.dart';

class ApiProvider {
  final String _baseUrl = BASE_URL_QURAN;
  // Map<String, String> headers = {"Content-type": "application/json"};

  Future<dynamic> get(dynamic url, {Map<String, String> headers}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {dynamic body, Map<String, String> headers}) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + url), body: body, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {dynamic body, Map<String, String> headers}) async {
    var responseJson;
    try {
      final response =
          await http.put(Uri.parse(_baseUrl + url) , body: body, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {Map<String, String> headers}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  // Future<dynamic> postFile(String url,
  //     {Map<String, String> fields,
  //     List<http.MultipartFile> files,
  //     Map<String, String> headers}) async {
  //   var responseJson;
  //   var uri = Uri.parse(url);
  //   var request = http.MultipartRequest('POST', uri)
  //     ..fields.addAll(fields)
  //     ..files.addAll(files)
  //     ..headers.addAll(headers);
  //   try {
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     print("RESPONSE DARI PROVIDER : " +response.body);
  //     responseJson =response;
  //     // responseJson =_returnResponse(response);
  //   } on SocketException {
  //     throw NetworkException('Tidak ada koneksi internet');
  //   }
  //   return responseJson;
  // }

  dynamic _returnResponse(http.Response response) {
    var responseJson = json.decode(response.body.toString());
    final error = responseJson['message'];

    if (kDebugMode) {
      String responseJsonStr = response.body;
      String endpointPath = response.request.url.path;
      String endpointStr = response.request.url.toString();
      String endpointMethod = response.request.method;

      debugPrint('\x1B[31m\n->\x1B[0m');
      debugPrint('\x1B[37m[$endpointMethod] $endpointStr\x1B[0m');
      debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
    }

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        final statusCode = responseJson['code'].toString();
        final message = responseJson['message'];
        final String firstCode = statusCode[0];

        if (firstCode != "2") {
          switch (firstCode) {
            case "4":
              throw ClientException(message);
            case "5":
              throw ServerException(message);
            default:
              throw GeneralException(message);
          }
        }

        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw error;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
