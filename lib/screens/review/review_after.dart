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

// データベースを使用できるか
const bool useDatabase = false;

// プロバイダーの定義（データ取得を切り替え）
final reviewStoreAfterProvider = FutureProvider<List<ReviewStore>>((ref) async {
  if (useDatabase) {
    return fetchReviewStoresAfterFromDatabase();
  } else {
    return fetchDummyReviewStoresAfter();
  }
});

// ダミーデータ（データベースがない場合に使用する固定データ）
Future<List<ReviewStore>> fetchDummyReviewStoresAfter() async {
  return List.generate(
    10,
    (index) => ReviewStore(
      Images: 'images/store/store_2.png',
      RestaurantName: 'おひつごはん四六時中 ヨドバシ梅田店',
      Tell: '000-000-000',
      Address: '大阪府大阪市北区大深町1-1 ヨドバシ梅田 8F',
    ),
  );
}

// 本番用（データベースから取得する処理）
Future<List<ReviewStore>> fetchReviewStoresAfterFromDatabase() async {
  await Future.delayed(const Duration(seconds: 2)); // 仮の遅延
  return []; // データベースの中身を受け取る
}

// レビューのページ画面
class ReviewPage extends ConsumerWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // レビューのデータを取得
    final reviewStoreAfterAsyncValue = ref.watch(reviewStoreAfterProvider);
    return Scaffold(
      // header
      appBar: AppBar(
        title: const Text(
          'レビュー',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      // body
      body: reviewStoreAfterAsyncValue.when(
        data: (stores) {
          return Stack(
            children: [
              // 背景画像
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backImg),
                    fit: BoxFit.cover, // 画像を画面いっぱいに表示
                  ),
                ),
              ),
              // スクロール要素
              Scrollbar(
                thickness: 12, // スクロールバーの太さ
                radius: const Radius.circular(20), // スクロールバーの角を丸く
                child: ListView.separated(
                  padding: const EdgeInsets.all(20), // リストのパディングを指定
                  // リスト要素
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8), // 各リストアイテム間のスペース
                  itemCount: stores.length, // リストアイテムの数
                  // 各リストアイテム
                  itemBuilder: (context, index) {
                    return _buildCard(context, stores[index]);
                  },
                ),
              ),
              // footer
              const Positioned(
                bottom: -20, // フッターを少しだけ下に配置
                left: 0,
                right: 0,
                child: Footer(), // フッターウィジェット
              ),
            ],
          );
        },

        loading: () =>
            const Center(child: CircularProgressIndicator()), // 読み込み中
        error: (err, stack) => Center(child: Text('エラーが発生しました: $err')), // エラー時
      ),
    );
  }

  // Storeの情報を元に、各ストアの詳細情報を表示するカード
  Widget _buildCard(BuildContext context, ReviewStore store) {
    return Card(
      // カードのカラー
      color: const Color(listColor),
      // カードの縁指定
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(allListColor), // 縁の色を指定
          width: 2, // 縁の太さ
        ),
        borderRadius: BorderRadius.circular(15), // カードの角を丸くする
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), // カードの内側の余白
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃え
          children: [
            Row(
              children: [
                Column(
                  children: [
                    // ストアの画像を表示
                    Image.asset(
                      store.Images,
                      width: 120, // 画像の幅
                      height: 100, // 画像の高さ
                      fit: BoxFit.cover, // 画像のアスペクト比を維持
                    ),
                  ],
                ),
                const SizedBox(width: 8), // 画像と他の要素との空白
                Column(
                  children: [
                    // 店名を表示(長すぎるテキストは切り捨て)
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text(
                        store.RestaurantName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold), // 店名を太字で表示
                        overflow: TextOverflow.ellipsis, // 長すぎる場合は「...」で切り捨て
                      ),
                    ),
                    // 電話番号
                    Text(
                      '📞: ${store.Tell}',
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey), // 電話番号をグレー色で表示
                    ),
                    // 住所の表示（改行を許可して、長すぎるテキストは切り捨て）
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          200, // 画像の幅分を引いて残りの幅を使う
                      child: Text(
                        store.Address,
                        style: const TextStyle(fontSize: 14), // コメントの文字サイズ
                        maxLines: 2, // 最大2行に制限
                        overflow: TextOverflow.ellipsis, // 長すぎる場合は「...」で切り捨て
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
