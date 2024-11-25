import 'package:flutter/material.dart';
// データリスト
import '../../model/data_list.dart';
// カラーパス
import '../../model/color.dart';

// リスト画面
class ReviewList extends StatelessWidget {
  // データを受け取る
  final List<ReviewStore> stores;

  const ReviewList({Key? key, required this.stores}) : super(key: key);

  // リスト表示
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }

  // カード表示
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
