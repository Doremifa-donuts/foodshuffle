import 'package:flutter/material.dart';
// 動的に状態把握
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/api/http_req.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/visited_store/visited_store.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:foodshuffle/widgets/review/review_list.dart';

// 表示するデータを受け取るclass
// レビューのページ画面切り替えボタン
import '../../widgets/review/review_toggle_buttons.dart';

// プロバイダーの定義（データ取得を切り替え）
final reviewStoreBeforeProvider =
    FutureProvider.family<List<VisitedStore>, bool>((ref, isPending) async {
  return fetchReviewStores(isPending);
});

// 状態管理のプロバイダー
final isPendingProvider = StateProvider<bool>((ref) => true);

// 本番用（データベースから取得する処理）
Future<List<VisitedStore>> fetchReviewStores(bool isPending) async {
  // デフォルトではレビューを後のURLから取得する
  String url = Urls.afterReview;

  // 未レビューを取得するモードになっているならば、URLを変更する
  if (isPending) {
    url = Urls.beforeReview;
  }

  try {
    final data = await Http.request(endpoint: url, method: HttpMethod.get);
    List<VisitedStore> stores = [];

    for (var item in data) {
      final store = VisitedStore.fromJson(item);
      stores.add(store);
    }

    return stores;
  } catch (ex) {
    debugPrint(ex.toString());
  }
  return [];
}

// レビューのページ画面
class ReviewBeforePage extends ConsumerWidget {
  ReviewBeforePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RiverpodのStateProviderからisPendingの状態を取得
    final isPending = ref.watch(isPendingProvider);
    // レビューのデータを非同期に取得
    final reviewStoreBeforeAsyncValue = ref.watch(
        reviewStoreBeforeProvider(ref.read(isPendingProvider.notifier).state));

    return PageTemplate(
      pageTitle: 'レビュー',
      child: reviewStoreBeforeAsyncValue.when(
        data: (stores) {
          // データが取得できた場合
          return Column(
            children: [
              // レビューボタン（未レビュー・レビュー済み）
              ReviewToggleButtons(
                onPendingPressed: () async {
                  // レビュー済み状態の時のみ切り替え可能になる
                  if (!isPending) {
                    ref.read(isPendingProvider.notifier).state = !isPending;
                    ref.refresh(reviewStoreBeforeProvider(isPending));
                  }
                },
                // ここは無効化（未レビューのボタンは機能しない）
                onReviewedPressed: () async {
                  // レビュー未状態の時のみ切り替え可能になる
                  if (isPending) {
                    ref.read(isPendingProvider.notifier).state = !isPending;
                    ref.refresh(reviewStoreBeforeProvider(isPending));
                  }
                },
                isPending: isPending,
              ),
              // レビューリストを表示（データを渡す）
              Expanded(
                child: ReviewList(stores: stores),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(), // 読み込み中のインジケータ
        ),
        error: (err, stack) => Center(
          child: Text('エラーが発生しました: $err'), // エラー時のメッセージ
        ),
      ),
    );
  }
}
