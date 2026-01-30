import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/base/base_data_source.dart';
import '../../../../core/base/base_result.dart';
import '../../../../core/di/network_provider.dart';
import '../../../../utils/api_urls.dart';
import 'model/login_request.dart';
import 'model/login_response.dart';


abstract class LoginDataSource {
  Future<BaseResult<LoginResponse>> login(LoginRequest loginRequest);
}

class LoginDataSourceImpl extends BaseDataSource implements LoginDataSource {
  LoginDataSourceImpl(super.dio);

  @override
  Future<BaseResult<LoginResponse>> login(LoginRequest loginRequest) {
    return getResult(
        post(ApiUrls.loginApi,
            loginRequest.toJson()),
            (response) => LoginResponse.fromJson(response)
    );
  }
}

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return LoginDataSourceImpl(dio);
});
