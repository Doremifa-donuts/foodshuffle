import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

// レビュー時のストアのデータクラス
class Store {
  final String storeImage; // ストア画像
  final String name; // ストア名
  final String address; // 住所
  final String massage; // コメント
  final String days; // 投稿日
  final int goods; // いいね数

  Store({
    required this.storeImage,
    required this.name,
    required this.address,
    required this.massage,
    required this.days,
    required this.goods,
  });
}

class SwipeCard extends StatelessWidget {
  final List<Store> list; // Store型のリスト
  final AppinioSwiperController controller;

  const SwipeCard({
    super.key,
    required this.list,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppinioSwiper(
      controller: controller,
      cardCount: list.length, // カードの数
      cardBuilder: (BuildContext context, int index) {
        final store = list[index]; // 現在のストアデータ
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // カードの画像
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    store.storeImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16), // 余白
                // ストア名
                Text(
                  store.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8), // 余白
                // 住所
                Text(
                  store.address,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8), // 余白
                // コメント
                Text(
                  store.massage,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(), // コンテンツの間に余白を追加
                // 投稿日といいね数
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '投稿日: ${store.days}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${store.goods}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
