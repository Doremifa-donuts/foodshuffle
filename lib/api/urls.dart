// すべてのエンドポイントに関するURLを定義しておく
class Urls {
  // 接続するサーバのIPアドレス

  // 通信プロトコル
  static const _http = "http://";
  static const _ws = "ws://";

  // ホスト
  static const String _host = "M2.local";

  // ポート
  static const int _port = 5678;

  // APIバージョン
  static const String _versionOne = "/v1";

  // ベースURL
  static const String _baseUrl = '$_http$_host:$_port$_versionOne';

  // 各種エンドポイント

  // 位置情報共有をするエンドポイント
  static const String location =
      '$_ws$_host:$_port$_versionOne/auth/users/locations';
  static const String images = '$_baseUrl/auth/images/';

  // 受け取ったレビューを選別するために取得
  static const String receivesReview = '$_baseUrl/auth/users/reviews/recieves';
  // 興味ありに設定したレビューを取得 (アーカイブ)
  static const String archivesReview = '$_baseUrl/auth/users/reviews/interests';

  // レビューをいいねする
  static String likeReview(String reviewUuid) =>
      '$_baseUrl/auth/users/reviews/$reviewUuid/status/liked';
  // レビューを興味ありにする (アーカイブ)
  static String interestedReview(String reviewUuid) =>
      '$_baseUrl/auth/users/reviews/$reviewUuid/status/interested';
  // レビューを興味なしにする
  static String notInterestedReview(String reviewUuid) =>
      '$_baseUrl/auth/users/reviews/$reviewUuid/status/not_interested';

  // 訪問済みでレビューをしていない店舗
  static String beforeReview = '$_baseUrl/auth/users/restaurants/visited';
  // レビュー投稿済みの店舗
  static String afterReview = '$_baseUrl/auth/users/restaurants/reviewed';
  // レビューを投稿する
  static String postReview = '$_baseUrl/auth/users/reviews/post';
}
