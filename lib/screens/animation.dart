import 'dart:async';
import 'package:flutter/material.dart';

// AnimationPage クラス
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  int _currentImageIndex = 0; // 現在の画像インデックス
  late Timer _timer; // 画像切り替え用タイマー
  final List<String> _imagePaths = [
    'images/animation/animation_1.png',
    'images/animation/animation_2.png',
    'images/animation/animation_3.png',
    'images/animation/animation_4.png',
  ];

  @override
  void initState() {
    super.initState();
    // タイマーで画像を定期的に切り替える
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 画面が破棄されるときにタイマーを停止
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: Image.asset(
              _imagePaths[_currentImageIndex],
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // 背景を構築するメソッド
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
