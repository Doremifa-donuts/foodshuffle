import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/widgets/footer.dart';

// ストアのデータクラス
// Storeクラスは、各ストアの情報（画像、名前、期限、メンバーアイコン）
class Store {
  final String storeImage; // ストア画像
  final String name; // ストア名
  final String deadline; // 提出
  final String memberIcon; // アイコン
  final String massage; // コメント

  // コンストラクタで必要なデータを受け取ります。
  Store({
    required this.storeImage,
    required this.name,
    required this.deadline,
    required this.memberIcon,
    required this.massage,
  });
}

class ArchivePage extends ConsumerStatefulWidget {
  const ArchivePage({super.key});

  @override
  ConsumerState<ArchivePage> createState() => _ArchivePage();
}

class _ArchivePage extends ConsumerState<ArchivePage> {
  final Random _random = Random();

  // 各ストアのデータをランダムに設定します。
  late final List<Store> stores = List.generate(
    10,
    (index) {
      // 1～12のランダムな画像を選択
      List<String> allIcons = List.generate(
        12,
        (iconIndex) => 'images/icon/member_${iconIndex + 1}.png',
      );
      // ランダムでアイコンを1つ選択
      String memberIcon = allIcons[_random.nextInt(12)]; // 12個の画像からランダムに選択

      return Store(
          storeImage: 'images/store/store_1.png', // ストア画像を固定（仮の画像パス）
          name: "ストア ${index + 1}",
          deadline: "12/${(index + 10) % 30 + 1}",
          memberIcon: memberIcon, // ランダムに選ばれたアイコン
          massage:
              'オムライスの卵がふわふわでした、ミネストローネも野菜がたくさん入っていておいしかったです。リピートしようと思います。');
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // アプリバー
      appBar: AppBar(
        title: const Text(
          'アーカイブ', // アーカイブページのタイトル
          style: TextStyle(fontWeight: FontWeight.bold), // 太字のスタイル
        ),
        backgroundColor: const Color(mainColor), // アプリバーの背景色（共通定義）
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(10), // カードの内側の余白
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃え
          children: [
            Row(
              children: [
                Column(
                  children: [
                    // 店名を表示
                    Text(
                      store.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // 店名を太字で表示
                    ),
                    const SizedBox(height: 8), // 店名と画像の間に余白
                    // ストアの画像を表示
                    Image.asset(
                      store.storeImage,
                      width: 120, // 画像の幅
                      height: 100, // 画像の高さ
                      fit: BoxFit.cover, // 画像のアスペクト比を維持
                    ),
                  ],
                ),
                const SizedBox(width: 8), // 店名とメンバーアイコンの間に余白
                Column(
                  children: [
                    Row(
                      children: [
                        // メンバーアイコンを表示
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8), // アイコンの右側に余白
                          child: CircleAvatar(
                            radius: 20, // アイコンの半径（大きさ）
                            backgroundImage:
                                AssetImage(store.memberIcon), // アイコン画像を設定
                          ),
                        ),
                        // 投稿日時を表示
                        Text(
                          '投稿日: ${store.deadline}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey), // 投稿日をグレー色で表示
                        ),
                      ],
                    ),
                    // コメントの表示（改行を許可して、長すぎるテキストは切り捨て）
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          200, // 画像の幅分を引いて残りの幅を使う
                      child: Text(
                        store.massage,
                        style: const TextStyle(fontSize: 14), // コメントの文字サイズ
                        maxLines: 3, // 最大3行に制限
                        overflow: TextOverflow.ellipsis, // 長すぎる場合は「...」で切り捨て
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
