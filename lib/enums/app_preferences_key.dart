enum AppPreferenceKey {
// SETUP
  dbVersion,               // número de versionamento do banco de dados
  selectCountry,           // país selecionado 
  selectLanguage,          // idioma selecionado
  tutorialFinished,        // informação booleana se tutorial foi finalizado
  show7codeIcon,           // informação booleana se deve mostrar o icone de 7code
// APPMON PAIRING
  appmonPairingName,       // nome do appmon pareado
  appmonPairingEvolution,  // informação linha evolutiva appmon pareado
  primaryColor,            // cor primária detalhe appli drive
  secondaryColor,          // cor secundária detalhe appli drive
// APPMON LIST
  appmonRevealedIds,       // lista de appmons revelados
  seeAllAppmons,           // informação booleana se deve mostrar todos appmos
// 7CODE
  dantemonAppliarise,      // informação booleana se foi realizado appliarise de Dantemon
  sevencodeRevealedIds,    // lista de 7code revelados
// HINTS
  hintRevealedList,        // lista de dicas reveladas
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
      case AppPreferenceKey.tutorialFinished:
        return 'tutorial_finished';
      case AppPreferenceKey.show7codeIcon:
        return 'show_7code_icon';
    // APPMON PAIRING
      case AppPreferenceKey.appmonPairingName:
        return 'appmon_pairing_name';
      case AppPreferenceKey.appmonPairingEvolution:
        return 'appmon_pairing_evolution';
      case AppPreferenceKey.primaryColor:
        return 'appmon_pairing_primary_color';
      case AppPreferenceKey.secondaryColor:
        return 'appmon_pairing_secondary_color';
    // APPMON LIST
      case AppPreferenceKey.appmonRevealedIds:
        return 'appmon_revealed_ids';
      case AppPreferenceKey.seeAllAppmons:
        return 'see_all_appmons';
    // 7CODE
      case AppPreferenceKey.dantemonAppliarise:
        return 'dantemon_appliarise';
      case AppPreferenceKey.sevencodeRevealedIds:
        return 'sevencode_revealed_ids';
    // HINTS
      case AppPreferenceKey.hintRevealedList:
        return 'hint_revealed_list';
    }
  }
}