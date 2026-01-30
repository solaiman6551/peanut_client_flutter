import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/base/base_consumer_state.dart';
import '../../../common/toasts.dart';
import '../../../core/di/core_provider.dart';
import '../../../ui/common_text_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimension/app_dimen.dart';
import '../../../utils/dimension/dimen.dart';
import '../../../utils/pref_keys.dart';
import '../../../utils/text_style.dart';
import '../../ui/common_button_widget.dart';
import '../../ui/common_text_field_widget.dart';
import '../../ui/custom_base_body_widget.dart';
import '../dashboard/dashboard_screen.dart';
import 'api/login_controller.dart';
import 'api/model/login_request.dart';
import 'api/model/login_response.dart';


class LoginScreen extends ConsumerStatefulWidget {

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseConsumerState<LoginScreen> {

  final loginIdTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    ref.listen<AsyncValue<LoginResponse>>(
      loginControllerProvider,
          (previousState, currentState) async {
        if (currentState.isLoading || currentState.isRefreshing) {
          EasyLoading.show();
        } else if (currentState.hasError) {
          EasyLoading.dismiss();
          Toasts.showErrorToast('');
        } else {
          EasyLoading.dismiss();
          final response = currentState.value!;
          if (response.result == true && response.token != "") {
            ref.read(localPrefProvider).setBool(PrefKeys.isLoggedInKey, true);
            ref.read(localPrefProvider).setString(PrefKeys.sessionTokenKey, response.token ?? "");
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else {
            Toasts.showErrorToast("Login failed");
          }
        }
      },
    );

    final loginId = CommonTextFieldWidget(
      controller: loginIdTextController,
      scrollPadding: const EdgeInsets.all(DimenSizes.dimen_0),
      obscureText: false,
      maxLength: AppConstants.loginIdLength,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {

      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: AppDimen.commonCircularBorderRadius,
          ),
          labelText: "Login ID",
          labelStyle: regular18(color: primaryTextLightColor),
          hintText: "",
          hintStyle: regular14(color: primaryTextLightColor),
          counterText: ""
      ),
      style: regular16(color: primaryTextColor),
    );

    final password = CommonTextFieldWidget(
      controller: passwordTextController,
      scrollPadding: const EdgeInsets.all(DimenSizes.dimen_0),
      obscureText: true,
      maxLength: AppConstants.passwordLength,
      keyboardType: TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter
      ],
      onChanged: (value) {

      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: AppDimen.commonCircularBorderRadius,
          ),
          labelText: "Password",
          labelStyle: regular18(color: primaryTextLightColor),
          hintText: "Enter your password",
          hintStyle: regular14(color: primaryTextLightColor),
          counterText: ""
      ),
      style: regular16(color: primaryTextColor),
    );

    final loginButton = Padding(
      padding: AppDimen.commonAllSidePadding0,
      child: ListenableBuilder(
        listenable: Listenable.merge([loginIdTextController, passwordTextController]),
        builder: (context, _) {
          final bool isInputValid = loginIdTextController.text.isNotEmpty &&
              passwordTextController.text.isNotEmpty;
          final bool isLoading = ref.watch(loginControllerProvider).isLoading;
          final bool canSubmit = isInputValid && !isLoading;
          return Opacity(
            opacity: canSubmit ? 1.0 : 0.2,
            child: CommonButtonWidget(
              text: "Submit",
              onPressedFunction: canSubmit ? () {
                AppUtils.hideKeyboard();
                LoginRequest loginRequest = LoginRequest(
                    loginId: loginIdTextController.text,
                    password: passwordTextController.text);
                ref.read(localPrefProvider).setString(PrefKeys.loginId, loginIdTextController.text);
                ref.read(loginControllerProvider.notifier).login(loginRequest);
              } : () {
                Toasts.showErrorToast("Please enter your credentials");
              },
            ),
          );
        },
      ),
    );

    return Scaffold(
      backgroundColor: bgPrimaryColor,
      body: CustomBaseBodyWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonTextWidget(
                text: "Welcome",
                style: bold26(),
              ),
              Gap.h5,
              CommonTextWidget(
                text: "Sign In to continue",
                style: regular18(),
              ),
              Gap.h25,
              loginId,
              Gap.h15,
              password,
              Gap.h25,
              loginButton,
              Gap.h25,
              Center(
                child: CommonTextWidget(
                  text: "Forgot Password?",
                  style: regular14(color: lightGreyColor),
                ),
              ),
              Gap.h10,
              Center(
                child: CommonTextWidget(
                  text: "Don't have an account? Sign Up",
                  style: regular14(color: lightGreyColor),
                ),
              ),
            ],
          ),
        ),
      )
    );


  }

  @override
  void dispose() {
    loginIdTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

}