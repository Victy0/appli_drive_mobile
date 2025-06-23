enum AppPreferenceKey {
// SETUP
  dbVersion,            // número de versionamento do banco de dados
  selectCountry,        // país selecionado 
  selectLanguage,       // idioma selecionado
// APPMON PAIRING
  appmonPairingName,    //nome do appmon pareado
// APPMON LIST
  appmonRevealedIds,    // lista de appmons revelados
  seeAllAppmons,        // informação booleana se deve mostrar todos appmos
// 7CODE
  dantemonAppliarise,   // informação booleana se foi realizado appliarise de Dantemon
  sevencodeRevealedIds, // lista de 7code revelados
}

extension AppPreferenceKeyExt on AppPreferenceKey {
  String get value {
    switch (this) {
    // SETUP
      case AppPreferenceKey.dbVersion:
        return 'db_version';
      case AppPreferenceKey.selectCountry:
        return 'selected_country';
      case AppPreferenceKey.selectLanguage:
        return 'selected_language';
    // APPMON PAIRING
      case AppPreferenceKey.appmonPairingName:
        return 'appmon_pairing_name';
    // APPMON LIST
      case AppPreferenceKey.appmonRevealedIds:
        return 'appmon_revealed_ids';
      case AppPreferenceKey.seeAllAppmons:
        return 'appmon_revealed_ids';
    // 7CODE
      case AppPreferenceKey.dantemonAppliarise:
        return 'dantemon_appliarise';
      case AppPreferenceKey.sevencodeRevealedIds:
        return 'sevencode_revealed_ids';
    }
  }
}