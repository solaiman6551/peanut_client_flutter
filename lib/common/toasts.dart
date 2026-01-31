import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../ui/common_text_widget.dart';
import '../utils/colors.dart';
import '../utils/dimen.dart';
import '../utils/text_style.dart';


class Toasts {
  static void showSuccessToast(String message) async {
    showOverlayNotification((context) {
        return SafeArea(
          child: Padding(
            padding: AppDimen.toastVerticalHorizontalPadding,
            child: Material(
              color: Colors.green,
              borderRadius: AppDimen.commonCircularBorderRadius,
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(DimenSizes.dimen_12),
                  child: CommonTextWidget(
                      text: message,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: regular14(color: primaryWhite)
                  )
              ),
            ),
          ),
        );
      },
      position: NotificationPosition.top,
      duration: const Duration(seconds: 2),
    );
  }

  static void showErrorToast(String message) async {
    showOverlayNotification((context) {
        return SafeArea(
          child: Padding(
            padding: AppDimen.toastVerticalHorizontalPadding,
            child: Material(
              color: Colors.red,
              borderRadius: AppDimen.commonCircularBorderRadius,
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(DimenSizes.dimen_12),
                  child: CommonTextWidget(
                      text: message,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: regular14(color: primaryWhite)
                  )
              ),
            ),
          ),
        );
      },
      position: NotificationPosition.top,
      duration: const Duration(seconds: 2),
    );
  }

  static void showInformationToast(String message) async {
    showOverlayNotification((context) {
        return SafeArea(
          child: Padding(
            padding: AppDimen.toastVerticalHorizontalPadding,
            child: Material(
              color: Colors.blue,
              borderRadius:AppDimen.commonCircularBorderRadius,
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(DimenSizes.dimen_12),
                  child: CommonTextWidget(
                      text: message,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: regular14(color: primaryWhite)
                  )
              ),
            ),
          ),
        );
      },
      position: NotificationPosition.top,
      duration: const Duration(seconds: 2),
    );
  }

}
