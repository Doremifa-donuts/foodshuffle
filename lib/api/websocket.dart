import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/main.dart';
import 'package:location/location.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// WebSocketのサービスをシングルトンで実装
class WebSocketService {
  // WebSocketサービスのインスタンス
  static final WebSocketService _instance = WebSocketService._internal();
  // WebSocketの接続を保持する
  WebSocketChannel? _channel;
  // 接続状態を管理する
  bool _isConnected = false;
  // 位置情報共有のタイマー
  Timer? _timer;
  // コンストラクタ
  factory WebSocketService() => _instance;

  // 内部コンストラクタ
  WebSocketService._internal();

  //FIXME: 本来はステータスを確認し、位置情報共有を行うかどうかを判断すべきだが、ログイン後無条件で位置情報共有を開始している
  void connect(String token) async {
    // すでに接続が確立されている場合は早期リターン
    if (_isConnected) return;
    try {
      // WebSocket接続を確立
      _channel = IOWebSocketChannel.connect(Uri.parse(Urls.location),
          headers: {'Authorization': 'Bearer $token'});
      debugPrint("WebSocket接続成功");
      // }
    } catch (e) {
      // エラーとスタックトレースを詳細に出力
      debugPrint("WebSocket接続失敗: $e");
    }
    _isConnected = true; // 接続確立状態を更新
    _channel!.stream.listen(
      (message) {
        // 受信したメッセージの処理
        _onMessageReceived(message);
      },
      onError: (error) {
        _onError(error);
      },
      onDone: _onDone,
    );
    _startSendingLocation();
  }

  // 位置情報送信を一定間隔毎に行う
  void _startSendingLocation() {
    debugPrint('タイマーを開始');
    _timer = Timer.periodic(const Duration(seconds: 5), sendLocation);
  }

  // 位置情報の取得を行う
  //FIXME: 位置情報に関する処理は位置情報のクラスに切り出すべき 権限のリクエストもしていない
  static Future<LocationData> getPosition() async {
    final currentLocation = await Location().getLocation();
    return currentLocation;
  }

  // メッセージ受信時の処理
  void _onMessageReceived(String message) {
    showLocalNotification("Food Shuffle", message);
  }

  // エラー処理
  void _onError(error) => disconnect();

  // 接続終了
  void _onDone() => disconnect();

  // WebSocket切断
  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
    _timer?.cancel();
  }

  // 位置情報を送信する
  void sendLocation(timer) async {
    debugPrint("送信開始");
    LocationData currentLocation = await getPosition();
    double? latitude = currentLocation.latitude;
    double? longitude = currentLocation.longitude;
    debugPrint('位置情報$latitude $longitude');

    _channel?.sink.add('$latitude\n$longitude');
  }

  // 接続状態の確認
  get isConnected => _isConnected;
}
