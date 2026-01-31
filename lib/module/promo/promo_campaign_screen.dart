import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peanut_client_app/module/promo/promo_card.dart';
import '../../core/base/base_consumer_state.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/colors.dart';
import 'api/promo_campaign_controller.dart';

class PromoScreen extends ConsumerStatefulWidget {
  const PromoScreen({super.key});

  @override
  ConsumerState<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends BaseConsumerState<PromoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(promoControllerProvider.notifier).fetchPromos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final promoState = ref.watch(promoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotions'),
        backgroundColor: primaryColor,
      ),
      body: CustomBaseBodyWidget(
        child: RefreshIndicator(
          onRefresh: () => ref.read(promoControllerProvider.notifier).fetchPromos(),
          child: promoState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
            data: (promos) {
              if (promos.isEmpty) {
                return const Center(child: Text("No promotions available"));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: promos.length,
                itemBuilder: (context, index) => PromoCard(promo: promos[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}