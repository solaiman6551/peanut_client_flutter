import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../core/base/base_consumer_state.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/app_constants.dart';
import '../core/context_holder.dart';
import '../core/di/core_provider.dart';
import '../utils/assets_provider.dart';
import '../utils/pref_keys.dart';
import 'dashboard/dashboard_screen.dart';
import 'login/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseConsumerState<SplashScreen> {

  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startNormalFlow();
      if (kDebugMode) {
        showDebugBannerInfo();
      }
    });
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }

  void showDebugBannerInfo() {
    showOverlay((context, t) {
      return const Banner(
        message: AppConstants.buildTypeDebug,
        location: BannerLocation.bottomEnd,
      );
    }, duration: const Duration(days: 365));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBaseBodyWidget(
        child: Center(
          child: Lottie.asset(
            AssetsProvider.lottiePath('splash_screen_lottie'),
          ),
        ),
      ),
    );
  }

  void startNormalFlow() {
    _splashTimer = Timer(const Duration(seconds: 3), () async {
      final isLoggedIn = ref.read(localPrefProvider).getBool(PrefKeys.isLoggedInKey) ?? false;

      final navState = ContextHolder.navKey.currentState;

      if (isLoggedIn) {

        ref.invalidate(dashboardIndexProvider);

        navState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
              (route) => false,
        );
      } else {
        await ref.read(localPrefProvider).clearSharedPref();
        navState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    });
  }

}