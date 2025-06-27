import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/components/custom_app_bar.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/seven_code_page/components/pad_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/seven_code_page/components/square_7code.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class SevenCodePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const SevenCodePage({super.key, required this.onLanguageChange});

  @override
  SevenCodePageState createState() => SevenCodePageState();
}

class SevenCodePageState extends State<SevenCodePage>{
  final PreferencesService _preferencesService = PreferencesService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  bool _hasAppliarise = false;
  bool _showAppliariseButton = false;
  List<String> _sevenCodeRevealed = [];
  Appmon? _dantemonInfo;
  bool _isLoading = true;

  void _get7codeRevealed() async {
    List<String> sevenCodeRevealedIdsUser = await _preferencesService.getStringList(
      AppPreferenceKey.sevencodeRevealedIds,
    );
    bool dantemonAppliarise = await _preferencesService.getBool(
      AppPreferenceKey.dantemonAppliarise,
    );

    Appmon? resultDantemon;
    if(dantemonAppliarise) {
      resultDantemon = await _databaseHelper.getSevenCodeInfo("CODE");
    }

    setState(() {
      _hasAppliarise = dantemonAppliarise;
      _sevenCodeRevealed = sevenCodeRevealedIdsUser;
      _dantemonInfo = resultDantemon;
      _showAppliariseButton = !dantemonAppliarise && sevenCodeRevealedIdsUser.length == 7;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _get7codeRevealed();
  }

  void _returnToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
          HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "7 CODE",
        image: "assets/images/icons/orb_box.png",
        backgroundColor: [
          Color.fromARGB(255, 212, 0, 255),
          Color.fromARGB(255, 162, 50, 253),
        ],
        textBlack: false,
      ),
      body: Stack(
        children: [
          const BackgroundImage(color: "purple", animateColor: true),
          Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Square7Code(
                      code:"COD1",
                      disabled: !_sevenCodeRevealed.contains("1"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper,
                    ),
                    Square7Code(
                      code:"COD2",
                      disabled: !_sevenCodeRevealed.contains("2"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper,
                    ),
                    Square7Code(
                      code:"COD3",
                      disabled: !_sevenCodeRevealed.contains("3"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper, 
                    ),
                    Square7Code(
                      code:"COD4",
                      disabled: !_sevenCodeRevealed.contains("4"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Square7Code(
                      code:"COD5",
                      disabled: !_sevenCodeRevealed.contains("5"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper,
                    ),
                    Square7Code(
                      code:"COD6",
                      disabled: !_sevenCodeRevealed.contains("6"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper,
                    ),
                    Square7Code(
                      code:"COD7",
                      disabled: !_sevenCodeRevealed.contains("7"),
                      hasAppliarise: _hasAppliarise,
                      databaseHelper: _databaseHelper,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: PadImage(
                  hasAppliarise: _hasAppliarise,
                ),
              ),
              const SizedBox(height: 10),
              actionsRow(),
              const SizedBox(height: 120),
            ],
          ),
          ClosePageButton(onLanguageChange: widget.onLanguageChange, onTap: _returnToHomePage),
        ],
      ),
    );
  }

  Widget actionsRow() {
    return _hasAppliarise && _dantemonInfo != null
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: IconButton(
                  onPressed: () => {
                    showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => DialogInfoAppmon(appmon: _dantemonInfo, interface: "appliArise"),
                    ),
                  },
                  icon: Image.asset(
                    'assets/images/icons/magnifying_glass_box.png',
                    height: 50,
                  ),
                ),
              ),
              const Spacer(),
              TextWithWhiteShadow(
                text: AppLocalization.of(context).translate("appmons.names.${_dantemonInfo?.name}"),
                fontSize: 40
              )
            ],
          ),
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _showAppliariseButton
                ? () async {
                    setState(() {
                      _hasAppliarise = true;
                    });
                    _preferencesService.setBool(
                      AppPreferenceKey.dantemonAppliarise,
                      true,
                    );
                  }
                : null,
              child: Opacity(
                opacity: _showAppliariseButton ? 1.0 : 0.2,
                child: const AnimatedWhiteButton(text: 'APPLIARISE'),
              ),
            ),
          ],
        );
  }
}
