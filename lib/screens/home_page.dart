import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../widgets/footer.dart';
import '../model/data_list.dart';
import '../model/color.dart';
import '../widgets/swipe_handler.dart';
// httpリクエスト用のモジュール
import 'package:http/http.dart' as http;
// jsonDecodeを有効化
import 'dart:convert';
// Jtiトークンを使用するためのモジュール
import 'package:shared_preferences/shared_preferences.dart';
//envファイルを読み込むためのモジュール
import 'package:flutter_dotenv/flutter_dotenv.dart';

final swipeAsyncNotifierProvider = FutureProvider<List<HomeStore>>((ref) async {
  return List.generate(30, (index) {
    return HomeStore(
      Images: 'images/store/store_1.png',
      RestaurantName: 'Store ${String.fromCharCode(65 + index)}',
      Address: 'Street ${index + 1}, City',
      Comment: 'Fresh and delicious! ${index + 1}',
      CreatedAt: '2024-11-${20 + index}',
      goods: 120 + index,
    );
  });
});

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token'); // 'auth_token'キーからトークンを取得
}

final swipeAsyncNotifierProviderByDatabase = FutureProvider<List<HomeStore>>((ref) async {
  final token = await _getToken();
  if(token == null){
    throw Exception('jti token is null');
  } else {
    //httpリクエストでレビューを取得
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/auth/users/reviews/recieves'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //httpリクエストに成功した場合
    if (response.statusCode == 200) {
      //レスポンスをJSON形式に変換
      final data = json.decode(response.body);

      if (data['Response']['Data'] == null || data['Response']['Data'] is! List) {
        return []; // データが空の場合は空リストを返す
      }
      //レスポンスから店舗情報を取得
      return List.generate(data['Response']['Data'].length, (index) {
        return HomeStore(
          Images: data['Response']['Data'][index]['Images'] ?? 'images/store/store_1.png', // 画像がない場合デフォルトの画像を使用
          RestaurantName: data['Response']['Data'][index]['RestaurantName'],
          Address: data['Response']['Data'][index]['Address'],
          Comment: data['Response']['Data'][index]['Comment'],
          CreatedAt: data['Response']['Data'][index]['PostedAt'],
          goods: data['Response']['Data'][index]['Goods'],
        );
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late AppinioSwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = AppinioSwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(swipeAsyncNotifierProviderByDatabase);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ホーム',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(mainColor),
      ),
      body: asyncValue.when(
        data: (stores) => Stack(
          children: [
            _buildBackground(),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SwipeHandler(
                  controller: _swiperController,
                  stores: stores,
                ),
              ),
            ),
            const Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Footer(),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'エラーが発生しました。\n詳細: $error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backimg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
