import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/common.dart';
import 'package:foodshuffle/widgets/footer.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/login.dart';

// マイページを表すConsumerStatefulWidget
class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  late AppinioSwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    // Swiperコントローラーを初期化
    _swiperController = AppinioSwiperController();
  }

  @override
  void dispose() {
    // コントローラーを破棄してリソースを解放
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String user = "かれんこん"; // ユーザー名（仮設定）

    return Scaffold(
      appBar: AppBar(title: const Text('マイページ')), // アプリバー
      body: Stack(
        children: [
          // 背景画像の設定
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg), // 背景画像
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ユーザー情報を表示する部分
          Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('images/icon.png'), // アイコン画像
                radius: 40,
              ),
              const SizedBox(height: 8),
              const Text(
                user, // ユーザー名
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),

              // サインアウトボタン
              ElevatedButton(
                onPressed: () {
                  // サインアウト後にログインページに遷移
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('サインアウト'),
              ),
            ],
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
