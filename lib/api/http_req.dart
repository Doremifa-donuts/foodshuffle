import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodshuffle/utils/errors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { get, post, put, delete }

class Http {
  static Future<dynamic> request(
      {required String endpoint,
      required HttpMethod method,
      Map<String, dynamic>? body}) async {
    late http.Response response;

    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(endpoint);
    try {
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
