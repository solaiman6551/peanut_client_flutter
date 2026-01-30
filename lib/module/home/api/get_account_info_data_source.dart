import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/base/base_data_source.dart';
import '../../../../core/base/base_result.dart';
import '../../../../core/di/network_provider.dart';
import '../../../../utils/api_urls.dart';
import 'model/get_account_info_request.dart';
import 'model/get_account_info_response.dart';


abstract class GetAccountInfoDataSource {
  Future<BaseResult<GetAccountInfoResponse>> getAccountInfo(GetAccountInfoRequest getAccountInfoRequest);
}

class GetAccountInfoDataSourceImpl extends BaseDataSource implements GetAccountInfoDataSource {
  GetAccountInfoDataSourceImpl(super.dio);

  @override
  Future<BaseResult<GetAccountInfoResponse>> getAccountInfo(GetAccountInfoRequest getAccountInfoRequest) {
    return getResult(
        post(ApiUrls.getAccountInformation,
            getAccountInfoRequest.toJson()),
            (response) => GetAccountInfoResponse.fromJson(response)
    );
  }
}

final getAccountInfoDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return GetAccountInfoDataSourceImpl(dio);
});
