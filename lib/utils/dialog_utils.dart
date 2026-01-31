import 'package:flutter/material.dart';
import 'package:peanut_client_app/ui/common_text_widget.dart';
import 'package:peanut_client_app/utils/colors.dart';
import 'package:peanut_client_app/utils/text_style.dart';


class DialogUtils {

  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context, {
    required bool isDismissible,
    required String title,
    required String content,
    required String okBtnText,
    required String cancelBtnText,
    required VoidCallback okBtnFunction,
    bool showCancelButton = false,
    bool showPolicyDetails = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (dialogContext) {
        return PopScope(
          canPop: isDismissible,
          child: AlertDialog(
            title: CommonTextWidget(
              text: title,
              style: semiBold18(),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonTextWidget(
                  text: content,
                  style: regular14()
                ),
              ],
            ),
            actions: <Widget>[
              if (isDismissible || showCancelButton)
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: CommonTextWidget(
                    text: cancelBtnText,
                    style: semiBold14(color: primaryTextColor),
                  ),
                ),
              TextButton(
                onPressed: okBtnFunction,
                child: CommonTextWidget(
                  text: okBtnText,
                  style: semiBold14(color: primaryTextColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}