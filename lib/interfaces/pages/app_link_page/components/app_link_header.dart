import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/appliarise_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AppLinkHeader extends StatefulWidget {
  final Appmon appmon;
  final Function(Locale) onLanguageChange;
  const AppLinkHeader({super.key, required this.appmon, required this.onLanguageChange});

  @override
  AppLinkHeaderState createState() => AppLinkHeaderState();
}

class AppLinkHeaderState extends State<AppLinkHeader> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconUnlink(context),
        ],
      ),
    );
  }

  Widget iconUnlink(context) {
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
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 241, 241, 241),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Center( 
                child: Text(
                  'APP UNLINK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              content: SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${widget.appmon.name.toUpperCase()}: ${AppLocalization.of(context).translate("pages.appLinkPage.unlinkDialog.context")}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 40.0,
                        color: Colors.red,
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        _audioPlayerMomentary.play(AssetSource('sounds/click.mp3')),
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AppliarisePage(
                            onLanguageChange: widget.onLanguageChange,
                            appmon: widget.appmon,
                          ),
                        ))
                      },
                      child: const Icon(
                        Icons.check,
                        size: 40.0,
                        color: Colors.green,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/unlink_box.png',
          height: 40,
        ),
      )
    );
  }
}
