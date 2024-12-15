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
import '../screens/reservation/booking.dart'; // 予約ページ
import '../data/home.dart';

// データを返すプロバイダ
final swipeAsyncNotifierProvider = FutureProvider<List<HomeStore>>((ref) async {
  return homeStoreList; // 別ファイルからデータを呼び出す
});

// 予約の状態を管理
final reservationProvider = StateProvider<Map<String, String?>>((ref) {
  return {}; // 店舗名と予約時間の情報を保持
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
          RestaurantUuid: data['Response']['Data'][index]['RestaurantUuid'],
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
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late AppinioSwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = AppinioSwiperController();

    Future.microtask((){
      ref.refresh(swipeAsyncNotifierProviderByDatabase);
    });
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(swipeAsyncNotifierProviderByDatabase);
    final reservation = ref.watch(reservationProvider);

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
            _buildReservationInfo(reservation),
            // お店の表示カード
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

  // 予約情報の表示
  Widget _buildReservationInfo(Map<String, String?> reservation) {
    if (reservation.isEmpty || reservation['store'] == null) {
      return Positioned(
        top: 10,
        left: 20,
        right: 20,
        child: Card(
          color: const Color(listColor),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(allListColor),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '予約はありません',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        top: 30,
        left: 20,
        right: 20,
        child: Card(
          color: const Color(listColor),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(allListColor),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '予約店舗: ${reservation['store']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '予約時間: ${reservation['time']}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  // 予約ページへの遷移処理
  Future<void> navigateToReservation(HomeStore store) async {
    final archiveStore = ArchiveStore.fromHomeStore(store);

    final result = await Navigator.push<Map<String, String?>>(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationPage(store: archiveStore),
      ),
    );

    if (result != null) {
      ref.read(reservationProvider.notifier).state = result;
    }
  }

  // WebSocketを確立し、位置情報の送信を行う
  // FIXME: Websocketによる位置情報の通信はすべての画面で行われるべき
  
}
