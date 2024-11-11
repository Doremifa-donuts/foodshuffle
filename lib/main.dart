import 'package:flutter/material.dart';
import 'package:foodshuffle/login.dart';

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
      title: 'Flutter Demo',
      // テーマのカラー
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // テーマを使用する場合は true
        useMaterial3: true,
      ),
      // 画面に表示する内容引数を渡す
      home: LoginPage(),
    );
  }
}

// ホーム画面
class MyHomePage extends StatefulWidget {
  // 引数受け取り
  const MyHomePage({super.key, required this.title});
  // 変更できないようにする
  final String title;

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
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
          ],
        ),
      ),
    );
  }
}
