import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class SwipeCard extends StatelessWidget {
  final List<dynamic> list;
  final AppinioSwiperController controller;

  const SwipeCard({
    super.key,
    required this.list,
    required this.controller,
    required Future<Null> Function(dynamic direction) onSwiping,
  });

  @override
  Widget build(BuildContext context) {
    return AppinioSwiper(
      controller: controller,
      cardCount: list.length, // カードの数
      cardBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              list[index].toString(), // 表示する内容
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      },
      onSwipeEnd: (previousIndex, targetIndex, activity) {
        // スワイプ終了時の処理
        log('Swiped from $previousIndex to $targetIndex');
        log('Swipe activity: $activity');
      },
      onEnd: () {
        // スワイプが終わった時の処理
        log('Swipe ended');
      },
    );
  }
}
