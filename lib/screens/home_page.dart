import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/model/data_list.dart';
import '../widgets/swipe_card.dart';
import '../widgets/footer.dart';
import '../model/color.dart';

// ダミーデータ
final swipeAsyncNotifierProvider = FutureProvider<List<HomeStore>>((ref) async {
  return List.generate(30, (index) {
    return HomeStore(
      Images: 'images/store/store_1.png', // 画像ファイル名を動的に変更
      RestaurantName:
          'Store ${String.fromCharCode(65 + index)}', // 'Store A', 'Store B', ...
      Address: 'Street ${index + 1}, City',
      Comment: 'Fresh and delicious! ${index + 1}',
      CreatedAt: '2024-11-${20 + index}',
      goods: 120 + index,
    );
  });
});

// homePage クラス
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late AppinioSwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = AppinioSwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

// homePage 画面処理
  @override
  Widget build(BuildContext context) {
    // リストの中身を確認
    final asyncValue = ref.watch(swipeAsyncNotifierProvider);

    return Scaffold(
      // headerの処理
      appBar: AppBar(
        title: const Text(
          'ホーム',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),

      // body の処理
      body: asyncValue.when(
        data: (stores) => Stack(
          children: [
            _buildBackground(),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AppinioSwiper(
                  controller: _swiperController,
                  cardCount: stores.length,
                  cardBuilder: (context, index) {
                    return SwipeCard(store: stores[index]);
                  },
                  // スワイプ処理
                  onSwipeEnd: (previousIndex, targetIndex, activity) {
                    debugPrint('Swiped from $previousIndex to $targetIndex');
                    debugPrint('Swipe activity: $activity');
                  },
                  onEnd: () {
                    debugPrint('Swipe ended');
                  },
                ),
              ),
            ),

            // footerの処理　classに飛ばす
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(),
            ),
          ],
        ),

        // loading　処理
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'エラーが発生しました。\n詳細: $error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backimg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
