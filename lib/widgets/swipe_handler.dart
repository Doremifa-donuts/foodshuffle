import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/widgets/swipe_card.dart';

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
    return AppinioSwiper(
      controller: controller,
      cardCount: stores.length,
      cardBuilder: (context, index) {
        return SwipeCard(reviewCard: stores[index]);
      },
      onSwipeEnd: (previousIndex, targetIndex, direction) {
        debugPrint('Swiped from $previousIndex to $targetIndex');
        debugPrint('Swipe direction: $direction');
      },
      onEnd: () {
        debugPrint('Swipe ended');
      },
    );
  }
}
