import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/widgets/footer.dart';
import '../model/color.dart';
import '../model/images.dart';

// レビュー時のストアのデータクラス
// Storeクラスは、各ストアの情報（画像、名前、電話番号、住所）
class Store {
  final String storeImage; // ストア画像
  final String name; // ストア名
  final String tel; // 電話番号
  final String address; // 住所

  // コンストラクタで必要なデータを受け取ります。
  Store({
    required this.storeImage,
    required this.name,
    required this.tel,
    required this.address,
  });
}

class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key});

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPage();
}

class _ReviewPage extends ConsumerState<ReviewPage> {
  // 各ストアのデータをランダムに設定します。
  late final List<Store> stores = List.generate(
    10,
    (index) {
      return Store(
        storeImage: 'images/store/store_1.png', // ストア画像を固定（仮の画像パス）
        name: "おにぎりごりちゃん 中崎町本店}",
        tel: "000-000-000",
        address: '大阪府大阪市北区中崎1丁目5-20 TKビル1階', // ランダムに選ばれたアイコン
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'レビュー',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(mainColor)),
      body: Stack(
        children: [
          // 背景画像を表示するためのContainer
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg), // 背景画像のパス（共通定義）
                fit: BoxFit.cover, // 画像を画面いっぱいに表示
              ),
            ),
          ),
          // スクロールバー
          Scrollbar(
            thickness: 12, // スクロールバーの太さ
            radius: const Radius.circular(20), // スクロールバーの角を丸く
            child: ListView.separated(
              padding: const EdgeInsets.all(20), // リストのパディングを指定
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 8), // 各リストアイテム間のスペース
              itemCount: stores.length, // リストアイテムの数
              itemBuilder: (context, index) =>
                  _buildCard(stores[index]), // 各カードをビルド
            ),
          ),
          // フッター部分を画面下部に配置
          const Positioned(
            bottom: -20, // フッターを少しだけ下に配置
            left: 0,
            right: 0,
            child: Footer(), // フッターウィジェット
          ),
        ],
      ),
    );
  }

  // Storeの情報を元に、各ストアの詳細情報を表示するカードをビルド
  Widget _buildCard(Store store) {
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
            Row(children: [
              Column(
                children: [
                  // ストアの画像を表示
                  Image.asset(
                    store.storeImage,
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
                      store.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold), // 店名を太字で表示
                      overflow: TextOverflow.ellipsis, // 長すぎる場合は「...」で切り捨て
                    ),
                  ),
                  // 電話番号
                  Text(
                    '📞: ${store.tel}',
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey), // 電話番号をグレー色で表示
                  ),

                  // 住所の表示（改行を許可して、長すぎるテキストは切り捨て）
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        200, // 画像の幅分を引いて残りの幅を使う
                    child: Text(
                      store.address,
                      style: const TextStyle(fontSize: 14), // コメントの文字サイズ
                      maxLines: 2, // 最大2行に制限
                      overflow: TextOverflow.ellipsis, // 長すぎる場合は「...」で切り捨て
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
