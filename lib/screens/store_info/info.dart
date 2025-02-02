import 'package:flutter/material.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/widgets/auth_icon.dart';
import 'package:foodshuffle/widgets/auth_image.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart';
import '../../model/color.dart';
import '../reservation/booking.dart'; // 予約ページ

class StoreDetailPage extends StatelessWidget {
  final ReviewCard store;
  const StoreDetailPage({super.key, required this.store});
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // appBar: AppBar(
        //   title: Text(store.RestaurantName,
        //       style: const TextStyle(fontWeight: FontWeight.bold)),
        //   backgroundColor: const Color(mainColor),
        // ),
        // body:
        PageTemplate(
            pageTitle: store.RestaurantName,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        itemCount: store.Images.length,
                        itemBuilder: (context, index) {
                          return AuthImage(
                            imagePath: store.Images[index],
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      store.RestaurantName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    Text(
                      store.Comment,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('投稿者:', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        AuthIcon(imagePath: store.Icon)
                      ],
                    ),
                    Text(
                      '投稿日: ${DateFormat("yyyy/MM/dd hh:mm").format(store.CreatedAt)}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReservationPage(restaurantUuid: store.RestaurantUuid,),
                            ),
                          );
                        },
                        child: const Text('予約する'),
                      ),
                    ),
                  ],
                ),
              ),
            ));
    // );
  }
}
