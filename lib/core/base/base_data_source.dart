import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../enum/network_status.dart';
import 'base_result.dart';


typedef ResponseConverter<T> = T Function(dynamic response);

class BaseDataSource {

  final Dio dio;

  BaseDataSource(this.dio);

  Future<BaseResult<T>> getResult<T>(Future<Response<dynamic>> call, ResponseConverter<T> converter) async {
    try {
      var response = await call;
      Map<String, dynamic> jsonResponse = json.decode(response.toString());
      if (jsonResponse['responseCode'] == NetworkStatus.success.code) {
        var transform = converter(jsonResponse);
        return BaseResult.success(jsonResponse['responseCode'], transform);
      } else {
        return BaseResult.error(
            jsonResponse['responseCode'] ?? 000,
            jsonResponse['responseMessage'] ?? 'unknown_error'
        );
      }
    } on DioException catch (e) {
      debugPrint(e.error.toString());
      if(e.type == DioExceptionType.connectionError) {
        EasyLoading.dismiss();
        return BaseResult.error(NetworkStatus.error.code, 'network_error');
      }
      else if(e.type == DioExceptionType.connectionTimeout) {
        EasyLoading.dismiss();
        return BaseResult.error(000, 'connection_timeout');
      }
      else if(e.type == DioExceptionType.receiveTimeout) {
        EasyLoading.dismiss();
        return BaseResult.error(000, 'connection_timeout');
      }
      else if(e.type == DioExceptionType.sendTimeout) {
        EasyLoading.dismiss();
        return BaseResult.error(000, 'connection_timeout');
      }
      return BaseResult.error(000, 'unknown_error');
    } catch (e, stackTrace) {
      debugPrint('Error: ${e.toString()}');
      debugPrint('StackTrace: $stackTrace');
      EasyLoading.dismiss();
      return BaseResult.error(000, 'unknown_error');
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

}