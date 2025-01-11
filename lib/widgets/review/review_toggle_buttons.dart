import 'package:flutter/material.dart';

class ReviewToggleButtons extends StatefulWidget {
  final VoidCallback onPendingPressed;
  final VoidCallback onReviewedPressed;
  final bool isPending; // レビュー前であることを表すステータス

  const ReviewToggleButtons(
      {super.key,
      required this.onPendingPressed,
      required this.onReviewedPressed,
      required this.isPending});

  @override
  State<StatefulWidget> createState() => _ReviewToggleButton();
}

class _ReviewToggleButton extends State<ReviewToggleButtons> {
  // ボタンが選択されている時の見た目
  ButtonStyle selected() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 32,
      ),
      textStyle: const TextStyle(
        fontFamily: 'uzura',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  // 非選択状態の見た目
  ButtonStyle unselected() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      textStyle: const TextStyle(fontFamily: 'uzura', fontSize: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // レビュー未ボタン
          TextButton(
            onPressed: widget.onPendingPressed,
            style: widget.isPending ? selected() : unselected(),
            child: const Text('レビュー未'),
          ),
          // レビュー済ボタン
          TextButton(
            onPressed: widget.onReviewedPressed,
            style: widget.isPending ? unselected() : selected(),
            child: const Text('レビュー済'),
          ),
        ],
      ),
    );
  }
}
