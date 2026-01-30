import 'package:flutter/material.dart';
import '../base/base_result.dart';
import '../enum/network_status.dart';


void safeApiCall<T>(
    BaseResult<T> result, {
      Function(bool isLoad)? onLoad,
      required Function(T? data) onSuccess,
      required Function(dynamic code, String message) onError,
    }) async {
  if (onLoad != null) onLoad(true);

  NetworkStatus status;
  try {
    status = NetworkStatus.toCode(result.code as int);
  } catch (e) {
    status = NetworkStatus.error;
  }

  switch (status) {
    case NetworkStatus.success:
      onSuccess(result.data);
      debugPrint("--------------------------------> SUCCESS");
      break;
    case NetworkStatus.clearAndGotoStart:
      onError(result.code, result.message);
      debugPrint("--------------------------------> CLEAR AND GO TO START");
      break;
    case NetworkStatus.error:
      onError(result.code, result.message);
      debugPrint("--------------------------------> ERROR");
      break;
  }
  if (onLoad != null) onLoad(false);
}

void doNothing() {}

