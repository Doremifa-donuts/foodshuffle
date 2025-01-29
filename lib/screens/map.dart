import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../model/color.dart'; // 色指定
import '../widgets/footer.dart'; // フッターウィジェット

// Google Mapsを表示するメイン画面のステートフルウィジェット
class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapSampleState(); // ステートを生成
}

// MapSampleの状態を管理するクラス
class MapSampleState extends State<MapPage> {
  // マップのピンのlist
  List<Marker> addPins = [];

  // ピンを追加する関数
  // 引数は緯度軽度とお店の名前
  void addPin(LatLng latlng, String name) {
    // setStateでマップを更新している
    setState(() {
      addPins.add(
        // ピンのテンプレート
        Marker(
          point: LatLng(34.704091, 135.500419), // ピンの位置
          width: 50.0, // ピンの幅
          height: 50.0, // ピンの高さ
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 50.0,
          ),
          //  マップを回転させた時にピンも回転するようにする
          rotate: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '行ったところマップ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      body: Stack(
        children: [
          FlutterMap(
            // 現在地として表示される場所
            options: MapOptions(
              initialCenter: LatLng(34.706463, 135.503209),
              // 最初に表示されるサイズ
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 8.0,
              initialRotation: 0.0, // 初期回転角度
            ),
            children: [
              // 表示される画面
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              // ピンを表示
              MarkerLayer(
                markers: addPins,
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Footer(),
          ),
        ],
      ),
    );
  }
}
