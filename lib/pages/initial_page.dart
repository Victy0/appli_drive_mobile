import 'package:appli_drive_mobile/components/dialogs/dialog_change_language.dart';
import 'package:appli_drive_mobile/components/version_app.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const InitialPage({super.key, required this.onLanguageChange});

  @override
  InitialPageState createState() => InitialPageState();
}

class InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    super.initState();
    checkFirstAccess();
  }

  Future<void> checkFirstAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstAccess') ?? true;

    if (isFirstTime) {
      showLanguageDialog();
      // prefs.setBool('isFirstAccess', false);
    }
  }

  Future<void> showLanguageDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: widget.onLanguageChange),
    );
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      body: Stack(
        children: [
          Center(
            child: Text(AppLocalization.of(context).translate("version"))
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: VersionApp(),
            ),
          ),
        ],
      ),
    );
  }
}
