import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/api/http_req.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/screens/store_info/info.dart';
import 'package:foodshuffle/widgets/swipe_card/swipe_card.dart';

class SwipeHandler extends StatefulWidget {
  final AppinioSwiperController controller;
  final List<ReviewCard> stores;

  const SwipeHandler({
    super.key,
    required this.controller,
    required this.stores,
  });

  @override
  State<SwipeHandler> createState() => _SwipeHandlerState();
}

class _SwipeHandlerState extends State<SwipeHandler> {
  @override
  Widget build(BuildContext context) {
    if (widget.stores.isEmpty) {
      return const Center(child: Text("新しいレビューはありません！"));
    }

    return AppinioSwiper(
      key: const ValueKey('swiper'),
      controller: widget.controller,
      cardCount: widget.stores.length,
      cardBuilder: (BuildContext context, int index) {
        return SwipeCard(
          key: ValueKey('card_${widget.stores[index].ReviewUuid}_$index'),
          reviewCard: widget.stores[index],
        );
      },
      onSwipeEnd: (previousIndex, targetIndex, activity) async {
        if (previousIndex >= widget.stores.length) return;

        if (activity is Swipe) {
          final store = widget.stores[previousIndex];
          if (activity.end?.dy == 0.0) {
            if (activity.end!.dx < 0.0) {
              debugPrint("左へ移動した");
              try {
                await Http.request(
                  endpoint: Urls.notInterestedReview(store.ReviewUuid),
                  method: HttpMethod.put,
                );
              } catch (e) {
                debugPrint(e.toString());
              }
            } else {
              debugPrint("右へ移動した");
              try {
                await Http.request(
                  endpoint: Urls.interestedReview(store.ReviewUuid),
                  method: HttpMethod.put,
                );
              } catch (e) {
                debugPrint(e.toString());
              }
            }
          } else if (activity.end!.dy < 0) {
            debugPrint("上へ移動した");
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDetailPage(store: store),
                ),
              );
            }
          }
        }
      },
      onEnd: () {
        debugPrint('Swipe ended');
      },
    );
  }
}