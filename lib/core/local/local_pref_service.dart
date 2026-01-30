import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/pref_keys.dart';

class LocalPrefService {

  final SharedPreferences _preferences;

  LocalPrefService(this._preferences);

  String _motherKey(String key) {
    return '${PrefKeys.motherKey}.$key';
  }

  int? getInt(String key) {
    return _preferences.getInt(_motherKey(key));
  }

  Future<void> setInt(String key, int? value) async {
    await _preferences.setInt(_motherKey(key), value ?? 0);
  }

  String? getString(String key) {
    return _preferences.getString(_motherKey(key));
  }

  Future<void> setString(String key, String? value) async {
    await _preferences.setString(_motherKey(key), value ?? '');
  }

  bool? getBool(String key) {
    return _preferences.getBool(_motherKey(key));
  }

  Future<void> setBool(String key, bool? value) async {
    await _preferences.setBool(_motherKey(key), value ?? false);
  }

  getObject(String key) async {
    return _preferences.getString(_motherKey(key)) ?? '';
  }

  Future<void> setObject(String key, value) async {
    await _preferences.setString(_motherKey(key), value);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(_motherKey(key));
  }

  Future<void> setDouble(String key, double? value) async {
    await _preferences.setDouble(_motherKey(key), value ?? 0.0);
  }

  Future<void> clearSharedPref() async {
    await _preferences.clear();
  }

}
