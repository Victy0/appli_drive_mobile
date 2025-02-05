import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_insert_code.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AppmonActions extends StatefulWidget {
  final Appmon appmon;
  final Function(Locale) onLanguageChange;
  const AppmonActions({super.key, required this.appmon, required this.onLanguageChange});

  @override
  AppmonActionsState createState() => AppmonActionsState();
}

class AppmonActionsState extends State<AppmonActions> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Container(
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
                height: 50,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              Appmon? appmonLink = await showDialog<Appmon>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => const DialogInsertCode(),
              );
              if(appmonLink != null) {
                print(appmonLink);
                /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AppliarisePage(onLanguageChange: widget.onLanguageChange, appmon: widget.appmon, appmonLinked: appmonLink),
                ));*/
              }
            },
            child: const AnimatedWhiteButton(text: 'APPLINK'),
          ),
        ],
      ),
    );
  }
}
