import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/main.dart';
import 'package:foodshuffle/utils/geolocator.dart';
import 'package:foodshuffle/utils/ios_notifier.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      // onDone: _onDone,
    );
    _startSendingLocation();
  }

  // 位置情報送信を一定間隔毎に行う
  void _startSendingLocation() {
    debugPrint('タイマーを開始');
    _timer = Timer.periodic(const Duration(seconds: 5), sendLocation);
  }

  // メッセージ受信時の処理
  void _onMessageReceived(String jsonString) async {
    // switch (message["type"]) {
    //   case "boost": // お助けブーストの場合SharedPreferencesにブーストのUUIDを格納
    // }
    debugPrint(jsonString);
    final message = json.decode(jsonString);
    switch (message["Type"]) {
      case 1:
        debugPrint("お助けブースを設定したい");
        final pref = await SharedPreferences.getInstance();
        pref.setString("boost", json.encode(message["Content"]));
      default:
        debugPrint("何もすることないと思う");
    }
    NotificationService().showNotification(message["Message"]);
  }

  // エラー処理
  void _onError(error) => disconnect();

  // 接続終了
  // void _onDone() => disconnect();

  // WebSocket切断
  void disconnect() async {
    // タイマーを終了
    _timer?.cancel();
    _timer = null;
    debugPrint("タイマー終了");

    await _channel?.sink.close();
    _channel = null;
    debugPrint("websocket切断");

    _isConnected = false;
  }

  // 位置情報を送信する
  void sendLocation(timer) async {
    LocationData currentLocation = await Geolocator.getPosition();
    double? latitude = currentLocation.latitude;
    double? longitude = currentLocation.longitude;
    debugPrint('位置情報$latitude $longitude');
    _channel?.sink.add('$latitude\n$longitude');
  }

  // 接続状態の確認
  get isConnected => _isConnected;
}
