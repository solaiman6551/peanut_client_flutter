import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/safe_api_call/safe_api_call.dart';
import 'get_account_info_data_source.dart';
import 'model/get_account_info_request.dart';
import 'model/get_account_info_response.dart';


class GetAccountInfoController extends StateNotifier<AsyncValue<GetAccountInfoResponse>> {

  Logger get log => Logger(runtimeType.toString());
  final Ref _ref;

  GetAccountInfoController(this._ref) : super(AsyncData(GetAccountInfoResponse()));

  Future<void> getAccountInfo(GetAccountInfoRequest getAccountInfoRequest) async {
    try {
      state = const AsyncLoading();

      final response = await _ref.read(getAccountInfoDataSourceProvider).getAccountInfo(getAccountInfoRequest);

      safeApiCall<GetAccountInfoResponse>(response, onSuccess: (response) {

        state = AsyncData(response!);

      }, onError: (code, message) {
        state = AsyncError(message, StackTrace.current);
      });

    } on Failure {
      state = AsyncError("error",StackTrace.current);
    }
  }
}

final getAccountInfoControllerProvider =
StateNotifierProvider<GetAccountInfoController, AsyncValue<GetAccountInfoResponse>>((ref) {
  return GetAccountInfoController(ref);
});