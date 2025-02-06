import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import 'package:foodshuffle/api/websocket.dart';
import 'package:foodshuffle/utils/ios_notifier.dart';
import 'screens/login.dart';
import '../model/color.dart';

// グローバルナビゲーターキー
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// 立ち上げ時に実行
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // iosのローカル通知を初期化
  await NotificationService().init();

  // WebSocketの通信インスタンスを生成
  WebSocketService();

  runApp(
    const ProviderScope(
      // .envファイルの読み込み
      // ProviderScopeでラップ
      child: MyApp(),
    ),
  );
}

// アプリケーションのエントリーポイント
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // グローバルキーを設定
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
        // ボタンのテーマ設定
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'uzura', // ボタンに適用されるフォント
              fontSize: 16,
            ),
          ),
        ),
      ),

      // 起動時にホームに飛ばす
      home: const LoginPage(), // ホーム画面へ遷移
    );
  }
}
