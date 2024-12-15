import 'package:flutter/material.dart';
import '../../model/color.dart';
import '../../model/data_list.dart';
import '../reservation/booking.dart'; // 予約ページ

class StoreDetailPage extends StatelessWidget {
  final ArchiveStore store;

  const StoreDetailPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store.RestaurantName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(mainColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  store.Images,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  fit: BoxFit.cover,
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
              Text(
                '投稿日: ${store.CreatedAt}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
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
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(store.Icon),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationPage(store: store),
                      ),
                    );
                  },
                  child: const Text('予約する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
