import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/base/base_data_source.dart';
import '../../../../core/base/base_result.dart';
import '../../../../core/di/network_provider.dart';
import '../../../../utils/api_urls.dart';
import 'model/get_phone_number_request.dart';
import 'model/get_phone_number_response.dart';


abstract class GetPhoneNumberDataSource {
  Future<BaseResult<GetPhoneNumberResponse>> getPhoneNumber(GetPhoneNumberRequest getPhoneNumberRequest);
}

class GetPhoneNumberDataSourceImpl extends BaseDataSource implements GetPhoneNumberDataSource {
  GetPhoneNumberDataSourceImpl(super.dio);

  @override
  Future<BaseResult<GetPhoneNumberResponse>> getPhoneNumber(GetPhoneNumberRequest getPhoneNumberRequest) {
    return getResult(
        post(ApiUrls.getLastFourNumbersPhone,
            getPhoneNumberRequest.toJson()),
            (response) => GetPhoneNumberResponse.fromJson(response)
    );
  }
}

final getPhoneNumberDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return GetPhoneNumberDataSourceImpl(dio);
});
