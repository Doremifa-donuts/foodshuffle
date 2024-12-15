// すべてのエンドポイントに関するURLを定義しておく
class Urls {
  // 接続するサーバのIPアドレス

  // 通信プロトコル
  static const _http = "http://";
  static const _ws = "ws://";

  // ホスト
  static const String _host = "localhost";

  // ポート
  static const int _port = 5678;

  // APIバージョン
  static const String _versionOne = "/v1";

  // ベースURL
  static const String _baseUrl = '$_http$_host:$_port$_versionOne';

  // 各種エンドポイント

  // 位置情報共有をするエンドポイント
  static const String location = '$_ws$_host:$_port$_versionOne/auth/users/locations';
}
