import 'package:flutter/material.dart';
// 動的に状態把握
import 'package:flutter_riverpod/flutter_riverpod.dart';
// footer 表示
import '../../widgets/footer.dart';
// カラー、画像パス
import '../../model/color.dart';
import '../../model/images.dart';
// 表示するデータを受け取るclass
import '../../model/data_list.dart';
// レビュー後のページ画面切り替え
import './review_after.dart';
// レビューリスト
import '../../widgets/review/review_list.dart';
// レビューのページ画面切り替えボタン
import '../../widgets/review/review_toggle_buttons.dart';

// データベースを使用できるか
const bool useDatabase = false;

// プロバイダーの定義（データ取得を切り替え）
final reviewStoreBeforeProvider =
    FutureProvider<List<ReviewStore>>((ref) async {
  if (useDatabase) {
    return fetchReviewStoresBeforeFromDatabase();
  } else {
    return fetchDummyReviewStoresBefore();
  }
});

// ダミーデータ（データベースがない場合に使用する固定データ）
Future<List<ReviewStore>> fetchDummyReviewStoresBefore() async {
  return List.generate(
    10,
    (index) => ReviewStore(
      Images: 'images/store/store_1.png',
      RestaurantName: 'おにぎりごりちゃん 中崎町本店',
      Tell: '000-000-000',
      Address: '大阪府大阪市北区中崎1丁目5-20 TKビル1階',
    ),
  );
}

// 本番用（データベースから取得する処理）
Future<List<ReviewStore>> fetchReviewStoresBeforeFromDatabase() async {
  await Future.delayed(const Duration(seconds: 2)); // 仮の遅延
  return []; // データベースの中身を受け取る
}

// レビューのページ画面
class ReviewBeforePage extends ConsumerWidget {
  const ReviewBeforePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // レビューのデータを非同期に取得
    final reviewStoreBeforeAsyncValue = ref.watch(reviewStoreBeforeProvider);

    return Scaffold(
      // アプリバー（ヘッダー）
      appBar: AppBar(
        title: const Text(
          'レビュー',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      // ボディ部分
      body: reviewStoreBeforeAsyncValue.when(
        data: (stores) {
          // データが取得できた場合
          return Stack(
            children: [
              // 背景画像を表示
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backImg),
                    fit: BoxFit.cover, // 画像を画面いっぱいに表示
                  ),
                ),
              ),
              // メインのコンテンツ（列）
              Column(
                children: [
                  // レビューボタン（未レビュー・レビュー済み）
                  ReviewToggleButtons(
                    onPendingPressed: () {
                      // レビュー後ページへ遷移
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewAfterPage(),
                        ),
                      );
                    }, // ここは無効化（未レビューのボタンは機能しない）
                    onReviewedPressed: () {},
                    // 未レビューのボタンスタイル
                    pendingButtonStyle: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      textStyle:
                          const TextStyle(fontFamily: 'uzura', fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // レビュー済みボタンのスタイル
                    reviewedButtonStyle: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'uzura',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  // レビューリストを表示（データを渡す）
                  Expanded(
                    child: ReviewList(stores: stores),
                  ),
                ],
              ),
              // フッター部分（画面の下に配置）
              const Positioned(
                bottom: -20, // フッターを少しだけ下に配置
                left: 0,
                right: 0,
                child: Footer(), // フッターウィジェット
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(), // 読み込み中のインジケータ
        ),
        error: (err, stack) => Center(
          child: Text('エラーが発生しました: $err'), // エラー時のメッセージ
        ),
      ),
    );
  }
}
