import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 状態管理
import '../../widgets/footer.dart'; // フッター表示
import '../../model/color.dart'; // カラー設定
import '../../model/images.dart'; // 画像パス設定
import '../../model/data_list.dart'; // データモデル
import '../../screens/review/review_post.dart'; // レビューページへの遷移
import '../../data/review.dart'; // ダミーデータ

const bool useDatabase = false; // データベース使用フラグ

// プロバイダーの定義
final storeProvider = FutureProvider<List<QrStore>>((ref) async {
  return useDatabase
      ? fetchArchiveStoresFromDatabase()
      : fetchDummyArchiveStores();
});

// ダミーデータ取得
Future<List<QrStore>> fetchDummyArchiveStores() async {
  return qrStoreList;
}

// データベースからデータ取得
Future<List<QrStore>> fetchArchiveStoresFromDatabase() async {
  await Future.delayed(const Duration(seconds: 2));
  return []; // データベースの結果を返却
}

// アーカイブページ
class QrAfter extends ConsumerWidget {
  const QrAfter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archiveStoreAsyncValue = ref.watch(storeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'お店ついたよ！',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(textMainColor)),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: const Color(mainColor),
      ),
      body: archiveStoreAsyncValue.when(
        data: (stores) => Stack(
          children: [
            _buildBackgroundImage(),
            Column(
              children: [
                _buildMapImage(),
                _buildMapTitle(),
                Expanded(child: _buildStoreList(context, stores)),
              ],
            ),
            const Positioned(bottom: -20, left: 0, right: 0, child: Footer()),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラーが発生しました: $err')),
      ),
    );
  }

  // 背景画像
  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // マップ画像
  Widget _buildMapImage() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.asset(
        "images/map.png",
        fit: BoxFit.fill,
      ),
    );
  }

  // マップタイトル
  Widget _buildMapTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("images/pin_drop.png", width: 20, height: 20),
          const SizedBox(width: 5),
          const Text(
            "行ったところマップ",
            style: TextStyle(color: Color(textMainColor)),
          ),
        ],
      ),
    );
  }

  // 店舗リスト
  Widget _buildStoreList(BuildContext context, List<QrStore> stores) {
    return Scrollbar(
      thickness: 12,
      radius: const Radius.circular(20),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: stores.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) =>
            _buildStoreItem(context, stores[index]),
      ),
    );
  }

  // 店舗アイテム
  Widget _buildStoreItem(BuildContext context, QrStore store) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 1)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    store.Images,
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.Comment,
                      style: const TextStyle(
                          fontSize: 14, color: Color(textMainColor)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          '投稿日: ${store.CreatedAt}',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        // いいねぼたん
                        const Icon(Icons.thumb_up, size: 18), // いいねアイコンを表示
                        const SizedBox(width: 4), // アイコンとテキストの間隔を設定
                        Text('${store.goods}',
                            style: const TextStyle(fontSize: 14)), // いいねの数を表示
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
