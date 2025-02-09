import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/reservation/reservation.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart';
import '../widgets/footer.dart';
import '../model/color.dart';
import '../widgets/swipe_card/swipe_handler.dart';
import 'booking.dart'; // 予約ページ

// データを返すプロバイダ
final swipeAsyncNotifierProvider =
    FutureProvider<List<ReviewCard>>((ref) async {
  try {
    final data = await RequestHandler.jsonWithAuth(
        endpoint: Urls.receivesReview, method: HttpMethod.get);

    List<ReviewCard> cards = [];
    for (var item in data) {
      cards.add(ReviewCard.fromJson(item));
    }
    return cards;
  } catch (e) {
    return [];
  }
});

// 予約の状態を管理
final reservationProvider = FutureProvider<List<Reservation>>((ref) async {
  // 店舗名と予約時間の情報を保持
  List<Reservation> reservations = [];
  try {
    final data = await RequestHandler.jsonWithAuth(
        endpoint: Urls.upcomingsReservation, method: HttpMethod.get);
    // debugPrint('0番だけ');
    // debugPrint(data[0].toString());
    for (var item in data) {
      reservations.add(Reservation.fromJson(item));
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return reservations;
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

    // Future.microtask(() {
    //   ref.refresh(swipeAsyncNotifierProvider);
    // });
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

    return PageTemplate(
        pageTitle: 'ホーム',
        onInit: () {
          ref.invalidate(swipeAsyncNotifierProvider);
          ref.invalidate(reservationProvider);
        },
        child: Stack(children: [
          asyncValue.when(
            data: (stores) =>
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
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'エラーが発生しました。\n詳細: $error\n$stack',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          reservation.when(
            data: (reservation) => _buildReservationInfo(reservation),
            error: (error, stack) => Text(
              '予約情報の取得に失敗しました',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          )
        ]));
  }

  // 予約情報の表示
  Widget _buildReservationInfo(List<Reservation> reservations) {
    return Positioned(
      top: 10,
      left: 20,
      right: 20,
      height: 75,
      child: GestureDetector(
      onTap: () {
        if (reservations.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingPage(),
            ),
          );
        }
      },
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
            padding: EdgeInsets.all(10),
            child: reservations.isEmpty
                ? Text(
                    '予約はありません',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '予約店舗: ${reservations[0].RestaurantName}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '予約時間: ${DateFormat("yyyy/MM/dd HH時mm分").format(reservations[0].ReservationDate.toLocal())}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  )),
      ),
      ),
    );
  }
}
