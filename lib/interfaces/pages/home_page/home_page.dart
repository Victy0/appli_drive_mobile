import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_insert_code.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/components/detail_rectangle.dart';
import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/appliarise_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/components/header_icons_home.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/components/menu_icons.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/components/pairing_menu.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final bool initSound;
  const HomePage({super.key, required this.onLanguageChange, required this.initSound});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PreferencesService _preferencesService = PreferencesService();
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;

  String _appmonPairingName = "";
  List<Map<String, String>> _appmonPairingEvolutionInfo = [];
  bool _isLoading = true;

  _getInitialValues() async {
    final String appmonName = await _preferencesService.getString(AppPreferenceKey.appmonPairingName) ?? "";
    final List<Map<String, String>> appmonPairingEvolutionInfo = await _preferencesService.getAppmonPairingEvolutionInfo();
    
    setState(() {
      _appmonPairingName = appmonName;
      _appmonPairingEvolutionInfo = appmonPairingEvolutionInfo;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if(widget.initSound) {
      _audioPlayerMomentary.play(AssetSource('sounds/start.mp3'));
    }
    _getInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(color: "grey"),
          // detail top
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                HeaderIconsHome(onLanguageChange: widget.onLanguageChange),
                const DetailRectangle(
                  position: 'left',
                  primaryColor: 'white',
                  secondaryColor: 'blue',
                ),
              ]
            ),
          ),
          // content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PairingMenu(
                  onLanguageChange: widget.onLanguageChange,
                  appmonPairingName: _appmonPairingName,
                  appmonEvolutionInfo: _appmonPairingEvolutionInfo,
                ),
                const SizedBox(height: 70),
                GestureDetector(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    Appmon? appmon = await showDialog<Appmon>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => const DialogInsertCode(),
                    );
                    if(appmon != null) {
                      navigator.pushReplacement(MaterialPageRoute(
                        builder: (context) => AppliarisePage(onLanguageChange: widget.onLanguageChange, appmon: appmon),
                      ));
                    }
                  },
                  child: const AnimatedWhiteButton(text: 'APPLIARISE'),
                ),
                const SizedBox(height: 20),
                MenuIcons(onLanguageChange: widget.onLanguageChange),
              ],
            ),
          ),
          // detail bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${AppLocalization.of(context).translate("pages.homePage.appliDriveVersion")} - STANDART",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const DetailRectangle(
                  position: 'right',
                  primaryColor: 'white',
                  secondaryColor: 'blue',
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
