import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/main.dart';
import 'package:foodshuffle/model/reservation/reservation.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/model/urgent_campaign/urgent_campaign.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    if (data == null) {
      return cards;
    }
    for (var item in data) {
      cards.add(ReviewCard.fromJson(item));
    }
    return cards;
  } catch (e) {
    return [];
  }
});

// 予約の状態を管理
// リマインダーに表示する内容を取得
final reminderProvider = FutureProvider<Widget>((ref) async {
  // お助けブーストを受け取っているかを確かめる
  final pref = await SharedPreferences.getInstance();
  final boostString = pref.getString("boost");
  late Widget info;
  VoidCallback? onTap;
  bool infoSet = false;

  if (boostString != null) {
    final boost = jsonDecode(boostString);
    try {
      // お助けブーストの詳細を取得する
      final data = await RequestHandler.jsonWithAuth(
          endpoint: Urls.urgentCampaign(boost["BoostUuid"]),
          method: HttpMethod.get);
      // 取得したデータをキャンペーンとして扱う
      final campaign = UrgentCampaign.fromJson(data);
      debugPrint(data.toString());
      // キャンペーンが終了していない場合
      if (campaign.EndAt.isAfter(DateTime.now())) {
        info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'お助け要請: ${boost["RestaurantName"]}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '時間: ${DateFormat("HH時mm分まで").format(campaign.EndAt)}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        );
        infoSet = true;
      } else {
        // 終わっていたら削除する
        await pref.remove("boost");
        debugPrint("時間が終わっていた");
      }
    } catch (e) {
      debugPrint(e.toString());
      // セットされているキーのアイテムがなかった場合はエラー回避のためキーを削除する
      await pref.remove("boost");
    }
  }
  debugPrint(infoSet.toString());
  if (!infoSet) {
    // 店舗名と予約時間の情報を保持
    try {
      final data = await RequestHandler.jsonWithAuth(
          endpoint: Urls.upComingsReservation, method: HttpMethod.get);
      // 予約している店があるかを確認する

      if (data != null) {
        final reservation = Reservation.fromJson(data[0]);
        // 予約があった場合のウィジェット
        info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '予約店舗: ${reservation.RestaurantName}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '予約時間: ${DateFormat("yyyy/MM/dd HH時mm分").format(reservation.ReservationDate.toLocal())}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        );
        onTap = () {
          Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => BookingPage(),
            ),
          );
        };
      } else {
        debugPrint("なぜかここ");
        info = Text('お知らせはありません',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
      }
    } catch (e) {
      debugPrint(e.toString());

      info = Text(
        '情報の取得に失敗しました',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    }
  }

  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: const Color(listColor),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(allListColor),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(padding: EdgeInsets.all(10), child: info),
    ),
  );
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
    final remind = ref.watch(reminderProvider);

    return PageTemplate(
        pageTitle: 'ホーム',
        onInit: () {
          ref.invalidate(swipeAsyncNotifierProvider);
          ref.invalidate(reminderProvider);
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
          remind.when(
            data: (remindDetail) => _buildReservationInfo(remindDetail),
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
  Widget _buildReservationInfo(Widget remindDetail) {
    return Positioned(
        top: 10, left: 20, right: 20, height: 75, child: remindDetail);
  }
}
