import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_actions.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_summary_info.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_header.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/appli_drive_management_service.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class AppliarisePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Appmon appmon;
  final int appliDriveVersion;
  final bool tutorialFinished;
  const AppliarisePage({
    super.key,
    required this.onLanguageChange,
    required this.appmon,
    required this.appliDriveVersion,
    this.tutorialFinished = true,
  });

  @override
  AppliarisePageState createState() => AppliarisePageState();
}

class AppliarisePageState extends State<AppliarisePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final PreferencesService _preferencesService = PreferencesService();

  late AppliDriveManagementService _appliDriveManagementService;
  
  _getColorByAppmonType(String? appmonType) {
    switch (appmonType) {
      case "entertainment":
        return "red";
      case "game":
        return "orange";
      case "god":
        return "grey";
      case "life":
        return "pink";
      case "navi":
        return "green";
      case "social":
        return "blue";
      case "system":
        return "yellow";
      case "tool":
        return "purple";
    }
  }

  _setAppmonReveleadedId() async {
    _preferencesService.setStringInStringList(
      AppPreferenceKey.appmonRevealedIds,
      widget.appmon.id,
    );
    if(!widget.tutorialFinished) {
      _preferencesService.setBool(
      AppPreferenceKey.tutorialFinished,
      true
    );
      _preferencesService.setHintInHintRevealedList("appmon", "1");
      _preferencesService.setHintInHintRevealedList("appmon", "2");
      _preferencesService.setHintInHintRevealedList("appliDrive", "1");
      _preferencesService.setHintInHintRevealedList("7code");
    }
  }

  @override
  void initState() {
    super.initState();
    _appliDriveManagementService = AppliDriveManagementService(
      databaseHelper: _databaseHelper,
      preferencesService: _preferencesService,
    );
    _setAppmonReveleadedId();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackgroundImage(color: _getColorByAppmonType(widget.appmon.type.name)),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AppliariseHeader(
                  databaseHelper: _databaseHelper,
                  grade: widget.appmon.grade,
                  tutorialFinished: widget.tutorialFinished,
                ),
              ]
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppliariseSummaryInfo(appmon: widget.appmon),
                const SizedBox(height: 20),
                AppliariseImage(appmon: widget.appmon),
                const SizedBox(height: 40),
                AppliariseActions(
                  appliDriveManagementService: _appliDriveManagementService,
                  appmon: widget.appmon,
                  onLanguageChange: widget.onLanguageChange,
                  tutorialFinished: widget.tutorialFinished,
                  appliDriveVersion: widget.appliDriveVersion,
                ),
              ],
            ),
          ),
          
          ClosePageButton(onLanguageChange: widget.onLanguageChange),
        ],
      )
    );
  }
}
