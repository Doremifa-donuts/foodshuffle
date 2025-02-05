import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import 'package:foodshuffle/api/websocket.dart';
import 'screens/login.dart';
import '../model/color.dart';

// 立ち上げ時に実行
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin()
    ..resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission()
    ..initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ));

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

// ローカル通知を実行する
void showLocalNotification(String title, String message) {
  // android用の通知を生成する
  const androidNotificationDetail = AndroidNotificationDetails(
      'channel_id', // channel Id
      'channel_name' // channel Name
      );
  //ios用の通知を生成する
  const iosNotificationDetail = DarwinNotificationDetails();
  // 通知をまとめる
  const notificationDetails = NotificationDetails(
    iOS: iosNotificationDetail,
    android: androidNotificationDetail,
  );
  // 通知を実行する
  FlutterLocalNotificationsPlugin()
      .show(0, title, message, notificationDetails);
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
