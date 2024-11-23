import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/model/store.dart';
import '../widgets/swipe_card.dart';
import '../widgets/footer.dart';

final swipeAsyncNotifierProvider = FutureProvider<List<Store>>((ref) async {
  return [
    Store(
      storeImage: 'images/store/store_1.png',
      name: 'Store A',
      address: '123 Street, City',
      message: 'Fresh and delicious!',
      days: '2024-11-20',
      goods: 120,
    ),
    Store(
      storeImage: 'images/store/store_1.png',
      name: 'Store B',
      address: '456 Avenue, City',
      message: 'Great atmosphere!',
      days: '2024-11-21',
      goods: 90,
    ),
  ];
});

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

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(swipeAsyncNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ホーム',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
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
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(),
            ),
          ],
        ),
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
