// HTTPステータスコードによってエラーをハンドリングできる簡易的なカスタムエラー
class Errors implements Exception {
  final String message;
  final int errorCode;
  Errors(this.message, {this.errorCode = 0});

  @override
  String toString() => 'Errors: $message';

  int getErrorCode() => errorCode;
}
