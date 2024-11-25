import 'package:flutter/material.dart';

class ReviewToggleButtons extends StatelessWidget {
  final VoidCallback onPendingPressed;
  final VoidCallback onReviewedPressed;
  final ButtonStyle? pendingButtonStyle;
  final ButtonStyle? reviewedButtonStyle;

  const ReviewToggleButtons({
    super.key,
    required this.onPendingPressed,
    required this.onReviewedPressed,
    this.pendingButtonStyle,
    this.reviewedButtonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // レビュー未ボタン
          TextButton(
            onPressed: onPendingPressed,
            style: pendingButtonStyle ??
                TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            child: const Text('レビュー未'),
          ),
          // レビュー済ボタン
          TextButton(
            onPressed: onReviewedPressed,
            style: reviewedButtonStyle ??
                TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            child: const Text('レビュー済'),
          ),
        ],
      ),
    );
  }
}
