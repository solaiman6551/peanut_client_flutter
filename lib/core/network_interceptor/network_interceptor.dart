import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NetworkInterceptor extends InterceptorsWrapper {

  final Ref ref;

  NetworkInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers['Content-Type'] = 'application/json';
    options.headers['Cache-Control'] = 'no-cache';
    options.headers['requestTime'] = '';
    return super.onRequest(options, handler);

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[RESPONSE] : $response');
    return super.onResponse(response, handler);
  }

}
