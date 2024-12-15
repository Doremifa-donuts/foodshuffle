import 'package:flutter/material.dart'; // Flutterのマテリアルデザイン用パッケージをインポート
import 'package:foodshuffle/model/data_list.dart'; // データモデルを使用するためのパッケージをインポート

// SwipeCardクラスはStatelessWidgetを継承
class SwipeCard extends StatelessWidget {
  final HomeStore store; // HomeStore型のプロパティを定義

  // コンストラクタでstoreを必須パラメータとして受け取る
  const SwipeCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    // カードデザインを構築
    return Card(
      elevation: 4.0, // カードの影の深さを設定
      margin: const EdgeInsets.only(
          top: 100.0, bottom: 180.0, left: 10.0, right: 10.0), // カードの外側の余白を設定

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // カードの角を丸くする
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左寄せで配置
        children: [
          // 画像を表示するためのウィジェット
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0)), // 画像の上部を丸くする
            child: Image.asset(
              store.Images, // 画像パスをstoreから取得
              height: 250, // 画像の高さを指定
              width: double.infinity, // 横幅を親要素いっぱいにする
              fit: BoxFit.cover, // 画像を切り取らずにフィットさせる
            ),
          ),
          // テキストとその他の情報を表示するウィジェット
          Padding(
            padding: const EdgeInsets.all(16.0), // 内側の余白を設定
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左寄せで配置
              children: [
                // 店舗名を表示するテキスト
                Text(
                  store.RestaurantName, // 店舗名をstoreから取得
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold), // 太字スタイルを設定
                ),
                const SizedBox(height: 8), // 上下の余白を追加
                // 住所を表示するテキスト
                Text(
                  store.Address, // 住所をstoreから取得
                  style: const TextStyle(
                      fontSize: 16, color: Colors.grey), // 色を灰色に設定
                ),
                const SizedBox(height: 8), // 上下の余白を追加
                // コメントを表示するテキスト
                Text(store.Comment,
                    style: const TextStyle(fontSize: 16)), // コメントを表示
                const SizedBox(height: 16), // 上下の余白を追加
                // 日付と「いいね」数を表示する行
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端揃えで配置
                  children: [
                    // 投稿日を表示
                    Text('投稿日: ${store.CreatedAt}',
                        style: const TextStyle(fontSize: 14)), // 投稿日を表示
                    // 「いいね」アイコンとその数を表示する行
                    Row(
                      children: [
                        const Icon(Icons.thumb_up, size: 18), // いいねアイコンを表示
                        const SizedBox(width: 4), // アイコンとテキストの間隔を設定
                        Text('${store.goods}',
                            style: const TextStyle(fontSize: 14)), // いいねの数を表示
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
