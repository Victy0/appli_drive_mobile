import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appmon_actions.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appmon_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appmon_summary_info.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/header_icons_appliarise.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppliarisePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Appmon appmon;
  final Appmon? appmonLinked;
  const AppliarisePage({super.key, required this.onLanguageChange, required this.appmon, required this.appmonLinked});

  @override
  AppliarisePageState createState() => AppliarisePageState();
}

class AppliarisePageState extends State<AppliarisePage> {
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
      case "tools":
        return "purple";
    }
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
                HeaderIconsAppliarise(grade: widget.appmon.grade.name),
              ]
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppmonSummaryInfo(appmon: widget.appmon),
                const SizedBox(height: 20),
                AppmonImage(appmon: widget.appmon),
                const SizedBox(height: 40),
                AppmonActions(
                  appmon: widget.appmon,
                  hasAppmonLinked: widget.appmonLinked != null,
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
