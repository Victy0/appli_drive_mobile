import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/components/app_link_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/components/app_link_summary_info.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/components/app_link_header.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppLinkPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Appmon appmon;
  final Appmon appmonLinked;
  const AppLinkPage({super.key, required this.onLanguageChange, required this.appmon, required this.appmonLinked});

  @override
  AppLinkPageState createState() => AppLinkPageState();
}

class AppLinkPageState extends State<AppLinkPage> {
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
                AppLinkHeader(appmon: widget.appmon, onLanguageChange: widget.onLanguageChange),
              ]
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppLinkSummaryInfo(
                  appmon: widget.appmon,
                  appmonLinked: widget.appmonLinked
                ),
                const SizedBox(height: 100),
                AppLinkImage(
                  appmon: widget.appmon,
                  appmonLinked: widget.appmonLinked,
                  linkColor: _getColorByAppmonType(widget.appmonLinked.type.name),
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
