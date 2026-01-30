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
          Toasts.showErrorToast("${currentState.error}");
        } else {
          EasyLoading.dismiss();
          final response = currentState.value!;
          if (response.result == true && response.token != "") {
            ref.read(localPrefProvider).setBool(PrefKeys.isLoggedInKey, true);
            ref.read(localPrefProvider).setString(PrefKeys.sessionTokenKey, response.token ?? '');

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
          labelText: 'Login ID',
          labelStyle: regular14(color: primaryTextLightColor),
          hintText: 'Enter your login ID',
          hintStyle: regular14(color: primaryTextLightColor),
          counterText: ''
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
          labelText: 'Password',
          labelStyle: regular14(color: primaryTextLightColor),
          hintText: 'Enter your password',
          hintStyle: regular14(color: primaryTextLightColor),
          counterText: ''
      ),
      style: regular16(color: primaryTextColor),
    );

    return Scaffold(
      backgroundColor: bgPrimaryColor,
      body: CustomBaseBodyWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IntrinsicHeight(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: AppDimen.commonAllSidePadding30,
                        margin: const EdgeInsets.only(top: DimenSizes.dimen_50),
                        decoration: BoxDecoration(
                          color: primaryWhite,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(DimenSizes.dimen_25),
                              topRight: Radius.circular(DimenSizes.dimen_25)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: lightGreyColor,
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gap.h20,
                            CommonTextWidget(
                                text: 'Login',
                                style: regular28(color: primaryTextColor),
                                shouldShowMultipleLine: true
                            ),
                            Gap.h40,
                            loginId,
                            Gap.h20,
                            password,
                            Gap.h30,
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: CommonButtonWidget(
                                  text: 'Submit',
                                  onPressedFunction: () {
                                    AppUtils.hideKeyboard();
                                    LoginRequest loginRequest = LoginRequest(
                                        loginId: loginIdTextController.text,
                                        password: passwordTextController.text
                                    );
                                    ref.read(localPrefProvider).setString(PrefKeys.loginId, loginIdTextController.text);
                                    ref.read(loginControllerProvider.notifier).login(loginRequest);
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}