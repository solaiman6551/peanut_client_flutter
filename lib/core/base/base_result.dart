enum Status { success, error }

class BaseResult<T> {

  BaseResult({
    this.statusCode,
    required this.status,
    required this.data,
    required this.message,
    required this.code
  });

  late final int? statusCode;
  late final Status status;
  final T? data;
  late final String message;
  late final dynamic code;

  static BaseResult<T> success<T>(dynamic code, T? data) {
    return BaseResult(
        status: Status.success,
        data: data,
        message: '',
        code: code
    );
  }

  static BaseResult<T> error<T>(dynamic code, String message) {
    return BaseResult(
      status: Status.error,
      data: null,
      code: code,
      message: message,
    );
  }

}
