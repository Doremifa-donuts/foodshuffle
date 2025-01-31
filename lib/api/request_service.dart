import 'package:foodshuffle/api/request_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:foodshuffle/utils/errors.dart';
import 'package:flutter/material.dart';

class RequestService {
  static final RequestService _instance = RequestService._internal();

  // プライベートコンストラクタ
  RequestService._internal();
  // インスタンスを取得するためのファクトリコンストラクタ
  factory RequestService() {
    return _instance;
  }

  Future<dynamic> request(
      {required String endpoint,
      required HttpMethod method,
      required Map<String, String> headers,
      dynamic body}) async {
    final uri = Uri.parse(endpoint);
    try {
      late http.Response response;

      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: headers);
          break;
        case HttpMethod.post:
          response =
              await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.put:
          response =
              await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.delete:
          response =
              await http.delete(uri, headers: headers, body: jsonEncode(body));
          break;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        return decodedJson['Response']['Data'];
      } else {
        // HTTPのステータスコードをエラーに詰めてハンドリングできるようにする
        throw Errors('HTTP request exception', errorCode: response.statusCode);
      }
    } catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }
}
