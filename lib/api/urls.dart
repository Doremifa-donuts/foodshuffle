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
  static const String receives = '$_baseUrl/auth/users/reviews/recieves';
  static const String images = '$_baseUrl/auth/images/';
  // レビューをいいねする
  static String likeReview(String reviewUuid) =>
      '$_baseUrl/auth/users/reviews/$reviewUuid/status/liked';
  // レビューを興味ありにする (アーカイブ)
  static String interestedReview(String reviewUuid) =>
      '$_baseUrl/auth/users/reviews/$reviewUuid/status/interested';
  // レビューを興味なしにする
  static String notInterestedReview(String reviewUuid) =>
      '$_baseUrl/auth/users/reviews/$reviewUuid/status/not_interested';
}
