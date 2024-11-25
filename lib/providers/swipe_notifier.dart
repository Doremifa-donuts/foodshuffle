import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  bool _showHeart = false; // ハートアイコンの表示フラグ
  final List<String> _cards = List.generate(10, (index) => "Card ${index + 1}");

  void _swipeOnCard(String direction) {
    if (_cards.isNotEmpty) {
      setState(() {
        if (direction == 'right') {
          _showHeart = true; // 右スワイプでハートを表示
        }
      });

      // ハート表示後に非表示＆カード削除
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _showHeart = false; // ハートを非表示
          _cards.removeAt(0); // カードリストを更新（先頭のカードを削除）
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe Cards'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // カードリスト
          GestureDetector(
            onPanUpdate: (details) {
              // スワイプ方向を判定
              if (details.delta.dx > 20) {
                debugPrint("右スワイプ検出");
                _swipeOnCard('right'); // 右スワイプ
              } else if (details.delta.dx < -20) {
                debugPrint("左スワイプ検出");
                _swipeOnCard('left'); // 左スワイプ
              }
            },
            child: _cards.isNotEmpty
                ? Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _cards.first,
                      style: const TextStyle(fontSize: 24),
                    ),
                  )
                : const Text(
                    'No cards left',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
          ),
          // ハートアイコン
          if (_showHeart)
            AnimatedOpacity(
              opacity: _showHeart ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 100,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _swipeOnCard('right'); // デモ用に右スワイプをトリガー
        },
        child: const Icon(Icons.swipe),
      ),
    );
  }
}
