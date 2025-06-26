import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_insert_code.dart';
import 'package:appli_drive_mobile/interfaces/pages/app_link_page/app_link_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/appliarise_page.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AppliariseActions extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  final Appmon appmon;
  final Function(Locale) onLanguageChange;
  final bool tutorialFinished;
  const AppliariseActions({
    super.key,
    required this.databaseHelper,
    required this.appmon,
    required this.onLanguageChange,
    required this.tutorialFinished,
  });

  @override
  AppliariseActionsState createState() => AppliariseActionsState();
}

class AppliariseActionsState extends State<AppliariseActions> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          infoButton(),
          const Spacer(),
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
          _audioPlayerMomentary.play(AssetSource('sounds/click.mp3')),
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
        final navigator = Navigator.of(context);
        Appmon? appmonLinked = await showDialog<Appmon>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => DialogInsertCode(
            databaseHelper: widget.databaseHelper,
            currentAppmon: widget.appmon,
          ),
        );
        if(appmonLinked != null) {
          if(appmonLinked.fusioned != null) {
            navigator.pushReplacement(MaterialPageRoute(
              builder: (context) => AppliarisePage(
                onLanguageChange: widget.onLanguageChange,
                appmon: appmonLinked,
              ),
            ));
            return;
          }
          navigator.pushReplacement(MaterialPageRoute(
            builder: (context) => AppLinkPage(
              onLanguageChange: widget.onLanguageChange,
              appmon: widget.appmon,
              appmonLinked: appmonLinked,
            ),
          ));
        }
      },
      child: const AnimatedWhiteButton(text: 'APP LINK'),
    );
  }
}
