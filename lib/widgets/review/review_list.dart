import 'package:flutter/material.dart';
// データリスト
import '../../model/data_list.dart';
// カラーパス
import '../../model/color.dart';
// レビュー書き込みページ
import '../../screens/review/review_post.dart';

// リスト画面
class ReviewList extends StatelessWidget {
  // データを受け取る
  final List<ReviewStore> stores;

  const ReviewList({super.key, required this.stores});

  // リスト表示
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 12, // スクロールバーの太さ
      radius: const Radius.circular(20), // スクロールバーの角丸
      child: ListView.separated(
        padding: const EdgeInsets.all(20), // リスト全体の余白
        separatorBuilder: (context, index) =>
            const SizedBox(height: 8), // 各アイテム間のスペース
        itemCount: stores.length, // アイテム数
        itemBuilder: (context, index) {
          return _buildCard(context, stores[index]); // 各アイテムをカードとして表示
        },
      ),
    );
  }

  // カード表示
  Widget _buildCard(BuildContext context, ReviewStore store) {
    return InkWell(
    onTap: () {
      // カードタップ時にレビュー書き込みページに遷移
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewWritePage(store: store),
        ),
      );
    },
    child: Card(
      // カードのカラー
      color: const Color(listColor),
      // カードの縁指定
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(134, 202, 233, 167), // 縁の色を指定
          width: 2, // 縁の太さ
        ),
        borderRadius: BorderRadius.circular(15), // カードの角を丸くする
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), // カードの内側の余白
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // 垂直方向中央寄せ
          children: [
            // ストアの画像を表示
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // 画像の角を丸くする
              child: Image.asset(
                store.Images,
                width: 120, // 画像の幅
                height: 100, // 画像の高さ
                fit: BoxFit.cover, // アスペクト比を維持しつつ画像を埋める
              ),
            ),
            const SizedBox(width: 12), // 画像とテキストの間のスペース
            // テキスト部分
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
                children: [
                  // 店名
                  Text(
                    store.RestaurantName,
                    style: const TextStyle(
                      fontSize: 16, // 店名の文字サイズ
                      fontWeight: FontWeight.bold, // 太字
                    ),
                    overflow: TextOverflow.ellipsis, // 長い場合は切り捨て
                  ),
                  const SizedBox(height: 4), // 上下の余白
                  // 電話番号
                  Text(
                    '電話番号: ${store.Tell}',
                    style: const TextStyle(
                      fontSize: 12, // 電話番号の文字サイズ
                      color: Colors.grey, // グレー色
                    ),
                  ),
                  const SizedBox(height: 4), // 上下の余白
                  // 住所
                  Text(
                    '住所: ${store.Address}',
                    style: const TextStyle(
                      fontSize: 14, // 住所の文字サイズ
                    ),
                    maxLines: 2, // 最大2行に制限
                    overflow: TextOverflow.ellipsis, // 長い場合は切り捨て
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
