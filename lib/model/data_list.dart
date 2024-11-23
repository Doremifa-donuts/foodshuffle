// homePageのリスト要素
// ignore: camel_case_types
class homeStore {
  final String storeImage;
  final String name;
  final String address;
  final String message;
  final String days;
  final int goods;

  homeStore({
    required this.storeImage,
    required this.name,
    required this.address,
    required this.message,
    required this.days,
    required this.goods,
  });
}

// groupPageのリスト要素
// グループデータクラス
class Group {
  final String name; // グループ名
  final String deadline; // 期限日
  final List<String> memberIcons; // メンバーのアイコン画像パス

  // コンストラクタ
  Group({
    required this.name,
    required this.deadline,
    required this.memberIcons,
  });
}
