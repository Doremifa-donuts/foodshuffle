import 'package:flutter/material.dart';

const String backImg = 'images/backimg.jpg';
const String unionImg = 'images/Union.png';

// footer
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // フッターの高さとパディングを設定
      height: 130.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(unionImg), // 背景画像の指定
          fit: BoxFit.cover, // 画像をフッター全体に表示
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.rate_review, color: Colors.white),
            onPressed: () {
              // ホームへのナビゲーション
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.groups_2, color: Colors.white),
            onPressed: () {
              // ホームへのナビゲーション
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // ホームへのナビゲーション
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.white),
            onPressed: () {
              // 検索画面へのナビゲーション
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // 設定画面へのナビゲーション
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
