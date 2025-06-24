import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_change_language.dart';
import 'package:appli_drive_mobile/interfaces/pages/first_setup_page/components/appmon_presentation.dart';
import 'package:appli_drive_mobile/interfaces/pages/first_setup_page/components/individual_selection.dart';
import 'package:appli_drive_mobile/interfaces/pages/first_setup_page/components/question_appli_drive.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/initial_page/components/version_app.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class FirstSetupPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const FirstSetupPage({super.key, required this.onLanguageChange});

  @override
  FirstSetupPageState createState() => FirstSetupPageState();
}

class FirstSetupPageState extends State<FirstSetupPage> with TickerProviderStateMixin {
  final PreferencesService _preferencesService = PreferencesService();

  int _stepSetup = 1;
  int? _selectedOption;
  String? _appmonName;
  String? _appmonId;
  String? _appmonColor;

  void _navigateToHomePage(BuildContext context) async {
    final navigator = Navigator.of(context);
    navigator.pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(onLanguageChange: widget.onLanguageChange, initSound: true),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            alignment: Alignment.center,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: -1.0,
              child: child,
            ),
          );
        },
      ),
    );
  }

  Future<void> _checkIfLanguageHasBeenChosen() async {
    String? languageCode = await _preferencesService.getString(
      AppPreferenceKey.selectLanguage,
    );

    if (languageCode == null) {
      _showLanguageDialog();
    }
  }

  Future<void> _showLanguageDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: widget.onLanguageChange),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkIfLanguageHasBeenChosen();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // STEP 1
          if (_stepSetup == 1)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  AppLocalization.of(context).translate("pages.firstSetupPage.itsAllUpToYouWithAppliDrive"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // STEP 2
          if (_stepSetup == 2)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: IndividualSelection(
                  initialOption: _selectedOption,
                  onOptionSelected: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
            ),
          // STEP 3
          if (_stepSetup == 3)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: QuestionAppliDrive(
                  selectedOption: _selectedOption ?? 0,
                  onQuestionAnswered: (value) {
                    setState(() {
                      _appmonName = value["name"];
                      _appmonId = value["id"];
                      _appmonColor = value["color"];
                      _stepSetup++;
                    });
                  },
                ),
              ),
            ),
          // STEP 4
          if (_stepSetup == 4)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppmonPresentation(
                  appmonName: _appmonName,
                  appmonId: _appmonId,
                  textBackgroundColor: _appmonColor ?? "black",
                ),
              ),
            ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: VersionApp(),
            ),
          ),
          if (_stepSetup == 1 || (_stepSetup == 2 && _selectedOption != null) || _stepSetup == 4)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, right: 10),
                child: TextButton(
                  onPressed: () {
                    if (_stepSetup == 4) {
                      _navigateToHomePage(context);
                    } else {
                      setState(() {
                        _stepSetup++;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalization.of(context).translate("pages.firstSetupPage.continue"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
