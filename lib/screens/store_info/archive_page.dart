import 'package:flutter/material.dart';
// 動的に状態把握
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/widgets/auth_icon.dart';
import 'package:foodshuffle/widgets/auth_image.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart';
// カラー、画像パス
import '../../model/color.dart';
// お店の詳細ページ
import 'info.dart';


// プロバイダーの定義（データ取得を切り替え）
final archiveStoreProvider = FutureProvider<List<ReviewCard>>((ref) async {
  try {
    final data = await RequestHandler.requestWithAuth(
        endpoint: Urls.archivesReview, method: HttpMethod.get);
    List<ReviewCard> cards = [];

    for (var item in data) {
      cards.add(ReviewCard.fromJson(item));
    }
    return cards;
  } catch (e) {
    return [];
  }
});

// 本番用（データベースから取得する処理）
// Future<List<ReviewCard>> fetchArchiveStores() async {}

// アーカイブページ画面
class ArchivePage extends ConsumerWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // アーカイブのデータを取得
    final archiveStoreAsyncValue = ref.watch(archiveStoreProvider);
    return PageTemplate(
      pageTitle: 'アーカイブ',
      onInit: () {
        ref.invalidate(archiveStoreProvider);
      },
      child: archiveStoreAsyncValue.when(
          data: (stores) {
            return stores.isEmpty
                ? const Center(child: Text("アーカイブしたレビューはありません！"))
                :
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
                  );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()), // 読み込み中
          error: (err, stack) {
            debugPrint(err.toString());
            debugPrint(stack.toString());
            return Center(child: Text('エラーが発生しました: $err')); // エラー時
          }),
    );
  }

  // Storeの情報を元に、各ストアの詳細情報を表示するカードをビルド
  Widget _buildCard(BuildContext context, ReviewCard store) {
    return InkWell(
      onTap: () {
        debugPrint('写真の数${store.Images}');
        // お店の詳細ページに遷移
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => PageTemplate(child: Container()),
            builder: (context) => StoreDetailPage(store: store),
          ),
        );
      },
      child: Card(
        color: const Color(listColor),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(allListColor),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                store.RestaurantName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthImage(
                      imagePath: store.Images[0], height: 120, width: 100),
                  Container(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: AuthIcon(imagePath: store.Icon)),
                            Text(
                              // '投稿日: ${store.CreatedAt}',
                              '投稿日: ${DateFormat("yyyy/MM/dd").format(store.CreatedAt)}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Text(
                            store.Comment,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
