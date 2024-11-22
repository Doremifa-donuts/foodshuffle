import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../providers/swipe_notifier.dart';
import 'package:foodshuffle/widgets/footer.dart';
import 'package:foodshuffle/common.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late AppinioSwiperController _swiperController;

  // スワイパーコントローラーの初期化
  @override
  void initState() {
    super.initState();
    _swiperController = AppinioSwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose(); // コントローラーの解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref
        .watch(swipeAsyncNotifierProvider); // swipeAsyncNotifierProviderのデータを監視

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ホーム',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor), // AppBarの背景色
      ),
      body: Stack(
        children: [
          // 背景画像を表示
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg), // 背景画像の設定
                fit: BoxFit.cover, // 画像を画面いっぱいに広げる
              ),
            ),
          ),
          asyncValue.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()), // データ読み込み中
            error: (error, stackTrace) =>
                Center(child: Text(error.toString())), // エラー時
            data: (data) {
              return const SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 20), // 上部余白を調整

                    Expanded(
                      flex: 1, // フッター部分に少しスペース
                      child: SizedBox.shrink(), // 空のコンテナに変更（余白の調整）
                    ),
                  ],
                ),
              );
            },
          ),
          // フッター部分を画面下部に配置
          const Positioned(
            bottom: -20, // 下部に少しだけ余白を加える
            left: 0,
            right: 0,
            child: Footer(), // Footerウィジェットを表示
          ),
        ],
      ),
    );
  }
}
