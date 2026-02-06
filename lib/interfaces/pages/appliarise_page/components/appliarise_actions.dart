import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_choose_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/app_link_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/appliarise_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/appli_drive_management_service.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';

class AppliariseActions extends StatefulWidget {
  final AppliDriveManagementService appliDriveManagementService;
  final Appmon appmon;
  final Function(Locale) onLanguageChange;
  final DatabaseHelper databaseHelper;
  final bool tutorialFinished;
  final int appliDriveVersion;
  final bool startAnimation;
  final bool appGatai;
  const AppliariseActions({
    super.key,
    required this.appliDriveManagementService,
    required this.appmon,
    required this.onLanguageChange,
    required this.databaseHelper,
    required this.tutorialFinished,
    required this.appliDriveVersion,
    this.startAnimation = true,
    this.appGatai = false,
  });

  @override
  AppliariseActionsState createState() => AppliariseActionsState();
}

class AppliariseActionsState extends State<AppliariseActions> {
  final AudioService _audioService = AudioService();

  bool _showIcons = false;
  bool _isDescriptionPhase = true;
  bool _showDescription = false;
  String _textDescritpion = "";

  int _getDelayAnimationIcons(int grade) {
    if (grade == 2) {
      return 2;
    }
    return 1;
  }

  int _getDelayChangeText(int grade) {
    if (grade == 2) {
      return 1;
    }
    return 1;
  }

  @override
  void initState() {
    super.initState();
      _textDescritpion = "appmons.appliarise.grade.${widget.appmon.grade.name}";
      Future.delayed(Duration(seconds: 5 - (widget.appGatai ? 2 : 0)), () {
        setState(() {
          _showDescription = true;
        });
      });
      Future.delayed(Duration(seconds: 7 + _getDelayChangeText(widget.appmon.grade.id) - (widget.appGatai ? 2 : 0)), () {
        setState(() {
          _textDescritpion = "appmons.appliarise.appmons.${widget.appmon.code.toLowerCase()}";
        });
      });
      Future.delayed(Duration(seconds: 13 + _getDelayAnimationIcons(widget.appmon.grade.id) - (widget.appGatai ? 2 : 0)), () {
      setState(() {
        _isDescriptionPhase = false;
        _showIcons = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: 80,
        child: _isDescriptionPhase
          ? AnimatedOpacity(
            opacity: (!widget.startAnimation || _showDescription)
                ? 1.0
                : 0.0,
            duration: const Duration(seconds: 1),
            child: TextWithWhiteShadow(
              text: AppLocalization.of(context).translate(
                _textDescritpion,
              ),
              fontSize: 28,
              applySoftWrap: true,
              align: "center",
            ),
          )
        : AnimatedOpacity(
            opacity: (!widget.startAnimation || _showIcons) ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: Row(
              children: [
                if (widget.tutorialFinished) ...[
                  infoButton(),
                  const Spacer(),
                  appLinkButton(),
                ]
              ],
            ),
          ),
        ),
    );
  }

  Widget infoButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () => {
          _audioService.playAudioSequence([
            "sounds/appliarise/appmon_name/${widget.appmon.id}.mp3",
          ]),
          showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => DialogInfoAppmon(appmon: widget.appmon, interface: "appliArise"),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/magnifying_glass_box.png',
          height: 45,
        ),
      ),
    );
  }

  Widget appLinkButton() {
    return GestureDetector(
      onTap: () async {
        _audioService.pauseBackground();
        _audioService.playAppLinkWaitSequence([
          "sounds/applink/applink.mp3",
          "sounds/applink/names/${widget.appmon.id}.mp3",
          "sounds/applink/applink_bit.mp3",
          "sounds/applink/names/${widget.appmon.id}.mp3",
          "sounds/applink/applink_bit.mp3",
          "sounds/applink/names/${widget.appmon.id}.mp3",
          "sounds/applink/applink_bit.mp3",
          "sounds/applink/names/${widget.appmon.id}.mp3",
          "sounds/applink/applink_bit.mp3",
          "sounds/applink/names/${widget.appmon.id}.mp3",
          "sounds/applink/applink_bit.mp3",
        ]);
        final navigator = Navigator.of(context);
        Appmon? appmonLinked = await showDialog<Appmon>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => DialogChooseAppmon(
            appliDriveManagementService: widget.appliDriveManagementService,
            appliDriveVersion: widget.appliDriveVersion,
            currentAppmon: widget.appmon,
            databaseHelper: widget.databaseHelper,
          ),
        );
        if(appmonLinked != null) {
          if(appmonLinked.fusioned != null) {
            navigator.pushReplacement(MaterialPageRoute(
              builder: (context) => AppliarisePage(
                onLanguageChange: widget.onLanguageChange,
                appmon: appmonLinked,
                appliDriveVersion: widget.appliDriveVersion,
                startAnimation: true,
                appmonLinked1: appmonLinked.appmonLinked1,
                appmonLinked2: appmonLinked.appmonLinked2,
              ),
            ));
            return;
          }
          navigator.pushReplacement(MaterialPageRoute(
            builder: (context) => AppLinkPage(
              onLanguageChange: widget.onLanguageChange,
              appmon: widget.appmon,
              appmonLinked: appmonLinked,
              appliDriveVersion: widget.appliDriveVersion,
            ),
          ));
        }
      },
      child: const AnimatedWhiteButton(text: 'APP LINK'),
    );
  }
}
