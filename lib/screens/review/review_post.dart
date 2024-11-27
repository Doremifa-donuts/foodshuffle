
import 'package:flutter/material.dart';
// データリスト
import '../../model/data_list.dart';

// レビュー書き込み画面
class ReviewWritePage extends StatelessWidget {
  // 選択された店舗情報を受け取る
  final ReviewStore store;

  const ReviewWritePage({required this.store, super.key});

  // レビュー書き込み画面を表示
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ページタイトルに店舗名を表示
        title: Text('レビューを書く: ${store.RestaurantName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 余白を設定
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 店舗名を表示
            Text(
              '店舗名: ${store.RestaurantName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8), // 縦方向の余白
            // 店舗住所を表示
            Text('住所: ${store.Address}'),
            const SizedBox(height: 16),
            // レビュー入力用のテキストフィールド
            const TextField(
              decoration: InputDecoration(
                labelText: 'レビュー内容', // ラベルテキスト
                border: OutlineInputBorder(), // 枠線を設定
              ),
              maxLines: 5, // 複数行入力
            ),
            const SizedBox(height: 16),
            // 保存ボタン
            ElevatedButton(
              onPressed: () {
                // 保存処理（後で実装）をここに記述
                Navigator.pop(context); // 保存後、前のページに戻る
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
