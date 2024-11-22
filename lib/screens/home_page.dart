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

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'グループ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(mainColor as int)),
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
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (data) {
              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20), // 上部余白を調整
                    Expanded(
                      flex: 2, // カード部分に多めのスペースを割り当て
                      child: SwipeCard(
                        list: data,
                        controller: _swiperController,
                      ),
                    ),
                    Expanded(
                      flex: 1, // フッター部分に少しスペース
                      child: Container(), // 下の余白を調整
                    ),
                  ],
                ),
              );
            },
          ),
          // フッター部分
          const Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Footer(), // Footerウィジェットを表示
          ),
        ],
      ),
    );
  }
}
