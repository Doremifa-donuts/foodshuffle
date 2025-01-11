import 'package:flutter/material.dart';
import 'package:foodshuffle/api/urls.dart';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthImage extends StatefulWidget {
  final String imagePath;
  final double height;
  final double width;

  const AuthImage(
      {Key? key,
      required this.imagePath,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  _AuthImageState createState() => _AuthImageState();
}

class _AuthImageState extends State<AuthImage> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    _fetchImage(); // 画像を取得する処理を呼び出し
  }

  Future<void> _fetchImage() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final response = await http.get(
        Uri.parse('${Urls.images}${widget.imagePath}'),
        headers: {
          'Authorization': 'Bearer $token', // トークンを適切に設定
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          imageData = response.bodyBytes; // 画像データを保存
        });
      } else {
        throw Exception('Failed to load image. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageData != null
        ? Image.memory(
            imageData!,
            height: widget.height, // 画像の高さを指定
            width: widget.width, // 横幅を親要素いっぱいにする
            fit: BoxFit.cover, // 画像を切り取らずにフィットさせる
          )
        : const Center(child: CircularProgressIndicator());
  }
}
