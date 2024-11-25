import 'package:flutter/material.dart';
import 'package:foodshuffle/model/data_list.dart';

class SwipeCard extends StatelessWidget {
  final HomeStore store;

  const SwipeCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.asset(
              store.Images,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.RestaurantName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  store.Address,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(store.Comment, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('投稿日: ${store.CreatedAt}',
                        style: const TextStyle(fontSize: 14)),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up, size: 18),
                        const SizedBox(width: 4),
                        Text('${store.goods}',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
