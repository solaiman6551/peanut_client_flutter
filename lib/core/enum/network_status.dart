enum NetworkStatus {
  success(200),
  clearAndGotoStart(500),
  error(401);

  final int value;
  const NetworkStatus(this.value);

  int get code => value;

  factory NetworkStatus.toCode(int code) {
    for (var value in NetworkStatus.values) {
      if (value.code == code) return value;
    }
    throw 'Unknown Status Code --> $code';
  }
}
