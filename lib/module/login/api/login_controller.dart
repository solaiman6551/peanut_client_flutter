import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/safe_api_call/safe_api_call.dart';
import 'login_data_source.dart';
import 'model/login_request.dart';
import 'model/login_response.dart';


class LoginController extends StateNotifier<AsyncValue<LoginResponse>> {

  Logger get log => Logger(runtimeType.toString());

  final Ref _ref;

  LoginController(this._ref) : super(AsyncData(LoginResponse()));

  Future<void> login(LoginRequest loginRequest) async {
    try {
      state = const AsyncLoading();

      final response = await _ref.read(loginDataSourceProvider).login(loginRequest);

      safeApiCall<LoginResponse>(response, onSuccess: (response) {

        state = AsyncData(response!);

      }, onError: (code, message) {
        state = AsyncError(message, StackTrace.current);
      });

    } on Failure {
      state = AsyncError("error",StackTrace.current);
    }
  }
}

final loginControllerProvider =
StateNotifierProvider<LoginController, AsyncValue<LoginResponse>>((ref) {
  return LoginController(ref);
});