import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/toasts.dart';


class NetworkInterceptor extends InterceptorsWrapper {

  final Ref ref;

  NetworkInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return super.onRequest(options, handler);
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return super.onRequest(options, handler);
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      EasyLoading.dismiss();
      Toasts.showErrorToast("Please check you internet connection");
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[RESPONSE] : $response');
    return super.onResponse(response, handler);
  }

}
