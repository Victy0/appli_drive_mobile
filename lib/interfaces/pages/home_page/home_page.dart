import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_insert_code.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
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
  String _appmonColorPrimary = "";
  String _appmonColorSecondary = "";
  List<Map<String, String>> _appmonPairingEvolutionInfo = [];
  bool _tutorialFinished = false;
  bool _show7codeIcon = false;
  bool _isLoading = true;

  _getInitialValues() async {
    final String appmonName = await _preferencesService.getString(AppPreferenceKey.appmonPairingName) ?? "";
    final String appmonColorPrimary = await _preferencesService.getString(AppPreferenceKey.primaryColor) ?? "";
    final String appmonColorSecondary = await _preferencesService.getString(AppPreferenceKey.secondaryColor) ?? "";
    final List<Map<String, String>> appmonPairingEvolutionInfo = await _preferencesService.getAppmonPairingEvolutionInfo();
    final bool tutorialFinished = await _preferencesService.getBool(AppPreferenceKey.tutorialFinished);
    final bool show7codeIcon = await _preferencesService.getBool(AppPreferenceKey.show7codeIcon);
    
    setState(() {
      _appmonPairingName = appmonName;
      _appmonColorPrimary = appmonColorPrimary;
      _appmonColorSecondary = appmonColorSecondary;
      _appmonPairingEvolutionInfo = appmonPairingEvolutionInfo;
      _tutorialFinished = tutorialFinished;
      _show7codeIcon = show7codeIcon;
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
                HeaderIconsHome(
                  onLanguageChange: widget.onLanguageChange,
                  tutorialFinished: _tutorialFinished,
                ),
                DetailRectangle(
                  position: 'left',
                  primaryColor: _appmonColorPrimary,
                  secondaryColor: _appmonColorSecondary,
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
                  tutorialFinished: _tutorialFinished,
                ),
                ...(_tutorialFinished
                  ? tutorialFinishedWidgets()
                  : tutorialUnfinishedWidgets()
                ),
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
                DetailRectangle(
                  position: 'right',
                  primaryColor: _appmonColorPrimary,
                  secondaryColor: _appmonColorSecondary,
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> tutorialFinishedWidgets() {
    return [
      const SizedBox(height: 70),
      GestureDetector(
        onTap: () async {
          final navigator = Navigator.of(context);
          Appmon? appmon = await showDialog<Appmon>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const DialogInsertCode(),
          );
          if (appmon != null) {
            navigator.pushReplacement(MaterialPageRoute(
              builder: (context) => AppliarisePage(
                onLanguageChange: widget.onLanguageChange,
                appmon: appmon,
              ),
            ));
          }
        },
        child: const AnimatedWhiteButton(text: 'APPLIARISE'),
      ),
      const SizedBox(height: 20),
      MenuIcons(
        onLanguageChange: widget.onLanguageChange,
        show7codeIcon: _show7codeIcon,
      ),
    ];
  }

  List<Widget> tutorialUnfinishedWidgets() {
    return [
      const SizedBox(height: 10),
      TextWithWhiteShadow(
        text: String.fromCharCode(Icons.arrow_upward.codePoint),
        fontSize: 30,
        align: "center",
        applySoftWrap: true,
        fontFamily: true,
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return scanlineShader(bounds.size);
                },
                blendMode: BlendMode.srcATop,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(226, 255, 255, 255),
                    BlendMode.modulate,
                  ),
                  child: Image.asset(
                    "assets/images/appmons/${_appmonPairingEvolutionInfo[0]["id"]}.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextWithWhiteShadow(
                text: AppLocalization.of(context)
                    .translate("pages.homePage.tutorialAppliarise"),
                fontSize: 26,
                align: "center",
                applySoftWrap: true,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Shader scanlineShader(Size size) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: List.generate(
        (size.height / 2).floor(),
        (i) => i.isEven
          ? Colors.white.withOpacity(0.5)
          : Colors.transparent,
      ),
      stops: List.generate(
        (size.height / 2).floor(),
        (i) => i / (size.height / 2),
      ),
      tileMode: TileMode.repeated,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
  }
}
