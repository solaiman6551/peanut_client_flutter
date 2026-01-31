import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/toasts.dart';
import '../../module/login/login_screen.dart';
import '../context_holder.dart';
import 'base_result.dart';


typedef ResponseConverter<T> = T Function(dynamic response);

class BaseDataSource {

  final Dio dio;

  BaseDataSource(this.dio);

  static bool _isLoggingOut = false;

  Future<BaseResult<T>> getResult<T>(
      Future<Response<dynamic>> call, ResponseConverter<T> converter) async {
    try {
      final response = await call;
      final statusCode = response.statusCode ?? 0;
      if (statusCode == 200) {
        final data = converter(response.data);
        return BaseResult.success(statusCode, data);
      }
      else if (statusCode == 401) {
        return BaseResult.error(statusCode, "${response.statusMessage}");
      }
      else if (statusCode == 500) {
        if (!_isLoggingOut) {
          _handleLogout();
        }
        return BaseResult.error(statusCode, "${response.statusMessage}");
      }
      else {
        return BaseResult.error(
            statusCode, response.statusMessage ?? "Unknown error");
      }
    } on DioException catch (e) {
      debugPrint('Dio Error: ${e.error}');
      switch (e.type) {
        case DioExceptionType.connectionError:
          return BaseResult.error(0, 'Network error');
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return BaseResult.error(0, 'Connection timeout');
        default:
          return BaseResult.error(0, 'Unknown network error');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $stackTrace');
      return BaseResult.error(0, 'Unknown error');
    }
  }

  Future<Response<dynamic>> get<T>(String url, {Map<String, dynamic>? params}) async {
    final Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response;
  }

  Future<Response<dynamic>> post<T>(String url, Map<String, dynamic>? body) async {
    final Response response = await dio.post(url, data: body);
    return response;
  }

  Future<Response<dynamic>> postFormData<T>(String url, FormData body) async {
    final Response response = await dio.post(url, data: body);
    return response;
  }

  Future<Response<dynamic>> put<T>(String url, Map<String, dynamic> body) async {
    final Response response = await dio.put(url, data: body);
    return response;
  }

  Future<Response<dynamic>> putFormData<T>(String url, FormData body) async {
    final Response response = await dio.put(url, data: body);
    return response;
  }

  Future<Response<dynamic>> delete<T>(String url, Map<String, dynamic> body) async {
    final Response response = await dio.delete(url, data: body);
    return response;
  }

  Future<Response<dynamic>> update<T>(String url, Map<String, dynamic> body) async {
    final Response response = await dio.patch(url, data: body);
    return response;
  }

  Future<BaseResult<T>> getSoapResult<T>(
      Future<Response<String>> call,
      T Function(String xmlResponse) converter
      ) async {
    try {
      final response = await call;
      final statusCode = response.statusCode ?? 0;

      if (statusCode == 200 && response.data != null) {
        final data = converter(response.data!);
        return BaseResult.success(statusCode, data);
      }
      else if (statusCode == 500) {
        if (!_isLoggingOut) _handleLogout();
        return BaseResult.error(statusCode, "Internal Server Error");
      }
      return BaseResult.error(statusCode, "SOAP Error");
    } on DioException catch (e) {
      return BaseResult.error(0, 'Network error');
    }
  }

  Future<Response<String>> postSoap(String url, String soapEnvelope, String soapAction) async {
    return await dio.post<String>(
      url,
      data: soapEnvelope,
      options: Options(
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": soapAction,
          "Accept": "*/*"
        },
        responseType: ResponseType.plain,
      ),
    );
  }

  Future<void> _handleLogout() async {
    _isLoggingOut = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Toasts.showErrorToast("Access Denied");
    ContextHolder.navKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    ).then((_) {
      _isLoggingOut = false;
    });
  }

}
