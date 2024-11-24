import 'dart:async';
import 'package:flutter/material.dart';

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
    // タイマーで画像を定期的に切り替える
    _startImageChangeTimer();
  }

  // タイマーを開始するメソッド
  void _startImageChangeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  // Widgetを破棄するメソッド
  @override
  void dispose() {
    _timer.cancel(); // タイマーを停止
    super.dispose();
  }

  // UIを構築するメソッド
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
              child: _buildAnimatedImage(),
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

  // アニメーション画像を構築するメソッド
  Widget _buildAnimatedImage() {
    return Image.asset(
      _imagePaths[_currentImageIndex],
      fit: BoxFit.contain,
    );
  }
}
