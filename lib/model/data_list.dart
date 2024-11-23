// HomePageのリスト要素
// homeReviewのデータクラス
class HomeStore {
  final String storeImage; // 店画像
  final String name; // 店名
  final String address; // 住所
  final String message; // 口コミ
  final String days; // 投稿日
  final int goods; // いいね数

  // コンストラクタで必要なデータを受け取る
  HomeStore({
    required this.storeImage,
    required this.name,
    required this.address,
    required this.message,
    required this.days,
    required this.goods,
  });
}

// GroupPageのリスト要素
// groupのデータクラス
class Group {
  final String name; // グループ名
  final String deadline; // 期限日
  final List<String> memberIcons; // アイコン画像パス（リスト形式で保存する）

  // コンストラクタで必要なデータを受け取る
  Group({
    required this.name,
    required this.deadline,
    required this.memberIcons,
  });
}

// ReviewPageのリスト要素
// ReviewStoreのデータクラス
class ReviewStore {
  final String storeImage; // 店画像
  final String name; // 店名
  final String tel; // 電話番号
  final String address; // 住所

  // コンストラクタで必要なデータを受け取る
  ReviewStore({
    required this.storeImage,
    required this.name,
    required this.tel,
    required this.address,
  });
}

// ArchivePageのリスト要素
// ArchiveStoreのデータクラス
class ArchiveStore {
  final String storeImage; // 店画像
  final String name; // 店名
  final String days; // 投稿日
  final String memberIcon; // 投稿者のアイコン画像パス
  final String message; // 口コミ

  // コンストラクタで必要なデータを受け取る
  ArchiveStore({
    required this.storeImage,
    required this.name,
    required this.days,
    required this.memberIcon,
    required this.message,
  });
}

// UserPageのリスト要素
// Userのデータクラス
class User {
  final String name; // ユーザー名
  final String userIcon; // プロフィールアイコン画像パス
  final int goods; // いいね数
  final int range; // 範囲
  final int store; // 店数

  // コンストラクタで必要なデータを受け取る
  User({
    required this.name,
    required this.userIcon,
    required this.goods,
    required this.range,
    required this.store,
  });
}
