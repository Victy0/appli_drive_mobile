import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_actions.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_summary_info.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_header.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class AppliarisePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Appmon appmon;
  const AppliarisePage({super.key, required this.onLanguageChange, required this.appmon});

  @override
  AppliarisePageState createState() => AppliarisePageState();
}

class AppliarisePageState extends State<AppliarisePage> {
  final PreferencesService _preferencesService = PreferencesService();
  
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
    _preferencesService.setStringInStringList('appmon_revealed_ids', widget.appmon.id);
  }

  @override
  void initState() {
    super.initState();
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
                AppliariseHeader(grade: widget.appmon.grade),
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
                  appmon: widget.appmon,
                  onLanguageChange: widget.onLanguageChange
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
