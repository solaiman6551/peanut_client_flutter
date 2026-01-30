import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:peanut_client_app/utils/primary_color_helper.dart';
import '../core/context_holder.dart';
import '../module/splash_screen.dart';
import 'colors.dart';


class MainWidget extends ConsumerWidget {

  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlaySupport.global(
        child: MaterialApp(
          navigatorKey: ContextHolder.navKey,
          theme: ThemeData(
            useMaterial3: false,
            primarySwatch: createPrimaryMaterialColor(primaryColor),
            bottomAppBarTheme: BottomAppBarThemeData(color: transparentColor),
            bottomSheetTheme: BottomSheetThemeData(backgroundColor: transparentColor),
          ),
          builder: EasyLoading.init(),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        )
    );
  }

}
