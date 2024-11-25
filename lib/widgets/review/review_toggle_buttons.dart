import 'package:flutter/material.dart';
import '../../model/color.dart';

class ReviewToggleButtons extends StatelessWidget {
  final VoidCallback onPendingPressed;
  final VoidCallback onReviewedPressed;

  const ReviewToggleButtons({
    Key? key,
    required this.onPendingPressed,
    required this.onReviewedPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: onPendingPressed,
            style: TextButton.styleFrom(
              foregroundColor: const Color(textMainColor), // テキスト色
            ),
            child: const Text('レビュー未'),
          ),
          TextButton(
            onPressed: onReviewedPressed,
            style: TextButton.styleFrom(
              foregroundColor: const Color(textMainColor), // テキスト色
            ),
            child: const Text('レビュー済'),
          ),
        ],
      ),
    );
  }
}
