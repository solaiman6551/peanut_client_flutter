import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peanut_client_app/module/promo/api/promo_campaign_data_source.dart';
import 'package:peanut_client_app/module/promo/api/promo_campaign_model.dart';
import '../../../core/di/network_provider.dart'; // Import your dio/provider DI


final promoControllerProvider = AsyncNotifierProvider<PromoController, List<PromoCampaign>>(() {
  return PromoController();
});

class PromoController extends AsyncNotifier<List<PromoCampaign>> {

  @override
  FutureOr<List<PromoCampaign>> build() {
    return [];
  }

  Future<void> fetchPromos() async {
    state = const AsyncLoading();

    final dataSource = ref.read(promoDataSourceProvider);

    final result = await dataSource.getPromos();
    debugPrint("Hello ${result.statusCode}");
    if (result.statusCode == 200) {
      state = AsyncData(result.data ?? []);
    } else {
      state = AsyncError(result.message, StackTrace.current);
    }
  }
}

final promoDataSourceProvider = Provider<PromoDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return PromoDataSourceImpl(dio);
});