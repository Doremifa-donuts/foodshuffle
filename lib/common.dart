import 'package:flutter/material.dart';

// 画像パス
const String backImg = 'images/backimg.jpg';
const String unionImg = 'images/Union.png';

// カラーコード
const String mainColor = '#E9CCA7';
const String iconColor = '#EBF6DD';

class ColorUtils {
  // 16進数カラーコードをColor型に変換する静的関数
  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', ''); // '#'を取り除く
    if (hex.length == 6) {
      hex = 'FF$hex'; // 不透明度を追加
    }
    return Color(int.parse(hex, radix: 16));
  }
}
