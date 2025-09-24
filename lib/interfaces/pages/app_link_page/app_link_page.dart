import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/components/app_link_image.dart';
import 'package:appli_drive_mobile/interfaces/components/app_link_init.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/components/app_link_summary_info.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/components/app_link_actions.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:flutter/material.dart';

class AppLinkPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Appmon appmon;
  final Appmon appmonLinked;
  final int appliDriveVersion;
  const AppLinkPage({
    super.key,
    required this.onLanguageChange,
    required this.appmon,
    required this.appmonLinked,
    required this.appliDriveVersion,
  });

  @override
  AppLinkPageState createState() => AppLinkPageState();
}

class AppLinkPageState extends State<AppLinkPage> {
  final AudioService _audioService = AudioService();

  bool _appLinkAnimation = true;

  String _getColorByAppmonType(String? appmonType) {
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
    return "grey";
  }

  void _startApplinkAnimation() async {
    _audioService.playAudioSequence([
      "sounds/applink/names/${widget.appmon.id}.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}.mp3",
      "sounds/applink/names/${widget.appmon.id}_2.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_2.mp3",
      "sounds/applink/names/${widget.appmon.id}_2.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_2.mp3",
      "sounds/applink/names/${widget.appmon.id}_3.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_3.mp3",
      "sounds/applink/names/${widget.appmon.id}_3.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_3.mp3",
      "sounds/applink/names/${widget.appmon.id}_3.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_3.mp3",
      "sounds/applink/names/${widget.appmon.id}_4.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_4.mp3",
      "sounds/applink/names/${widget.appmon.id}_4.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_4.mp3",
      "sounds/applink/names/${widget.appmon.id}_4.mp3",
      "sounds/applink/names/${widget.appmonLinked.id}_4.mp3",
      "sounds/applink/applink_final.mp3",
    ]);
    await Future.delayed(Duration(seconds: 16));
    setState(() {
      _appLinkAnimation = false;
    });
    _audioService.playAudioSequence([
      "sounds/appliarise/appmon_name/${widget.appmon.id}.mp3",
      "sounds/applink/plus.mp3",
      "sounds/appliarise/appmon_name/${widget.appmonLinked.id}.mp3",
      "sounds/applink/end.mp3",
    ]);
  }

  @override
  void initState() {
    super.initState();
    _startApplinkAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (_appLinkAnimation)
            AppLinkInit(
              appmon: widget.appmon,
              appmonLinked: widget.appmonLinked,
              appmonFusioned: null,
            )
          else ...[
            BackgroundImage(color: _getColorByAppmonType("")),
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
                  const SizedBox(height: 5),
                  AppLinkActions(
                    appmon: widget.appmon,
                    appmonLinked: widget.appmonLinked,
                    onLanguageChange: widget.onLanguageChange,
                    appliDriveVersion: widget.appliDriveVersion,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            
            ClosePageButton(onLanguageChange: widget.onLanguageChange),
          ],
        ],
      )
    );
  }
}
