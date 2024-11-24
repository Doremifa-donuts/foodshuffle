import 'dart:async';
import 'package:flutter/material.dart';
// ホームページに移動
import '../screens/home_page.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  int _currentImageIndex = 0; // 現在の画像インデックス
  late Timer _timer; // 画像切り替え用タイマー

  // 切り替える画像のパス
  final List<String> _imagePaths = [
    'images/animation/animation_1.png',
    'images/animation/animation_2.png',
    'images/animation/animation_3.png',
    'images/animation/animation_4.png',
  ];

  @override
  void initState() {
    super.initState();
    _startImageChangeTimer();

    // 3秒後にHomePageに遷移
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  void _startImageChangeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // タイマーを停止
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: SizedBox(
              width: 200, // 固定幅
              height: 200, // 固定高さ
              child: Image.asset(
                _imagePaths[_currentImageIndex],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
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
