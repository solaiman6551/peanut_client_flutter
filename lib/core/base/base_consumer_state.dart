import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class BaseConsumerState<T extends ConsumerStatefulWidget> extends ConsumerState<T> with WidgetsBindingObserver {

  bool backIntercept(bool stopDefaultButtonEvent, RouteInfo info) {
    if (EasyLoading.isShow) {
      HapticFeedback.mediumImpact();
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    debugPrint("======================>[ $T -> initState ]<======================" );
    WidgetsBinding.instance.addObserver(this);
    BackButtonInterceptor.add(backIntercept);
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("======================>[ $T -> DISPOSED ]<======================");
    WidgetsBinding.instance.removeObserver(this);
    BackButtonInterceptor.remove(backIntercept);
    super.dispose();
  }

}
