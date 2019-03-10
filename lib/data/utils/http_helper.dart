import 'package:http/http.dart' as http;
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class HttpHelper {
  static Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    Map<String, dynamic> responseBody;

    try {
      response = await _invoke(url, type,
          headers: headers, body: body, encoding: encoding);
    } catch (error) {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    List<dynamic> responseBody;

    try {
      response = await _invoke(url, type,
          headers: headers, body: body, encoding: encoding);
    } catch (error) {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<http.Response> _invoke(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }

      // check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }

      return response;
    } on http.ClientException {
      // handle any 404's
      rethrow;

      // handle no internet connection
    } on SocketException {
      throw Exception('Internet connection could not be established.');
    } catch (error) {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete }
