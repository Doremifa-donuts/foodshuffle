import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/utils/pref_helper.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:image_picker/image_picker.dart'; // 画像ピッカーを使用
import '../../model/color.dart'; // カラー設定
import 'package:http/http.dart' as http;

class ReviewWritePage extends StatefulWidget {
  final String restaurantUuid;
  const ReviewWritePage({required this.restaurantUuid, super.key});

  @override
  createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  final TextEditingController _commentController = TextEditingController();
  XFile? _selectedImage;

  // 画像を選択する処理
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  // レビュー送信処理（ダミー処理）
  // void _submitReview

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: 'レビュー投稿',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  child: _selectedImage == null
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.grey,
                          ),
                        )
                      : Image.file(
                          File(_selectedImage!.path),
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
                  filled: true, // 入力背景色を明示的に設定
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // 投稿ボタン
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final comment = _commentController.text;

                    if (_selectedImage == null || comment.isEmpty) {
                      // 必須項目のチェック
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('画像と感想を入力してください')),
                      );
                      return;
                    }

                    // ここにレビュー投稿処理を実装することができます
                    // 例えば、APIでデータを送信する処理など
                    // 保存処理（後で実装）をここに記述
                    if (comment.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('レビュー内容を入力してください'),
                        ),
                      );
                      return;
                    }
                    try {
                      final token = await PrefHelper().GetJWT();

                      // httpリクエストでレビューを書き込む
                      final request = http.MultipartRequest(
                          'POST', Uri.parse(Urls.postReview));

                      // リクエストヘッダー
                      request.headers.addAll({
                        'Authorization': 'Bearer $token',
                        'Accept': 'application/json',
                      });

                      // リクエストボディ
                      final Map<String, dynamic> data = {
                        'RestaurantUuid': widget.restaurantUuid,
                        'Comment': comment,
                      };
                      request.fields['jsondata'] = jsonEncode(data);
                      final bytes = await _selectedImage!.readAsBytes();

                      // request.files.add(
                      //     http.MultipartFile.fromBytes('images[]', bytes));
                      request.files.add(await http.MultipartFile.fromPath(
                          'images[]', _selectedImage!.path));
                      // リクエストを送信
                      final response = await request.send();
                      debugPrint('ステータス');
                      // // レスポンスを処理(JSONに変換)
                      final responseBody =
                          await response.stream.bytesToString();

                      final responseJson = jsonDecode(responseBody);
                      switch (responseJson['Response']['Status']) {
                        case 'OK':
                          //共有するレビューを指定(今回は投稿したレビューを指定)
                          final data = await RequestHandler.jsonWithAuth(
                              endpoint: Urls.setReview,
                              method: HttpMethod.put,
                              body: {
                                'FirstReviewUuid': responseJson['Response']
                                    ['Data']['ReviewUuid'],
                              });
                          Navigator.pop(context); // 保存後、前のページに戻る
                          break;

                        default: //接続に失敗した場合
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('通信エラー'),
                            ),
                          );
                          break;
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    }

                    // レビューが送信された後の処理
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('レビューが送信されました')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(mainColor),
                  ),
                  child: const Text('レビューを投稿'),
                ),
              ),
            ],
          ),
        ),
      ),
      // ],
      // ),
    );
  }
}
