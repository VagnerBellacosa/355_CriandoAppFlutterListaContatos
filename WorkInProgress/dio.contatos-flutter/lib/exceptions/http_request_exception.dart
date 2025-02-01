class HttpRequestException implements Exception {
  final String _message;

  HttpRequestException(this._message);

  String get message => _message;

  @override
  String toString() {
    return "HttpRequestException: $message";
  }
}
