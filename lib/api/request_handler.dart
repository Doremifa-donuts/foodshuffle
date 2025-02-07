import 'package:flutter/widgets.dart';
import 'package:foodshuffle/api/request_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { get, post, put, delete }

class RequestHandler {
  // リクエストを行うインスタンスの実態を取得する
  static final requestService = RequestService();

  // 認証なしで
  static Future<dynamic> jsonWithOutAuth(
      {required String endpoint,
      required HttpMethod method,
      Map<String, dynamic>? body}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      return await requestService.request(
          endpoint: endpoint, method: method, headers: headers, body: body);
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> jsonWithAuth({
    required String endpoint,
    required HttpMethod method,
    Map<String, dynamic>? body,
    // Map<String, String>? headers
  }) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      // ...headers,
    };
    try {
      return await requestService.request(
          endpoint: endpoint, method: method, headers: headers, body: body);
    } catch (e) {
      rethrow;
    }
  }

  // static Future<dynamic> multiPartForm({
  //   required String endpoint,
  //   required HttpMethod method,
  //   required Map<String, dynamic>? data,
  // }) async {
  //   final pref = await SharedPreferences.getInstance();
  //   final token = pref.getString('token');

  //   final headers = {
  //     'Content-Type': 'multipart/form-data',
  //     'Authorization': 'Bearer $token',
  //   };
  //   const reqData = {
  //     "jsondata":
  //   }
  //   return await requestService.request(
  //       endpoint: endpoint, method: method, headers: headers, body: data);
  // }
}
