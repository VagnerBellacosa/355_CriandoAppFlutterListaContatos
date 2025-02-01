class NotFoundException implements Exception {
  final String _message;

  NotFoundException(this._message);

  String get message => _message;

  @override
  String toString() {
    return "NotFoundException: $message";
  }
}
