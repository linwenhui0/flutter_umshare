class Result {
  int code;
  String message;

  Result({this.code, this.message});

  @override
  String toString() {
    return '{"code":$code,"message":$message}';
  }
}
