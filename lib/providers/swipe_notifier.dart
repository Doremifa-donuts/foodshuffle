import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final swipeAsyncNotifierProvider =
    AsyncNotifierProvider<SwipeAsyncNotifier, List<String>>(
  SwipeAsyncNotifier.new,
);

class SwipeAsyncNotifier extends AsyncNotifier<List<String>> {
  @override
  FutureOr<List<String>> build() async {
    return List.generate(5, (index) => "Card ${index + 1}");
  }

  Future<void> swipeOnCard(String direction) async {
    // スワイプ時の処理
    switch (direction) {
      case 'left':
        // 左スワイプの処理
        break;
      case 'right':
        // 右スワイプの処理
        break;
      default:
        break;
    }
  }
}
