import 'dart:convert';

import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  SharedPreferences? _preferences;

  PreferencesService._internal();

  factory PreferencesService() {
    return _instance;
  }

  Future<SharedPreferences> get sharedPrefs async {
    if (_preferences != null) return _preferences!;
    
    _preferences = await SharedPreferences.getInstance();
    return _preferences!;
  }

  Future<void> setString(AppPreferenceKey key, String value) async {
    final prefs = await sharedPrefs;
    await prefs.setString(key.value, value);
  }

  Future<String?> getString(AppPreferenceKey key) async {
    final prefs = await sharedPrefs;
    return prefs.getString(key.value);
  }

  Future<void> setBool(AppPreferenceKey key, bool value) async {
    final prefs = await sharedPrefs;
    await prefs.setBool(key.value, value);
  }

  Future<bool> getBool(AppPreferenceKey key) async {
    final prefs = await sharedPrefs;
    return prefs.getBool(key.value) ?? false;
  }

  Future<void> setInt(AppPreferenceKey key, int value) async {
    final prefs = await sharedPrefs;
    await prefs.setInt(key.value, value);
  }

  Future<int?> getInt(AppPreferenceKey key) async {
    final prefs = await sharedPrefs;
    return prefs.getInt(key.value);
  }

  Future<void> setStringInStringList(AppPreferenceKey key, String value) async {
    final prefs = await sharedPrefs;
    List<String> list = prefs.getStringList(key.value) ?? [];
    if (!list.contains(value)) {
      list.add(value);
      await prefs.setStringList(key.value, list);
    }
  }

  Future<List<String>> getStringList(AppPreferenceKey key) async {
    final prefs = await sharedPrefs;
    return prefs.getStringList(key.value) ?? [];
  }

  Future<void> setAppmonPairingEvolutionInfo(Map<String, String> value) async {
    final prefs = await sharedPrefs;
    final list = await getAppmonPairingEvolutionInfo();
    if (!list.contains(value)) {
      list.add(value);
    }
    final jsonString = jsonEncode(list);
    await prefs.setString(AppPreferenceKey.appmonPairingEvolution.value, jsonString);
  }

  Future<List<Map<String, String>>> getAppmonPairingEvolutionInfo() async {
    final prefs = await sharedPrefs;
    final jsonString = prefs.getString(AppPreferenceKey.appmonPairingEvolution.value);

    if (jsonString == null) return [];

    final decoded = jsonDecode(jsonString);

    return List<Map<String, String>>.from(
      decoded.map((item) => Map<String, String>.from(item)),
    );
  }

  Future<void> remove(AppPreferenceKey key) async {
    final prefs = await sharedPrefs;
    await prefs.remove(key.value);
  }
}
