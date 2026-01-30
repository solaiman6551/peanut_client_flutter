import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/safe_api_call/safe_api_call.dart';
import 'get_phone_number_data_source.dart';
import 'model/get_phone_number_request.dart';
import 'model/get_phone_number_response.dart';


class GetPhoneNumberController extends StateNotifier<AsyncValue<GetPhoneNumberResponse>> {

  Logger get log => Logger(runtimeType.toString());
  final Ref _ref;

  GetPhoneNumberController(this._ref) : super(AsyncData(GetPhoneNumberResponse()));

  Future<void> getPhoneNumber(GetPhoneNumberRequest getPhoneNumberRequest) async {
    try {
      state = const AsyncLoading();

      final response = await _ref.read(getPhoneNumberDataSourceProvider).getPhoneNumber(getPhoneNumberRequest);

      safeApiCall<GetPhoneNumberResponse>(response, onSuccess: (response) {

        state = AsyncData(response!);

      }, onError: (code, message) {
        state = AsyncError(message, StackTrace.current);
      });

    } on Failure {
      state = AsyncError("error",StackTrace.current);
    }
  }
}

final getPhoneNumberControllerProvider =
StateNotifierProvider<GetPhoneNumberController, AsyncValue<GetPhoneNumberResponse>>((ref) {
  return GetPhoneNumberController(ref);
});