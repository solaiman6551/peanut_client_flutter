import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class CustomLoader {
  CustomLoader() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 1.0
      ..radius = 10.0
      ..progressColor = Color(0x00000000)
      ..backgroundColor = Color(0x00000000)
      ..textColor = Colors.black.withOpacity(0.7)
      ..maskColor = Colors.black.withOpacity(0.6)
      ..indicatorColor = Color(0x00000000)
      ..userInteractions = false
      ..dismissOnTap = false
      ..contentPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
      ..maskType = EasyLoadingMaskType.custom
      ..boxShadow = <BoxShadow>[]
      ..indicatorWidget = const CustomLoadingWidget();
  }

  static void showCommonLoader([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.indicatorWidget = const CustomLoadingWidget();
    EasyLoading.show(status: text ?? 'loading...');
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }

}

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
