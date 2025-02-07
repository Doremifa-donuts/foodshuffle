import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodshuffle/main.dart';
import 'package:foodshuffle/screens/home_page.dart';

class NotificationService {
  // シングルトン
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 通知のアラート、バッジ、サウンドの権限を許可する
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings =
        InitializationSettings(iOS: iosSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap, // **通知タップ時の処理**
    );
  }

  Future<void> showNotification(String text) async {
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'food shuffle',
      text,
      details,
    );
  }

  // **通知を押したときの処理**
  void _onNotificationTap(NotificationResponse details) {
    print('通知をタップ: ${details.payload}');
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
    // 例: 画面遷移やデータ取得処理を追加
  }
}
