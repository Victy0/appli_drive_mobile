import 'package:appli_drive_mobile/interfaces/components/app_link_init.dart';
import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_actions.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_init.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_summary_info.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/components/appliarise_header.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/appli_drive_management_service.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class AppliarisePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Appmon appmon;
  final int appliDriveVersion;
  final bool tutorialFinished;
  final bool startAnimation;
  final Appmon? appmonLinked1;
  final Appmon? appmonLinked2;
  const AppliarisePage({
    super.key,
    required this.onLanguageChange,
    required this.appmon,
    required this.appliDriveVersion,
    this.tutorialFinished = true,
    this.startAnimation = true,
    this.appmonLinked1,
    this.appmonLinked2,
  });

  @override
  AppliarisePageState createState() => AppliarisePageState();
}

class AppliarisePageState extends State<AppliarisePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final PreferencesService _preferencesService = PreferencesService();
  final AudioService _audioService = AudioService();

  late AppliDriveManagementService _appliDriveManagementService;

  bool _appliariseAnimation = true;
  bool _appGataiAnimation = true;
  
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
    return "";
  }

  int _getDelayAnimation(int grade, bool isForAnimation) {
    if (grade == 2) {
      return isForAnimation ? 4 : 18;
    }
    return isForAnimation ? 0 : 13;
  }

  void _startAppGataiAnimation() async {
    _audioService.playAudioSequence([
      "sounds/applink/names/${widget.appmonLinked1?.id}.mp3",
      "sounds/applink/names/${widget.appmonLinked2?.id}.mp3",
      "sounds/applink/names/${widget.appmonLinked1?.id}.mp3",
      "sounds/applink/names/${widget.appmonLinked2?.id}.mp3",
      "sounds/applink/names/${widget.appmonLinked1?.id}_2.mp3",
      "sounds/applink/names/${widget.appmonLinked2?.id}_2.mp3",
      "sounds/applink/names/${widget.appmonLinked1?.id}_2.mp3",
      "sounds/applink/names/${widget.appmonLinked2?.id}_2.mp3",
      "sounds/applink/names/${widget.appmonLinked1?.id}_3.mp3",
      "sounds/applink/names/${widget.appmonLinked2?.id}_3.mp3",
      "sounds/applink/names/${widget.appmonLinked1?.id}_3.mp3",
      "sounds/applink/names/${widget.appmonLinked2?.id}_3.mp3",
      "sounds/applink/appgatai_final.mp3",
    ]);
    await Future.delayed(Duration(seconds: 17));
    setState(() {
      _appGataiAnimation = false;
    });
    _audioService.playAudioSequence([
      "sounds/appliarise/appmon_name/${widget.appmon.id}.mp3",
      "sounds/applink/end.mp3",
      "sounds/appliarise/appmon_start/${widget.appmon.id}.mp3",
    ]);
  }

  void _startAppliariseAnimation() async {
    _audioService.playAudioSequence([
      "sounds/appliarise/appliarise_${widget.appmon.grade.name}.mp3",
      "sounds/appliarise/appmon_name/${widget.appmon.id}.mp3",
      "sounds/appliarise/appliarise_end.mp3",
      "sounds/appliarise/appmon_start/${widget.appmon.id}.mp3",
    ]);
    await Future.delayed(Duration(seconds: 12 + _getDelayAnimation(widget.appmon.grade.id, true)));
    setState(() {
      _appliariseAnimation = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _appliDriveManagementService = AppliDriveManagementService(
      databaseHelper: _databaseHelper,
      preferencesService: _preferencesService,
    );
    _appliDriveManagementService.setAppmonReveleadedId(
      widget.appmon.id,
      widget.tutorialFinished,
    );
    if(widget.appmonLinked1 != null) {
      _appliariseAnimation = false;
      _startAppGataiAnimation();
    }
    if(widget.startAnimation) {
      _appGataiAnimation = false;
      _startAppliariseAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if(_appGataiAnimation && widget.appmonLinked1 != null) ...[
            AppLinkInit(
              appmon: widget.appmonLinked1 ?? widget.appmon,
              appmonLinked: widget.appmonLinked2 ?? widget.appmon,
              appmonFusioned: widget.appmon,
            )
          ] else if (_appliariseAnimation && widget.startAnimation) ...[
            AppliariseInit(appmon: widget.appmon)
          ] else ...[
            BackgroundImage(color: _getColorByAppmonType(widget.appmon.type.name)),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AppliariseHeader(
                    appmon: widget.appmon,
                    tutorialFinished: widget.tutorialFinished,
                  ),
                ]
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppliariseSummaryInfo(
                    appmon: widget.appmon,
                    startAnimation: widget.startAnimation,
                  ),
                  const SizedBox(height: 20),
                  AppliariseImage(
                    appmon: widget.appmon,
                    startAnimation: widget.startAnimation,
                  ),
                  const SizedBox(height: 40),
                  AppliariseActions(
                    appliDriveManagementService: _appliDriveManagementService,
                    appmon: widget.appmon,
                    onLanguageChange: widget.onLanguageChange,
                    databaseHelper: _databaseHelper,
                    tutorialFinished: widget.tutorialFinished,
                    appliDriveVersion: widget.appliDriveVersion,
                  ),
                ],
              ),
            ),
            ClosePageButton(onLanguageChange: widget.onLanguageChange),
          ]
        ]
      ),
    );
  }
}
