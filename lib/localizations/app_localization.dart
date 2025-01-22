import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();

  late Map<String, dynamic> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('assets/langs/${locale.languageCode}.json');
    _localizedStrings = jsonDecode(jsonString);
    return true;
  }

  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic currentMap = _localizedStrings;

    for (var k in keys) {
      if (currentMap is Map<String, dynamic> && currentMap.containsKey(k)) {
        currentMap = currentMap[k];
      } else {
        return key;
      }
    }
    return currentMap ?? key;
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
