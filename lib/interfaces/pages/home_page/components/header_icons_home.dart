import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_appmon_code_list.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_change_language.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HeaderIconsHome extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final DatabaseHelper databaseHelper;
  final bool tutorialFinished;
  const HeaderIconsHome({
    super.key,
    required this.onLanguageChange,
    required this.databaseHelper,
    required this.tutorialFinished,
  });

  @override
  HeaderIconsHomeState createState() => HeaderIconsHomeState();
}

class HeaderIconsHomeState extends State<HeaderIconsHome> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  
  late List<Map<String, dynamic>> appmonCodeList;
  
  _getAppmonCodeList() async {
    appmonCodeList = await widget.databaseHelper.getAppmonCodeList(1);
  }

  @override
  void initState() {
    super.initState();
    _getAppmonCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconInformation(context),
          const SizedBox(width: 15),
          iconLanguage(context, widget.onLanguageChange),
          const Spacer(),
          if(widget.tutorialFinished)
            iconAppmonListCode(context)
        ],
      ),
    );
  }

  Widget iconInformation(context) {
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
            builder: (BuildContext context) => Dialog(
              backgroundColor: const Color.fromARGB(255, 241, 241, 241),
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "APPLI DRIVE MOBILE",
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center (
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalization.of(context).translate("pages.homePage.informationDialog.context"),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.check,
                            size: 40.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/question_mark_box.png',
          height: 40,
        ),
      ),
    );
  }

  Widget iconLanguage(context, onLanguageChange) {
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
            builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: onLanguageChange),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/language_box.png',
          height: 40,
        ),
      ),
    );
  }

  Widget iconAppmonListCode(context) {
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
            builder: (BuildContext context) => DialogAppmonCodeList(appmonCodeList: appmonCodeList),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/list_box.png',
          height: 40,
        ),
      ),
    );
  }
}
