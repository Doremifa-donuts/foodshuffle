import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/api/http_req.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/screens/store_info/info.dart';
import 'package:foodshuffle/widgets/swipe_card/swipe_card.dart';

class SwipeHandler extends StatelessWidget {
  final AppinioSwiperController controller;
  final List<ReviewCard> stores;

  const SwipeHandler({
    super.key,
    required this.controller,
    required this.stores,
  });

  @override
  Widget build(BuildContext context) {
    if (stores.isEmpty) {
      return Center(child: Text("新しいレビューはありません！"));
    }
    return AppinioSwiper(
      controller: controller,
      cardCount: stores.length,
      cardBuilder: (context, index) {
        return SwipeCard(reviewCard: stores[index]);
      },
      // swipeOptions: SwipeOptions.only(up: true, left: true, right: true),  //　した方向にカードを送れてしまうのを避けたいが、した方向に対する移動が完全に拒否されてしまい挙動に違和感が出る
      onSwipeEnd: (previousIndex, targetIndex, direction) async {
        String url;
        if (direction.end?.dy == 0.0) {
          if (direction.end!.dx < 0.0) {
            debugPrint("左へ移動した");

            url = Urls.notInterestedReview(stores[previousIndex].ReviewUuid);
          } else {
            debugPrint("右へ移動した");
            url = Urls.interestedReview(stores[previousIndex].ReviewUuid);
          }
          try {
            await Http.request(endpoint: url, method: HttpMethod.put);
          } catch (e) {
            debugPrint(e.toString());
          }
        } else if (direction.end!.dy < 0) {
          debugPrint("上へ移動した");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  StoreDetailPage(store: stores[previousIndex]),
            ),
          );
          //TODO: レビュー詳細画面への遷移
        }
      },
      onEnd: () {
        debugPrint('Swipe ended');
      },
    );
  }
}
