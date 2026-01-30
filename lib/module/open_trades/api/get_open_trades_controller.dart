import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/safe_api_call/safe_api_call.dart';
import 'get_open_trades_data_source.dart';
import 'model/get_open_trades_request.dart';
import 'model/get_open_trades_response.dart';


class GetOpenTradesController extends StateNotifier<AsyncValue<GetOpenTradesResponse>> {

  Logger get log => Logger(runtimeType.toString());
  final Ref _ref;

  GetOpenTradesController(this._ref) : super(AsyncData(GetOpenTradesResponse()));

  Future<void> getOpenTradesList(GetOpenTradesRequest getOpenTradesRequest) async {
    try {
      state = const AsyncLoading();

      final response = await _ref.read(getOpenTradesDataSourceProvider).getOpenTradesList(getOpenTradesRequest);

      safeApiCall<GetOpenTradesResponse>(response, onSuccess: (response) {

        state = AsyncData(response!);

      }, onError: (code, message) {
        state = AsyncError(message, StackTrace.current);
      });

    } on Failure {
      state = AsyncError("error",StackTrace.current);
    }
  }
}

final getOpenTradesControllerProvider =
StateNotifierProvider<GetOpenTradesController, AsyncValue<GetOpenTradesResponse>>((ref) {
  return GetOpenTradesController(ref);
});