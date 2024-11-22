import 'package:flutter/material.dart';
import 'package:foodshuffle/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_page.dart';

// 立ち上げ時に実行
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// アプリケーションのエントリーポイント
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // デバッグ時にチェックモードのバナーを非表示に設定
      debugShowCheckedModeBanner: false,
      // アプリケーション全体のテーマ設定
      theme: ThemeData(
        // テーマカラー指定
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(mainColor)),
        // フォントファミリーを「uzura」に設定
        fontFamily: 'uzura',
        // Material3のデザインを使用
        useMaterial3: true,
      ),

      // 起動時にホームに飛ばす
      home: const HomePage(), // ホーム画面へ遷移
    );
  }
}
