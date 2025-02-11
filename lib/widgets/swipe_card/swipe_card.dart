import 'package:flutter/material.dart';
import 'package:foodshuffle/model/review_card/review_card.dart';
import 'package:foodshuffle/widgets/auth_image.dart';
import 'package:intl/intl.dart';

class SwipeCard extends StatelessWidget {
  final ReviewCard reviewCard;

  const SwipeCard({
    super.key,
    required this.reviewCard,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // アイコンを中央に配置
      children: [
        Card(
          elevation: 4.0,
          margin: const EdgeInsets.only(
              top: 80.0, bottom: 10.0, left: 10.0, right: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RepaintBoundary(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: AuthImage(
                    imagePath: reviewCard.Images[0],
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewCard.RestaurantName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reviewCard.Address,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 110,
                      child: Text(
                        reviewCard.Comment,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '投稿日: ${DateFormat("yyyy/MM/dd hh:mm").format(reviewCard.CreatedAt)}',
                            style: const TextStyle(fontSize: 14)),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up, size: 18),
                            const SizedBox(width: 4),
                            Text(reviewCard.Good.toString(),
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
        ),
      ],
    );
  }
}
