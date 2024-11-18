import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../providers/swipe_notifier.dart';
import '../widgets/swipe_card.dart';
import 'package:foodshuffle/widgets/footer.dart';
import 'package:foodshuffle/common.dart';

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
    final notifier = ref.read(swipeAsyncNotifierProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          asyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => const Center(child: Text("Error")),
            data: (data) => SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 500),
                    SwipeCard(
                      list: data,
                      controller: _swiperController,
                      onSwiping: (direction) async {
                        // onSwipingをonSwipeに変更
                        await notifier.swipeOnCard(direction);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // フッター部分
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Footer(), // Footerウィジェットを表示
          ),
        ],
      ),
    );
  }
}
