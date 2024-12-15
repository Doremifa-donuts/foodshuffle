import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 画像ピッカーを使用
import '../../model/color.dart'; // カラー設定
import '../../model/images.dart'; // 画像パス設定

class ReviewWritePage extends StatefulWidget {
  const ReviewWritePage({Key? key}) : super(key: key);

  @override
  _ReviewWritePageState createState() => _ReviewWritePageState();
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
  void _submitReview() {
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

    // レビューが送信された後の処理
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('レビューが送信されました')),
    );
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
