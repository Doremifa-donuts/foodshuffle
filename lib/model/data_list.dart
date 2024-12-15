// HomePageのリスト要素
// homeReviewのデータクラス
class HomeStore {
  final String Images; // 店画像
  final String RestaurantName; // 店名
  final String Address; // 住所
  final String Comment; // 口コミ
  final String CreatedAt; // 投稿日
  final int goods; // いいね数

  // コンストラクタで必要なデータを受け取る
  HomeStore({
    required this.Images,
    required this.RestaurantName,
    required this.Address,
    required this.Comment,
    required this.CreatedAt,
    required this.goods,
  });
}

// GroupPageのリスト要素
// groupのデータクラス
class Group {
  final String PopupGroupName; // グループ名
  final String ExpirationDate; // 期限日
  final List<String> Icon; // アイコン画像パス（リスト形式で保存する）

  // コンストラクタで必要なデータを受け取る
  Group({
    required this.PopupGroupName,
    required this.ExpirationDate,
    required this.Icon,
  });
}

// ReviewPageのリスト要素
// ReviewStoreのデータクラス
class ReviewStore {
  final String Images; // 店画像
  final String RestaurantName; // 店名
  final String Tell; // 電話番号
  final String Address; // 住所

  // コンストラクタで必要なデータを受け取る
  ReviewStore({
    required this.Images,
    required this.RestaurantName,
    required this.Tell,
    required this.Address,
  });
}

// ArchivePageのリスト要素
// ArchiveStoreのデータクラス
class ArchiveStore {
  final String Images;
  final String RestaurantName;
  final String CreatedAt;
  final String Icon;
  final String Comment;

  ArchiveStore({
    required this.Images,
    required this.RestaurantName,
    required this.CreatedAt,
    required this.Icon,
    required this.Comment,
  });

  // HomeStore から変換するファクトリコンストラクタ
  factory ArchiveStore.fromHomeStore(HomeStore homeStore) {
    return ArchiveStore(
      Images: homeStore.Images,
      RestaurantName: homeStore.RestaurantName,
      CreatedAt: homeStore.CreatedAt,
      Icon: '', // 必要に応じて適切な値を設定
      Comment: homeStore.Comment,
    );
  }
}

// UserPageのリスト要素
// Userのデータクラス
class User {
  final String UserName; // ユーザー名
  final String Icon; // プロフィールアイコン画像パス
  final int goods; // いいね数
  final int range; // 範囲
  final int store; // 店数

  // コンストラクタで必要なデータを受け取る
  User({
    required this.UserName,
    required this.Icon,
    required this.goods,
    required this.range,
    required this.store,
  });
}

// QRPageのリスト要素
class QrStore {
  final String Images;
  final String RestaurantName;
  final String CreatedAt;
  final String Comment;
  final int goods;

  QrStore({
    required this.Images,
    required this.RestaurantName,
    required this.CreatedAt,
    required this.Comment,
    required this.goods,
  });

  // HomeStore から変換するファクトリコンストラクタ
  factory QrStore.fromHomeStore(HomeStore homeStore) {
    return QrStore(
      Images: homeStore.Images,
      RestaurantName: homeStore.RestaurantName,
      CreatedAt: homeStore.CreatedAt,
      Comment: homeStore.Comment,
      goods: homeStore.goods,
    );
  }
}
