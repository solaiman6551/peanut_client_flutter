import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peanut_client_app/utils/api_urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../network_interceptor/network_interceptor.dart';


final dioProvider = Provider<Dio>((ref) {

  final options = BaseOptions(
    baseUrl: ApiUrls.baseUrl,
    receiveDataWhenStatusError: true,
    validateStatus: (_) => true,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  final dio = Dio(options);

  dio.interceptors.addAll([NetworkInterceptor(ref)]);

  if (kDebugMode) {
    dio.interceptors.addAll([
      ref.read(prettyDioLoggerProvider),
    ]);
  }

  return dio;

});

final prettyDioLoggerProvider = Provider<PrettyDioLogger>((ref) => PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
  ),
);
