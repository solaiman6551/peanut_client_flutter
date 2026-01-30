import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/base/base_consumer_state.dart';
import '../../core/di/core_provider.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/colors.dart';
import '../../utils/dimension/dimen.dart';
import '../../utils/pref_keys.dart';
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

  final TextStyle subtitle = const TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = const TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    final loginId = ref.read(localPrefProvider).getString(PrefKeys.loginId) ?? '';
    final jwt = ref.read(localPrefProvider).getString(PrefKeys.sessionTokenKey) ?? '';

    ref.invalidate(getAccountInfoControllerProvider);
    ref.invalidate(getPhoneNumberControllerProvider);

    final accountRequest = GetAccountInfoRequest(login: loginId, token: jwt);
    final phoneRequest = GetPhoneNumberRequest(login: loginId, token: jwt);

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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              shimmerLine(height: 20, width: 180),
              const SizedBox(height: 8),
              shimmerLine(height: 14),
              const Divider(),
              shimmerRow(),
              const SizedBox(height: 20),
              shimmerRow(),
              const SizedBox(height: 20),
              shimmerRow(),
              const SizedBox(height: 20),
              shimmerRow(),
              const SizedBox(height: 20),
              shimmerRow(),
              const SizedBox(height: 20),
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
          height: 60,
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
          Text(left, style: label),
          Text(right, style: label),
        ],
      );
    }

    Widget buildValueRow(String left, String right) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left),
          Text(right),
        ],
      );
    }


    Widget accountInfoContent(AsyncValue<GetAccountInfoResponse> accountInfoState) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              accountInfoState.value?.name ?? "",
              style: const TextStyle(color: Colors.green, fontSize: 20),
            ),
            Text(
              accountInfoState.value?.address ?? "",
              style: label,
            ),
            const Divider(),
            buildRow("BALANCE", "Currency"),
            buildValueRow(
              "${accountInfoState.value?.balance}",
              "${accountInfoState.value?.currency}",
            ),
            const SizedBox(height: 20),
            buildRow("CITY", "COUNTRY"),
            buildValueRow(
              accountInfoState.value?.city ?? "",
              accountInfoState.value?.country ?? "",
            ),
            const SizedBox(height: 20),
            buildRow("ZIP CODE", "PHONE"),
            buildValueRow(
              accountInfoState.value?.zipCode ?? "",
              accountInfoState.value?.phone ?? "",
            ),
            const SizedBox(height: 20),
            buildRow("CURRENT TRADES COUNT", "CURRENT TRADES VOLUME"),
            buildValueRow(
              "${accountInfoState.value?.currentTradesCount}",
              "${accountInfoState.value?.currentTradesVolume}",
            ),

            const SizedBox(height: 20),

            buildRow("EQUITY", "FREE MARGIN"),
            buildValueRow(
              "${accountInfoState.value?.equity}",
              "${accountInfoState.value?.freeMargin}",
            ),

            const SizedBox(height: 20),

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
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: suvaGreyColor,
            width: DimenSizes.dimen_1,
          ),
          borderRadius: BorderRadius.circular(DimenSizes.dimen_10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phoneNumberState.value?.phoneNumber ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: CustomBaseBodyWidget(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: SizedBox(
                  // Force the container to be EXACTLY the height of the screen
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryWhite,
                          border: Border.all(
                            color: suvaGreyColor,
                            width: DimenSizes.dimen_1,
                          ),
                          borderRadius: BorderRadius.circular(DimenSizes.dimen_10),
                        ),
                        child: accountInfoState.isLoading
                            ? accountInfoShimmer()
                            : accountInfoContent(accountInfoState),
                      ),
                      Gap.h15,
                      phoneNumberState.isLoading
                          ? phoneNumberShimmer()
                          : phoneNumberCard(phoneNumberState),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}