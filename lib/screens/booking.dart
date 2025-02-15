import 'package:flutter/material.dart';
// 動的に状態把握

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/reservation/reservation.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart';
// カラー、画像パス
import '../../model/color.dart';

// プロバイダーの定義（データ取得を切り替え）
// 予約の状態を管理
final reservationProvider = FutureProvider<List<Reservation>>((ref) async {
  // 店舗名と予約時間の情報を保持
  List<Reservation> reservations = [];
  try {
    final data = await RequestHandler.jsonWithAuth(
        endpoint: Urls.upComingsReservation, method: HttpMethod.get);
    // debugPrint('0番だけ');
    // debugPrint(data[0].toString());
    if (data == null) {
      return reservations;
    }
    for (var item in data) {
      reservations.add(Reservation.fromJson(item));
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return reservations;
});

// 予約画面
class BookingPage extends ConsumerWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 予約のデータを取得
    final reservation = ref.watch(reservationProvider);
    return PageTemplate(
      pageTitle: '予約一覧',
      onInit: () {
        ref.invalidate(reservationProvider);
      },
      child: reservation.when(
          data: (reservations) {
            return reservations.isEmpty
                ? const Center(child: Text("予約ははありません！"))
                :
                // スクロール要素
                Scrollbar(
                    thickness: 12, // スクロールバーの太さ
                    radius: const Radius.circular(20), // スクロールバーの角を丸く
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20), // リストのパディングを指定
                      // リスト要素
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8), // 各リストアイテム間のスペース
                      itemCount: reservations.length, // リストアイテムの数
                      // 各リストアイテム
                      itemBuilder: (context, index) {
                        return _buildReservationCard(
                            context, reservations[index]);
                      },
                    ),
                  );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()), // 読み込み中
          error: (err, stack) {
            debugPrint(err.toString());
            debugPrint(stack.toString());
            return Center(child: Text('エラーが発生しました: $err')); // エラー時
          }),
    );
  }

  // Storeの情報を元に、各ストアの詳細情報を表示するカードをビルド
  // 予約情報のカードを作成
  Widget _buildReservationCard(BuildContext context, Reservation reservation) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ReservationDetailPage(reservation: reservation),
          ),
        );
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '店舗名: ${reservation.RestaurantName}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                '予約時間: ${DateFormat("yyyy/MM/dd HH:mm").format(reservation.ReservationDate.toLocal())}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 予約詳細画面
class ReservationDetailPage extends ConsumerWidget {
  final Reservation reservation;

  const ReservationDetailPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      pageTitle: '予約詳細',
      onInit: () {
        // 予約のリフレッシュ処理や初期化をここに追加することができます
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            '店舗名: ${reservation.RestaurantName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '予約時間: ${DateFormat("yyyy/MM/dd HH:mm").format(reservation.ReservationDate.toLocal())}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          // const SizedBox(height: 16),
          // Text(
          //   '特別リクエスト: ${reservation.SpecialRequest ?? 'なし'}',
          //   style: const TextStyle(fontSize: 18, ),
          // ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // 予約の変更やキャンセルの処理を追加することができます
            },
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            child: const Text('予約を変更/キャンセル'),
          ),
        ],
      ),
    );
  }
}


// お店の情報も載せれてらいいな