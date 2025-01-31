import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/page_template.dart';

import '../widgets/footer.dart'; // フッターウィジェット

// ピンデータを保存するプロパイダー
final pinProvider = FutureProvider<List<Marker>>((ref) async {
  try {
    final pins = await RequestHandler.requestWithAuth(
        endpoint: Urls.wentPlace, method: HttpMethod.get);

    List<Marker> addPins = [];
    // 所得したデータをマーカーに変換
    for (var item in pins) {
      debugPrint(item.toString());
      final latitude = item['Latitude']; // 緯度
      final longitude = item['Longitude']; // 経度
      final name = item['RestaurantName']; // 店舗名

      // ピンを追加する関数
      addPins.add(
        Marker(
          point: LatLng(latitude, longitude),
          width: 50.0,
          height: 50.0,
          child: Tooltip(
            message: name, // 店名をツールチップに表示
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 50.0,
            ),
          ),
          // マップを回転した時にピンも回転するように
          rotate: false,
        ),
      );
    }
    return addPins;
  } catch (e) {
    return [];
  }
});

// MapSampleの状態を管理するクラス
class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ピンのデータを非同期に所得
    final pinAsyncVlaue = ref.watch(pinProvider);

    return PageTemplate(
      pageTitle: '行ったところマップ',
      onInit: () {
        ref.invalidate(pinProvider); // マップを開いたときにピンを再取得
      },
      isExpanded: true,
      child: Stack(
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
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              // ピンを表示
              pinAsyncVlaue.when(
                data: (pins) => MarkerLayer(markers: pins),
                error: (err, stack) =>
                    const Center(child: Text("ピンの取得に失敗しました")),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
