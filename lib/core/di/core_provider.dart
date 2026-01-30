import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../local/local_pref_service.dart';


final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final localPrefProvider = Provider((ref){
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalPrefService(sharedPreferences);
});


