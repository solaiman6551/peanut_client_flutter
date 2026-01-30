import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/base/base_consumer_state.dart';
import '../../core/di/core_provider.dart';
import '../../ui/common_text_widget.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/Colors.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/dimension/app_dimen.dart';
import '../../utils/dimension/dimen.dart';
import '../../utils/pref_keys.dart';
import '../../utils/text_style.dart';
import 'api/get_open_trades_controller.dart';
import 'api/model/get_open_trades_request.dart';
import 'api/model/get_open_trades_response.dart';


class OpenTradesScreen extends ConsumerStatefulWidget {
  const OpenTradesScreen({super.key});

  @override
  ConsumerState<OpenTradesScreen> createState() => _OpenTradesScreenState();
}

class _OpenTradesScreenState extends BaseConsumerState<OpenTradesScreen> {

  final TextStyle subtitle = const TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = const TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTrades();
    });
  }

  Future<void> _fetchTrades() async {
    final loginId = ref.read(localPrefProvider).getString(PrefKeys.loginId) ?? '';
    final sessionToken = ref.read(localPrefProvider).getString(PrefKeys.sessionTokenKey) ?? '';
    final request = GetOpenTradesRequest(login: loginId, token: sessionToken);
    await ref.read(getOpenTradesControllerProvider.notifier).getOpenTradesList(request);
  }

  @override
  Widget build(BuildContext context) {
    final getOpenTradesListState = ref.watch(getOpenTradesControllerProvider);
    return Scaffold(
      appBar: AppBar(
          title: CommonTextWidget(text: "Traders List",
              style: regular22(color: primaryWhite)
          )
      ),
      body: CustomBaseBodyWidget(
        child: RefreshIndicator(
          onRefresh: _fetchTrades,
          color: primaryColor,
          child: getOpenTradesListState.when(
            skipLoadingOnRefresh: true,
            loading: () => _buildShimmerLoading(),
            error: (err, stack) => CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Error from server. Please try again later!",
                        textAlign: TextAlign.center,
                        style: regular16(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            data: (data) {
              final openTradesList = data.openTradesItem ?? [];
              final double totalProfit = openTradesList.fold(0.0,
                      (previousValue, element)
                  => previousValue + (element.profit ?? 0.0)
              );
              if (openTradesList.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
                          alignment: Alignment.center,
                          child: const Text("You don't have any data right now!"),
                        );
                      },
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildProfitHeader(totalProfit),
                  Gap.h20,
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: openTradesList.length,
                      itemBuilder: (context, index) {
                        final tradesList = openTradesList[index];
                        return _buildTradeCard(tradesList);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfitHeader(double total) {
    final isPositive = total >= 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimenSizes.dimen_16),
      decoration: BoxDecoration(
        color: isPositive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DimenSizes.dimen_5),
        border: Border.all(color: isPositive ? Colors.green : Colors.red, width: 1),
      ),
      child: Column(
        children: [
          const Text("TOTAL PROFIT", style: TextStyle(color: Colors.grey, fontSize: 12)),
          Gap.h5,
          Text(
            "${total.toStringAsFixed(2)} USD",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeCard(OpenTradesItem tradesList) {
    return Container(
      margin: const EdgeInsets.only(bottom: DimenSizes.dimen_20),
      padding: const EdgeInsets.all(DimenSizes.dimen_12),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: DimenSizes.dimen_1),
        borderRadius: const BorderRadius.all(Radius.circular(DimenSizes.dimen_5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(text: "Ticket: ${tradesList.ticket}", style: regular14()),
                const SizedBox(height: DimenSizes.dimen_3),
                CommonTextWidget(text: "Current Price: ${tradesList.currentPrice}", style: regular11()),
                CommonTextWidget(text: "Open Price: ${tradesList.openPrice}", style: regular11()),
                CommonTextWidget(text: "Login: ${tradesList.login}", style: regular11()),
                CommonTextWidget(text: "Profit: ${tradesList.profit}", style: regular11()),
                CommonTextWidget(text: "Volume: ${tradesList.volume}", style: regular11()),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonTextWidget(
                  text: CustomDateTimeFormatter.dateFormatter(tradesList.openTime),
                  style: regular14(),
                ),
                CommonTextWidget(text: "Symbol: ${tradesList.symbol}", style: regular11()),
                CommonTextWidget(text: "Type: ${tradesList.type}", style: regular11()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFF5F5F5),
      highlightColor: lightGreyColor,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, _) => Container(
          height: DimenSizes.dimen_100,
          margin: const EdgeInsets.only(bottom: DimenSizes.dimen_20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: AppDimen.commonCircularBorderRadius,
          ),
        ),
      ),
    );
  }

}