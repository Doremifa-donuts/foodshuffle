import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../widgets/footer.dart';
import '../model/data_list.dart';
import '../model/color.dart';
import '../widgets/swipe_handler.dart';
import '../screens/reservation/booking.dart'; // 予約ページ

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

// 予約の状態を管理
final reservationProvider = StateProvider<Map<String, String?>>((ref) {
  return {}; // 店舗名と予約時間の情報を保持
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
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(swipeAsyncNotifierProvider);
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
}
