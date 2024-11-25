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
import '../review/review_after.dart';

// データベースを使用できるか
const bool useDatabase = false;

// プロバイダーの定義（データ取得を切り替え）
final reviewStoreBeforeProvider = FutureProvider<List<ReviewStore>>((ref) async {
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
    // レビューのデータを取得
    final reviewStoreBeforeAsyncValue = ref.watch(reviewStoreBeforeProvider);
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
      body: reviewStoreBeforeAsyncValue.when(
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
             Column(
                children: [
                  // フィルターボタン（レビュー未／レビュー済）
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(textMainColor), // テキスト色
                          ),
                          child: const Text('レビュー未'),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ReviewAfterPage()),
                            );
                          }, // 現在無効
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(textMainColor), // テキスト色
                          ),
                          child: const Text('レビュー済'),
                        ),
                      ],
                    ),
                  ),
              
              // レビュー店舗一覧
            Expanded(
              child: Scrollbar(
                thickness: 12, // スクロールバーの太さ
                radius: const Radius.circular(20), // スクロールバーの角丸
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8), // 各アイテム間のスペース
                  itemCount: stores.length, // アイテム数
                  itemBuilder: (context, index) {
                    return _buildCard(context, stores[index]); // 各アイテムをカードとして表示
                  },
                ),
              ),
            ),
          
          ],),
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


// TODO: 未実装
// レビュー前後ボタン
// 郵便番号
// 電話icon
