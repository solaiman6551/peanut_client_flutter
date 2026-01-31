import 'package:flutter/material.dart';

class AppUtils {

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
