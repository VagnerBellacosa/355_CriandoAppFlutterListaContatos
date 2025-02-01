class BadRequestException implements Exception {
  final String _message;

  BadRequestException(this._message);

  String get message => _message;

  @override
  String toString() {
    return "BadRequestException: $message";
  }
}
