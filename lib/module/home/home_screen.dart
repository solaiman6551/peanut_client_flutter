import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/base/base_consumer_state.dart';
import '../../core/di/core_provider.dart';
import '../../ui/common_text_widget.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/colors.dart';
import '../../utils/dimension/dimen.dart';
import '../../utils/pref_keys.dart';
import '../../utils/text_style.dart';
import 'api/get_account_info_controller.dart';
import 'api/get_phone_number_controller.dart';
import 'api/model/get_account_info_request.dart';
import 'api/model/get_account_info_response.dart';
import 'api/model/get_phone_number_request.dart';
import 'api/model/get_phone_number_response.dart';


class HomeScreen extends ConsumerStatefulWidget {

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends BaseConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    final loginId = ref.read(localPrefProvider).getString(PrefKeys.loginId) ?? '';
    final sessionToken = ref.read(localPrefProvider).getString(PrefKeys.sessionTokenKey) ?? '';

    ref.invalidate(getAccountInfoControllerProvider);
    ref.invalidate(getPhoneNumberControllerProvider);

    final accountRequest = GetAccountInfoRequest(login: loginId, token: sessionToken);
    final phoneRequest = GetPhoneNumberRequest(login: loginId, token: sessionToken);

    await Future.wait([
      ref.read(getAccountInfoControllerProvider.notifier).getAccountInfo(accountRequest),
      ref.read(getPhoneNumberControllerProvider.notifier).getPhoneNumber(phoneRequest),
    ]);
  }


  @override
  Widget build(BuildContext context) {

    final accountInfoState = ref.watch(getAccountInfoControllerProvider);
    final phoneNumberState = ref.watch(getPhoneNumberControllerProvider);

    Widget shimmerLine({double height = 14, double width = double.infinity}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }

    Widget shimmerRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          shimmerLine(width: 100),
          shimmerLine(width: 100),
        ],
      );
    }

    Widget accountInfoShimmer() {
      return Shimmer.fromColors(
        baseColor: const Color(0xFFF0F0F0),
        highlightColor: lightGreyColor,
        child: Padding(
          padding: const EdgeInsets.all(DimenSizes.dimen_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              shimmerLine(height: 20, width: 180),
              const SizedBox(height: 8),
              shimmerLine(height: 14),
              const Divider(),
              shimmerRow(),
              Gap.h20,
              shimmerRow(),
              Gap.h20,
              shimmerRow(),
              Gap.h20,
              shimmerRow(),
              Gap.h20,
              shimmerRow(),
              Gap.h20,
              shimmerRow(),
            ],
          ),
        ),
      );
    }

    Widget phoneNumberShimmer() {
      return Shimmer.fromColors(
        baseColor: const Color(0xFFF0F0F0),
        highlightColor: lightGreyColor,
        child: Container(
          height: DimenSizes.dimen_60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: suvaGreyColor,
              width: DimenSizes.dimen_1,
            ),
            borderRadius: BorderRadius.circular(DimenSizes.dimen_10),
          ),
        ),
      );
    }

    Widget buildRow(String left, String right) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextWidget(text: left,
              style: regular12(color: lightGreyColor)
          ),
          CommonTextWidget(text: right,
              style: regular12(color: lightGreyColor)
          ),
        ],
      );
    }

    Widget buildValueRow(String left, String right) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextWidget(text: left,
              style: semiBold14(color: primaryTextColor)
          ),
          CommonTextWidget(text: right,
              style: semiBold14(color: primaryTextColor)
          ),
        ],
      );
    }

    Widget accountInfoContent(AsyncValue<GetAccountInfoResponse> accountInfoState) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CommonTextWidget(text: accountInfoState.value?.name ?? "",
                style: semiBold20(color: primaryTextColor)
            ),
            CommonTextWidget(text: accountInfoState.value?.address ?? "",
                style: semiBold12(color: lightGreyColor)
            ),
            const Divider(thickness: DimenSizes.dimen_1),
            buildRow("BALANCE", "Currency"),
            buildValueRow(
              "${accountInfoState.value?.balance}",
              "${accountInfoState.value?.currency}",
            ),
            Gap.h20,
            buildRow("CITY", "COUNTRY"),
            buildValueRow(
              accountInfoState.value?.city ?? "",
              accountInfoState.value?.country ?? "",
            ),
            Gap.h20,
            buildRow("ZIP CODE", "LEVERAGE"),
            buildValueRow(
              "${accountInfoState.value?.zipCode }",
              "${accountInfoState.value?.leverage}",
            ),
            Gap.h20,
            buildRow("CURRENT TRADES COUNT", "CURRENT TRADES VOLUME"),
            buildValueRow(
              "${accountInfoState.value?.currentTradesCount}",
              "${accountInfoState.value?.currentTradesVolume}",
            ),
            Gap.h20,
            buildRow("EQUITY", "FREE MARGIN"),
            buildValueRow(
              "${accountInfoState.value?.equity}",
              "${accountInfoState.value?.freeMargin}",
            ),
            Gap.h20,
            buildRow("TOTAL TRADES COUNT", "TOTAL TRADES VOLUME"),
            buildValueRow(
              "${accountInfoState.value?.totalTradesCount}",
              "${accountInfoState.value?.totalTradesVolume}",
            ),
          ],
        ),
      );
    }

    Widget phoneNumberCard(AsyncValue<GetPhoneNumberResponse> phoneNumberState) {
      return Container(
        height: DimenSizes.dimen_60,
        decoration: BoxDecoration(
          color: primaryWhite,
          border: Border.all(
            color: suvaGreyColor,
            width: DimenSizes.dimen_1,
          ),
          borderRadius: BorderRadius.circular(DimenSizes.dimen_10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimenSizes.dimen_10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: const Icon(Icons.phone, color: Colors.white),
              ),
              Gap.w12,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(text: phoneNumberState.value?.phoneNumber ?? "",
                      style: bold18(color: primaryTextColor)
                  ),
                  CommonTextWidget(text: "Phone Number",
                      style: regular12(color: lightGreyColor)
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
          title: CommonTextWidget(text: "Home",
              style: regular22(color: primaryWhite)
          )
      ),
      backgroundColor: bgPrimaryColor,
      body: CustomBaseBodyWidget(
        child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: suvaGreyColor,
                        width: DimenSizes.dimen_1,
                      ),
                      borderRadius: BorderRadius.circular(DimenSizes.dimen_10),
                    ),
                    child: accountInfoState.isLoading
                        ? accountInfoShimmer()
                        : accountInfoState.hasError
                        ? Padding(
                      padding: EdgeInsets.all(DimenSizes.dimen_14),
                      child: Center(
                          child: CommonTextWidget(text: "Error from server. Try again later!",
                              style: regular22(color: primaryWhite)
                          )
                      ),
                    ) : accountInfoContent(accountInfoState),
                  ),
                  Gap.h10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: DimenSizes.dimen_0),
                    child: phoneNumberState.isLoading
                        ? phoneNumberShimmer()
                        : phoneNumberState.hasError
                        ? const SizedBox.shrink()
                        : phoneNumberCard(phoneNumberState),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

}