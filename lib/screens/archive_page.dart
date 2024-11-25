import 'package:flutter/material.dart';
// ランダム関数
import 'dart:math';
// 動的に状態把握
import 'package:flutter_riverpod/flutter_riverpod.dart';
// footer 表示
import '../widgets/footer.dart';
// カラー、画像パス
import '../model/color.dart';
import '../model/images.dart';
// 表示するデータを受け取るclass
import '../model/data_list.dart';

// データベースを使用できるか
const bool useDatabase = false;
// ランダム関数
final Random _random = Random();

// プロバイダーの定義（データ取得を切り替え）
final archiveStoreProvider = FutureProvider<List<ArchiveStore>>((ref) async {
  if (useDatabase) {
    return fetchArchiveStoresFromDatabase();
  } else {
    return fetchDummyArchiveStores();
  }
});

// ダミーデータ（データベースがない場合に使用する固定データ）
Future<List<ArchiveStore>> fetchDummyArchiveStores() async {
  return List.generate(
    10,
    (index) {
      // 1～12のランダムな画像を選択
      List<String> allIcons = List.generate(
        12,
        (iconIndex) => 'images/icon/member_${iconIndex + 1}.png',
      );
      // ランダムでアイコンを1つ選択
      String memberIcon = allIcons[_random.nextInt(12)]; // 12個の画像からランダムに選択

      return ArchiveStore(
          Images: 'images/store/store_1.png', // ストア画像を固定（仮の画像パス）
          RestaurantName: "ストア ${index + 1}",
          CreatedAt: "12/${(index + 10) % 30 + 1}",
          Icon: memberIcon, // ランダムに選ばれたアイコン
          Comment:
              'オムライスの卵がふわふわでした、ミネストローネも野菜がたくさん入っていておいしかったです。リピートしようと思います。');
    },
  );
}

// 本番用（データベースから取得する処理）
Future<List<ArchiveStore>> fetchArchiveStoresFromDatabase() async {
  await Future.delayed(const Duration(seconds: 2)); // 仮の遅延
  return []; // データベースの中身を受け取る
}

// アーカイブページ画面
class ArchivePage extends ConsumerWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // アーカイブのデータを取得
    final archiveStoreAsyncValue = ref.watch(archiveStoreProvider);
    return Scaffold(
      // アプリバー
      appBar: AppBar(
        title: const Text(
          'アーカイブ', // アーカイブページのタイトル
          style: TextStyle(fontWeight: FontWeight.bold), // 太字のスタイル
        ),
        backgroundColor: const Color(mainColor), // アプリバーの背景色（共通定義）
      ),
      // body
      body: archiveStoreAsyncValue.when(
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
              // フッター部分を画面下部に配置
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

  // Storeの情報を元に、各ストアの詳細情報を表示するカードをビルド
  Widget _buildCard(BuildContext context, ArchiveStore store) {
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
                    // 店名を表示
                    Text(
                      store.RestaurantName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // 店名を太字で表示
                    ),
                    const SizedBox(height: 8), // 店名と画像の間に余白
                    // ストアの画像を表示
                    Image.asset(
                      store.Images,
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
                                AssetImage(store.Icon), // アイコン画像を設定
                          ),
                        ),
                        // 投稿日時を表示
                        Text(
                          '投稿日: ${store.CreatedAt}',
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
                        store.Comment,
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
