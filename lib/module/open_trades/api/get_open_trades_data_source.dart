import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/base/base_data_source.dart';
import '../../../../core/base/base_result.dart';
import '../../../../core/di/network_provider.dart';
import '../../../../utils/api_urls.dart';
import 'model/get_open_trades_request.dart';
import 'model/get_open_trades_response.dart';


abstract class GetOpenTradesDataSource {
  Future<BaseResult<GetOpenTradesResponse>> getOpenTradesList(GetOpenTradesRequest getOpenTradesRequest);
}

class GetOpenTradesDataSourceImpl extends BaseDataSource implements GetOpenTradesDataSource {
  GetOpenTradesDataSourceImpl(super.dio);

  @override
  Future<BaseResult<GetOpenTradesResponse>> getOpenTradesList(GetOpenTradesRequest getOpenTradesRequest) {
    return getResult(
        post(ApiUrls.getOpenTradesList,
            getOpenTradesRequest.toJson()),
            (response) => GetOpenTradesResponse.fromJson(response)
    );
  }
}

final getOpenTradesDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return GetOpenTradesDataSourceImpl(dio);
});
