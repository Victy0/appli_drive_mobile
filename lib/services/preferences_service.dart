import 'dart:convert';

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

  Future<void> setString(String key, String value) async {
    final prefs = await sharedPrefs;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await sharedPrefs;
    return prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await sharedPrefs;
    await prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final prefs = await sharedPrefs;
    return prefs.getBool(key) ?? false;
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await sharedPrefs;
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await sharedPrefs;
    return prefs.getInt(key);
  }

  Future<void> setStringInStringList(String key, String value) async {
    final prefs = await sharedPrefs;
    List<String> list = prefs.getStringList(key) ?? [];
    if (!list.contains(value)) {
      list.add(value);
      await prefs.setStringList(key, list);
    }
  }

  Future<List<String>> getStringList(String key) async {
    final prefs = await sharedPrefs;
    return prefs.getStringList(key) ?? [];
  }

  Future<void> setAppmonPairingEvolutionInfo(Map<String, String> value) async {
    final prefs = await sharedPrefs;
    final list = await getAppmonPairingEvolutionInfo();
    if (!list.contains(value)) {
      list.add(value);
    }
    final jsonString = jsonEncode(list);
    await prefs.setString('appmon_pairing_evolution', jsonString);
  }

  Future<List<Map<String, String>>> getAppmonPairingEvolutionInfo() async {
    final prefs = await sharedPrefs;
    final jsonString = prefs.getString('appmon_pairing_evolution');

    if (jsonString == null) return [{"id": "D1Y8", "code": "AAA"}];

    final decoded = jsonDecode(jsonString);

    return List<Map<String, String>>.from(
      decoded.map((item) => Map<String, String>.from(item)),
    );
  }

  Future<void> remove(String key) async {
    final prefs = await sharedPrefs;
    await prefs.remove(key);
  }
}
