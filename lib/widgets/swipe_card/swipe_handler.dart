import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/api/request_handler.dart';
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
  double _rightHeartOpacity = 0.0; // ❤️ の透明度
  double _leftHeartOpacity = 0.0; // 💔 の透明度
  @override
  Widget build(BuildContext context) {
    if (widget.stores.isEmpty) {
      return const Center(child: Text("新しいレビューはありません！"));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // 右スワイプ（❤️）
        Positioned(
          top: 100,
          right: 50,
          child: Opacity(
            opacity: _rightHeartOpacity,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 80,
            ),
          ),
        ),
        // 左スワイプ（💔）
        Positioned(
          top: 100,
          left: 50,
          child: Opacity(
            opacity: _leftHeartOpacity,
            child: Icon(
              Icons.heart_broken,
              color: Colors.grey,
              size: 80,
            ),
          ),
        ),
        //スワイパー
        AppinioSwiper(
          key: const ValueKey('swiper'),
          controller: widget.controller,
          cardCount: widget.stores.length,
          cardBuilder: (BuildContext context, int index) {
            return SwipeCard(
              key: ValueKey('card_${widget.stores[index].ReviewUuid}_$index'),
              reviewCard: widget.stores[index],
            );
          },
          onCardPositionChanged: (SwiperPosition position) {
            setState(() {
              double opacity = (position.offset.dx.abs() / 200).clamp(0.0, 1.0);
              if (position.offset.dx < 0) {
                // 左（💔）
                _leftHeartOpacity = opacity;
                _rightHeartOpacity = 0.0;
              } else {
                // 右（❤️）
                _rightHeartOpacity = opacity;
                _leftHeartOpacity = 0.0;
              }
            });
          },
      onSwipeEnd: (previousIndex, targetIndex, activity) async {
            setState(() {
              _rightHeartOpacity = 0.0;
              _leftHeartOpacity = 0.0;
            });
        if (previousIndex >= widget.stores.length) return;

        if (activity is Swipe) {
          final store = widget.stores[previousIndex];
          if (activity.end?.dy == 0.0) {
            if (activity.end!.dx < 0.0) {
              debugPrint("左へ移動した");
              try {
                await RequestHandler.jsonWithAuth(
                  endpoint: Urls.notInterestedReview(store.ReviewUuid),
                  method: HttpMethod.put,
                );
              } catch (e) {
                debugPrint(e.toString());
              }
            } else {
              debugPrint("右へ移動した");
              try {
                await RequestHandler.jsonWithAuth(
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
    ),
      ],
    );
  }
}
