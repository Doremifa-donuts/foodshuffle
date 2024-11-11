import 'package:flutter/material.dart';
import 'package:foodshuffle/common.dart';
// import 'package:foodshuffle/login.dart';

// はじめに呼び出されるメソッド
void main() {
  // myappメソッドの呼び出し
  runApp(const MyApp());
}

// メインウィジェット
class MyApp extends StatelessWidget {
  // MyAppクラスのコンストラクタ
  const MyApp({super.key});

  // buildメソッド（表示項目）
  @override
  Widget build(BuildContext context) {
    // テーマの設定
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // テーマのカラー
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // テーマを使用する場合は true
        useMaterial3: true,
      ),
      // 画面に表示する内容引数を渡す
      home: MyHomePage(),
    );
  }
}

// ホーム画面
class MyHomePage extends StatefulWidget {
  // 引数受け取り
  const MyHomePage({super.key});

  // 新しいインスタンスを返す
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 状態を管理する
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(backImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SafeArea(
              child: Center(
                child: Text(
                  '画面一杯に画像',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
