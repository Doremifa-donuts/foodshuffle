import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/widgets/footer.dart';
import 'package:foodshuffle/providers/swipe_notifier.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key});

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPage();
}

class _ReviewPage extends ConsumerState<ReviewPage> {
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
            'グループ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorUtils.hexToColor(mainColor)),
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
          const Column(
            children: [
              SizedBox(height: 300), // 上部余白を調整

              Expanded(
                flex: 2, // カード部分に多めのスペースを割り当て
                child: Image(image: AssetImage('images/review.png')),
              ),
            ],
          ),

          asyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (data) {
              return const SafeArea(
                child: Column(),
              );
            },
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
