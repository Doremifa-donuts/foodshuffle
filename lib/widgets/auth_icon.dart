import 'package:flutter/material.dart';
import 'package:foodshuffle/api/urls.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthIcon extends StatefulWidget {
  final String imagePath;

  const AuthIcon({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  _AuthIconState createState() => _AuthIconState();
}

class _AuthIconState extends State<AuthIcon> {
  String? token;
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    _fetchImage(); // トークン取得と画像読み込み処理を呼び出し
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
        ? CircleAvatar(
            radius: 20,
            backgroundImage: MemoryImage(imageData!),
          )
        : const Icon(
            Icons.error,
            color: Colors.red,
            size: 20,
          );
  }
}
