import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 状態管理
import '../../widgets/footer.dart'; // フッター表示
import '../../model/color.dart'; // カラー設定
import '../../model/images.dart'; // 画像パス設定
import '../../model/data_list.dart'; // データモデル
import '../../screens/review/review_post.dart'; // レビューページへの遷移
import '../../data/review.dart'; // ダミーデータ

const bool useDatabase = false; // データベース使用フラグ

// 状態管理用のStateNotifier
final storeListProvider =
    StateNotifierProvider<StoreListNotifier, List<QrStore>>((ref) {
  return StoreListNotifier(fetchDummyArchiveStores());
});

class StoreListNotifier extends StateNotifier<List<QrStore>> {
  StoreListNotifier(Future<List<QrStore>> stores) : super([]) {
    _loadStores(stores);
  }

  Future<void> _loadStores(Future<List<QrStore>> stores) async {
    state = await stores;
  }

  void toggleLike(int index) {
    final updatedStore = state[index];
    updatedStore.isLiked = !updatedStore.isLiked;
    updatedStore.goods += updatedStore.isLiked ? 1 : -1;

    state = [
      ...state.sublist(0, index),
      updatedStore,
      ...state.sublist(index + 1),
    ];
  }
}

// ダミーデータ取得
Future<List<QrStore>> fetchDummyArchiveStores() async {
  await Future.delayed(const Duration(seconds: 1));
  return qrStoreList;
}

// アーカイブページ
class QrAfter extends ConsumerWidget {
  const QrAfter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(storeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'お店ついたよ！',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(textMainColor),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: const Color(mainColor),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Column(
            children: [
              _buildMapImage(),
              _buildMapTitle(),
              Expanded(child: _buildStoreList(context, stores, ref)),
            ],
          ),
          const Positioned(bottom: -20, left: 0, right: 0, child: Footer()),
        ],
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
  Widget _buildStoreList(
      BuildContext context, List<QrStore> stores, WidgetRef ref) {
    return Scrollbar(
      thickness: 12,
      radius: const Radius.circular(20),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: stores.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final store = stores[index];
          return _buildStoreItem(context, store, index, ref);
        },
      ),
    );
  }

  // 店舗アイテム
  Widget _buildStoreItem(
      BuildContext context, QrStore store, int index, WidgetRef ref) {
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
                        Text(
                          '投稿日: ${store.CreatedAt}',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            store.isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_off_alt,
                            size: 18,
                            color: store.isLiked ? Colors.black : Colors.grey,
                          ),
                          onPressed: () {
                            ref
                                .read(storeListProvider.notifier)
                                .toggleLike(index);
                          },
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${store.goods}',
                          style: const TextStyle(fontSize: 14),
                        ),
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
