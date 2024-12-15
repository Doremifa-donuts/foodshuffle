import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 画像ピッカーを使用
import '../../model/color.dart'; // カラー設定
import '../../model/images.dart'; // 画像パス設定
import '../../model/data_list.dart'; // データモデル
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ReviewWritePage extends StatefulWidget {
  final ReviewStore reviewStore;
  const ReviewWritePage({required this.reviewStore, Key? key}) : super(key: key);

  @override
  _ReviewWritePageState createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  final TextEditingController _commentController = TextEditingController();
  List<XFile> _selectedImages = [];

  // 画像を選択する処理
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFile);
      });
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // 'auth_token'キーからトークンを取得
  }

  // レビュー送信処理（ダミー処理）
  void _submitReview() async{
    final comment = _commentController.text;

    if (_selectedImages.isEmpty || comment.isEmpty) {
      // 必須項目のチェック
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('画像と感想を入力してください')),
      );
      return;
    }
    // ここにレビュー投稿処理を実装することができます
    // 例えば、APIでデータを送信する処理など
  try {
    final token = await _getToken();

    if(token == null){
      throw Exception('token is null');
    }else {
      // httpリクエストでレビューを書き込む
      final request = http.MultipartRequest('POST', Uri.parse('${dotenv.env['API_URL']}/auth/users/reviews/post'));

      // リクエストヘッダー
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // リクエストボディ
      final Map<String, dynamic> data = {
        'RestaurantUuid': widget.reviewStore.RestaurantUuid,
        'Comment': _commentController.text,
      };
      request.fields['data'] = jsonEncode(data);
      // 画像を追加
      for(XFile image in _selectedImages){
        request.files.add( await http.MultipartFile.fromPath(
          'images[]',
          image.path,
        ));
      }
      // リクエストを送信
      final response = await request.send();

      // レスポンスを処理(JSONに変換)
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);

      switch(responseJson['Response']['Status']){
        case 'OK':
          //共有するレビューを指定(今回は投稿したレビューを指定)
          final shareReviewResponse = await http.put(
            Uri.parse('${dotenv.env['API_URL']}/auth/users/reviews/set'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'FirstReviewUuid': responseJson['Response']['Data']['ReviewUuid'],
            }),
          );
          final shareReviewResponseBody = jsonDecode(shareReviewResponse.body);
          if (shareReviewResponseBody['Response']['Status'] == 'OK') {
            // レビューが送信された後の処理
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('レビューが送信されました')),
            );
            break;
          }
        default:  //接続に失敗した場合
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('通信エラー'),
            ),
          );
          break;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('レビュー投稿'),
        backgroundColor: const Color(mainColor),
      ),
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 画像選択ボタン
                const Text(
                  '画像を選択:',
                  style: TextStyle(fontSize: 18, color: Color(textMainColor)),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedImages.isEmpty
                        ? const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            ),
                          )
                        : Image.file(
                            File(_selectedImages!.first.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // 感想入力
                const Text(
                  '感想:',
                  style: TextStyle(fontSize: 18, color: Color(textMainColor)),
                ),
                TextField(
                  controller: _commentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'お店の感想を入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // 投稿ボタン
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitReview,
                    child: const Text('レビューを投稿'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(mainColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
