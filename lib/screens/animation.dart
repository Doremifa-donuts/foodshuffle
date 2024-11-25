import 'dart:async';
import 'package:flutter/material.dart';
// ホームページに移動
import '../screens/home_page.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

// 画像切り替え用ステート
class _AnimationPageState extends State<AnimationPage> {
  int _currentImageIndex = 0; // 現在表示中の画像のインデックス
  late Timer _timer; // 画像切り替えのためのタイマー

  // 切り替え対象の画像パスリスト
  final List<String> _imagePaths = [
    'images/animation/animation_1.png',
    'images/animation/animation_2.png',
    'images/animation/animation_3.png',
    'images/animation/animation_4.png',
  ];

  // 画像切り替え間隔（0.5秒）
  final Duration imageChangeDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    // 画像を定期的に切り替えるタイマーを開始
    _startImageChangeTimer();

    // 3秒後にホームページに遷移
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  // タイマーを設定して、一定間隔で画像を切り替える
  void _startImageChangeTimer() {
    _timer = Timer.periodic(imageChangeDuration, (timer) {
      setState(() {
        // 次の画像に切り替える（インデックスを循環させる）
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    // 画面が破棄される際にタイマーを停止してメモリリークを防ぐ
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像
          _buildBackground(),
          // 中央に表示される画像
          Center(
            child: SizedBox(
              width: 200, // 固定幅
              height: 200, // 固定高さ
              child: Image.asset(
                _imagePaths[_currentImageIndex], // 現在の画像を表示
                fit: BoxFit.contain, // 画像を枠内に収める
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 背景画像のウィジェット
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backimg.jpg'), // 背景画像のパス
          fit: BoxFit.cover, // 背景を画面全体に拡大して表示
        ),
      ),
    );
  }
}
