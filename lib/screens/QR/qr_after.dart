import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/specific_reviews/specific_review.dart';
import 'package:foodshuffle/widgets/auth_image.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart';
import '../../widgets/footer.dart';
import '../../model/color.dart';
import '../../screens/QR/review_post.dart';

// StateNotifierを使用した状態管理
class ReviewsNotifier extends StateNotifier<AsyncValue<List<SpecificReview>>> {
  ReviewsNotifier() : super(const AsyncValue.loading()) {
    reviews = [];
  }
  List<SpecificReview> reviews = [];
  Future<void> fetchReviews(String restaurantUuid) async {
    try {
      state = const AsyncValue.loading();
      final data = await RequestHandler.jsonWithAuth(
        endpoint: Urls.specificReview(restaurantUuid),
        method: HttpMethod.get,
      );

      for (var item in data) {
        reviews.add(SpecificReview.fromJson(item));
      }
    } catch (e, stack) {
      debugPrint(e.toString());
    } finally {
      state = AsyncValue.data(reviews);
    }
  }

  void toggleLike(int index) async {
    state.whenData((reviews) async {
      if (index >= 0 && index < reviews.length) {
        final updatedReviews = List<SpecificReview>.from(reviews);

        // 現在の状態を取得する
        final goodFlag = updatedReviews[index].GoodFlag;
        final reviewUuid = updatedReviews[index].ReviewUuid;

        // いいねを押すURL
        final String url;

        if (goodFlag) {
          // HACK: いいねが押されていた場合はステータスをアーカイブに変更する
          url = Urls.interestedReview(reviewUuid);
        } else {
          // いいねされていなかった場合はいいねの状態にする
          url = Urls.likeReview(reviewUuid);
        }
        try {
          await RequestHandler.jsonWithAuth(
              endpoint: url, method: HttpMethod.put);
          final review = updatedReviews[index];
          updatedReviews[index] = review.copyWith(
            GoodFlag: !goodFlag,
            Good: review.Good + (review.GoodFlag ? -1 : 1),
          );
          debugPrint('いいねを押したい${review.ReviewUuid}');

          state = AsyncValue.data(updatedReviews);
        } catch (e) {
          debugPrint('通信エラー');
        }
      }
    });
  }
}

// Provider定義
final reviewsProvider = StateNotifierProvider.family<ReviewsNotifier,
    AsyncValue<List<SpecificReview>>, String>((ref, restaurantUuid) {
  final notifier = ReviewsNotifier();
  notifier.fetchReviews(restaurantUuid);
  return notifier;
});

class QrAfter extends ConsumerWidget {
  final String restaurantUuid;

  const QrAfter({super.key, required this.restaurantUuid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(reviewsProvider(restaurantUuid));

    return PageTemplate(
      pageTitle: 'お店についたよ！',
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewWritePage()),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
      child:
          // Scaffold(
          //   appBar: AppBar(
          //     title: const Text(
          //       'お店ついたよ！',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Color(textMainColor),
          //       ),
          //     ),
          //     actions: [
          //       IconButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const ReviewWritePage()),
          //           );
          //         },
          //         icon: const Icon(Icons.add),
          //       ),
          //     ],
          //     backgroundColor: const Color(mainColor),
          //   ),
          //   body: Stack(
          //     children: [
          //       _buildBackgroundImage(),
          Column(
        children: [
          _buildMapImage(),
          _buildMapTitle(),
          Expanded(
            child: reviewsAsync.when(
                data: (reviews) => _buildStoreList(context, reviews, ref),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  debugPrint(error.toString());
                  debugPrint(stack.toString());
                  return Center(
                    child: Text('エラーが発生しました: $error'),
                  );
                }),
          ),
        ],
      ),
      // const Positioned(
      //   bottom: -20,
      //   left: 0,
      //   right: 0,
      //   child: Footer(),
      // ),
      // ],
      // ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.png'), // backImgを実際の画像パスに変更
          fit: BoxFit.cover,
        ),
      ),
    );
  }

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

  Widget _buildStoreList(
    BuildContext context,
    List<SpecificReview> reviews,
    WidgetRef ref,
  ) {
    return Scrollbar(
      thickness: 12,
      radius: const Radius.circular(20),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final review = reviews[index];
          return _buildStoreItem(context, review, index, ref);
        },
      ),
    );
  }

  Widget _buildStoreItem(
    BuildContext context,
    SpecificReview review,
    int index,
    WidgetRef ref,
  ) {
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
                  AuthImage(
                      imagePath: review.Images[0], height: 100, width: 120)
                  // if (review.Images.isNotEmpty)
                  //   Image.network(
                  //     // Image.assetからImage.networkに変更
                  //     review.Images[0],
                  //     width: 120,
                  //     height: 100,
                  //     fit: BoxFit.cover,
                  //     errorBuilder: (context, error, stackTrace) {
                  //       return Container(
                  //         width: 120,
                  //         height: 100,
                  //         color: Colors.grey[300],
                  //         child: const Icon(Icons.error),
                  //       );
                  //     },
                  //   ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.Comment,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(textMainColor),
                      ),
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '投稿日: ${DateFormat("yyyy/MM/dd").format(review.CreatedAt)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            review.GoodFlag
                                ? Icons.thumb_up
                                : Icons.thumb_up_off_alt,
                            size: 18,
                            color: review.GoodFlag ? Colors.black : Colors.grey,
                          ),
                          onPressed: () {
                            ref
                                .read(reviewsProvider(restaurantUuid).notifier)
                                .toggleLike(index);
                          },
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${review.Good}',
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
