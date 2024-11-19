import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/widgets/footer.dart';
import 'package:foodshuffle/providers/swipe_notifier.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPage();
}

class _MyPage extends ConsumerState<MyPage> {
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
              Center(child: Text("mypage")),
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
