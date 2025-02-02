import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/page_template.dart';


// データベースから現在地を取得するプロバイダー
final locationProvider = FutureProvider<LatLng>((ref) async {
  try {
    final locationData = await RequestHandler.requestWithAuth(
        // 現在地を保存しているエンドポイントのURLに変えてほしい
        endpoint: Urls.wentPlace, method: HttpMethod.get);

    final latitude = locationData['Latitude'];
    final longitude = locationData['Longitude'];

    return LatLng(latitude, longitude);
  } catch (e) {
    return LatLng(34.706463, 135.503209); // デフォルト位置
  }
});

// ピンデータを取得するプロバイダー
final pinProvider = FutureProvider<List<Marker>>((ref) async {
  try {
    final pins = await RequestHandler.requestWithAuth(
        endpoint: Urls.wentPlace, method: HttpMethod.get);

    List<Marker> addPins = [];
    for (var item in pins) {
      final latitude = item['Latitude'];
      final longitude = item['Longitude'];
      final name = item['RestaurantName'];

      addPins.add(
        Marker(
          point: LatLng(latitude, longitude),
          width: 50.0,
          height: 50.0,
          child: Tooltip(
            message: name,
            child: const Icon(Icons.location_on, color: Colors.red, size: 50.0),
          ),
          rotate: false,
        ),
      );
    }
    return addPins;
  } catch (e) {
    return [];
  }
});

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinAsyncValue = ref.watch(pinProvider);
    final locationAsyncValue = ref.watch(locationProvider);

    return PageTemplate(
      pageTitle: '行ったところマップ',
      onInit: () {
        ref.invalidate(pinProvider);
        ref.invalidate(locationProvider);
      },
      isExpanded: true,
      child: Stack(
        children: [
          locationAsyncValue.when(
            data: (currentLocation) => FlutterMap(
              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 15.0,
                maxZoom: 18.0,
                minZoom: 8.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                pinAsyncValue.when(
                  data: (pins) => MarkerLayer(markers: [
                    ...pins,
                    Marker(
                      point: currentLocation,
                      width: 50.0,
                      height: 50.0,
                      child: const Icon(Icons.my_location, color: Colors.blue, size: 50.0),
                    ),
                  ]),
                  error: (err, stack) =>
                      const Center(child: Text("ピンの取得に失敗しました")),
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
            error: (err, stack) =>
                const Center(child: Text("現在地の取得に失敗しました")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
