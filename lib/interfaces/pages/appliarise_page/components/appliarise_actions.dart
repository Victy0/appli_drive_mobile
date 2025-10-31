import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_insert_code.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/app_link_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/appliarise_page.dart';
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
  const AppliariseActions({
    super.key,
    required this.appliDriveManagementService,
    required this.appmon,
    required this.onLanguageChange,
    required this.databaseHelper,
    required this.tutorialFinished,
    required this.appliDriveVersion,
  });

  @override
  AppliariseActionsState createState() => AppliariseActionsState();
}

class AppliariseActionsState extends State<AppliariseActions> {
  final AudioService _audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          if(widget.tutorialFinished) ...[
            infoButton(),
            const Spacer(),
            appLinkButton(),
          ]
        ],
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
          builder: (BuildContext context) => DialogInsertCode(
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
                startAnimation: false,
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
