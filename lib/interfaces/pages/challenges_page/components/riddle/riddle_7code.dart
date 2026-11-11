import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/animated_white_button.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_appmon_list.dart';
import 'package:appli_drive_mobile/interfaces/components/image_outlined.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class Riddle7code extends StatefulWidget {
  final int numberChallenge;

  const Riddle7code({
    super.key,
    required this.numberChallenge,
  });

  @override
  State<Riddle7code> createState() => Riddle7codeState();
}

class Riddle7codeState extends State<Riddle7code> {
  final AudioService _audioService = AudioService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final PreferencesService _preferencesService = PreferencesService();

  bool _isLoading = true;
  String _selectedId = "";
  String _selectedName = "";
  List<Map<String, dynamic>> _optionList = [];
  bool _showResult = false;
  bool _result = false;

  void _getOptionList() async {
    List<String> possibleOptions = [];
    switch(widget.numberChallenge) {
      case 1:
        possibleOptions = ["D2L8", "D5H7", "D8R5"];
      case 2:
        possibleOptions = ["D7I3"];
      case 3:
        possibleOptions = ["D7A1"];
      case 4:
        possibleOptions = ["D5P2"];
      case 5:
        possibleOptions = ["D6M0"];
      case 6:
        possibleOptions = ["S6R2"];
      default:
        possibleOptions = ["S6G7"];
    }
    List<Map<String, dynamic>> result = await _databaseHelper.getAppmonCodeListByListId(possibleOptions);
    setState(() {
      _optionList = result;
      _isLoading = false;
    });
  }

  String _getAnswer() {
    switch(widget.numberChallenge) {
      case 1:
        return "D2L8";
      case 2:
        return "D7I3";
      case 3:
        return "D7A1";
      case 4:
        return "D5P2";
      case 5:
        return "D6M0";
      case 6:
        return "S6R2";
      default:
        return "S6G7";
    }
  }

  @override
  void initState() {
    super.initState();
    _getOptionList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage('assets/images/background/infoAppmon.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
            Colors.purple.withValues(alpha: 0.4),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60.0, right: 1.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextWithWhiteShadow(
                                    text: AppLocalization.of(context).translate(
                                      "pages.challengesPage.topic.7code.challenge.${widget.numberChallenge}"
                                    ),
                                    fontSize: 30,
                                    align: "center",
                                    height: 1.0,
                                    applySoftWrap: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Center( 
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            if (_showResult) ...[
                                              if (_result) ...[
                                                TextWithWhiteShadow(
                                                  text: AppLocalization.of(context).translate(
                                                    "pages.challengesPage.riddle7code.solved"
                                                  ),
                                                  fontSize: 25,
                                                  height: 1.0,
                                                  textColor: Colors.green,
                                                  align: "center",
                                                  applySoftWrap: true,
                                                ),
                                                divider(),
                                                TextWithWhiteShadow(
                                                  text: AppLocalization.of(context).translate(
                                                    "appmons.names.code${widget.numberChallenge}"
                                                  ),
                                                  fontSize: 25,
                                                  height: 1.0,
                                                  align: "center",
                                                  applySoftWrap: true,
                                                ),
                                                divider(),
                                                ImageOutlined(
                                                  asset: "assets/images/7code/COD${widget.numberChallenge}.png",
                                                  size: 250,
                                                  outlineSize: 5,
                                                ),
                                              ] else ...[
                                                TextWithWhiteShadow(
                                                  text: AppLocalization.of(context).translate(
                                                    "pages.challengesPage.riddle7code.failed"
                                                  ),
                                                  fontSize: 25,
                                                  height: 1.0,
                                                  textColor: Colors.red,
                                                  align: "center",
                                                  applySoftWrap: true,
                                                ),
                                                divider(),
                                                divider(),
                                                divider(),
                                                TextWithWhiteShadow(
                                                  text: AppLocalization.of(context).translate(
                                                    "pages.challengesPage.riddle7code.tryAgain"
                                                  ),
                                                  fontSize: 25,
                                                  height: 1.0,
                                                  align: "center",
                                                  applySoftWrap: true,
                                                ),
                                                divider(),
                                                TextWithWhiteShadow(
                                                  text: "10 ${AppLocalization.of(context).translate("pages.challengesPage.riddle7code.min")}",
                                                  fontSize: 25,
                                                  height: 1.0,
                                                  align: "center",
                                                  applySoftWrap: true,
                                                ),
                                                divider(),
                                                ImageOutlined(
                                                  asset: "assets/images/7code/COD${widget.numberChallenge}_shadow.png",
                                                  size: 250,
                                                  outlineSize: 5,
                                                ),
                                              ]
                                            ] else ...[
                                              Container(
                                                width: 350,
                                                height: 200,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[350],
                                                  border: Border.all(color: Colors.black, width: 2),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                child: Text(
                                                  AppLocalization.of(context).translate("challengesPage.riddle7code.description.${widget.numberChallenge}"),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  overflow: TextOverflow.visible,
                                                ),
                                              ),
                                              divider(),
                                              SizedBox(
                                                width: 300,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.black, width: 2),
                                                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                                              color: Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                _selectedId == ""
                                                                  ? AppLocalization.of(context).translate("components.dialogs.chooseAppmon.select")
                                                                  : _selectedName.toUpperCase(),
                                                                style: const TextStyle(fontSize: 25),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        iconAppmonListCode(context),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              divider(),
                                              if (_selectedId != "") ...[
                                                SizedBox(
                                                  width: 500,
                                                  height: 220,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          ImageOutlined(
                                                            asset: "assets/images/apps/$_selectedId.png",
                                                            size: 100,
                                                            outlineSize: 5,
                                                          ),
                                                          ImageOutlined(
                                                            asset: "assets/images/appmons/$_selectedId.png",
                                                            size: 190,
                                                            outlineSize: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ] else ...[
                                                const SizedBox(height: 220)
                                              ],
                                              divider(),
                                              resolveButton(_selectedId, context),
                                            ]
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
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
                      _audioService.playEffect("click");
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Divider(
        height: 10,
        thickness: 1,
        color: Colors.transparent,
      ),
    );
  }

  Widget iconAppmonListCode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () async {
          final selected = await showDialog<Map<String, dynamic>>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
              DialogAppmonList(appmonList: _optionList, showAppmonQuantity: false),
          );

          if (selected != null && selected.isNotEmpty) {
            setState(() {
              _selectedName = selected['name'];
              _selectedId = selected['id'];
            });
          }
        },
        icon: Image.asset(
          'assets/images/icons/list_box.png',
          height: 45,
        ),
      ),
    );
  }

  Widget resolveButton(String selectedId, BuildContext context) {
    bool appmonNotSelected = selectedId == "";
    return GestureDetector(
      onTap: () async {
        if (appmonNotSelected) return;
        bool result = selectedId == _getAnswer();
        if (result) {
          // audio 7 code appmon
          _preferencesService.setInt(AppPreferenceKey.actual7codeChallenge, widget.numberChallenge + 1);
          _preferencesService.setStringInStringList(AppPreferenceKey.sevencodeRevealedIds, widget.numberChallenge.toString());
        } else {
          // audio erro enigma
          // inclusão funcionalidade de trava
        }
        setState(() {
          _showResult = true;
          _result = result;
        });
      },
      child: Opacity(
        opacity: appmonNotSelected ? 0.3 : 1,
        child: AnimatedWhiteButton(
          text: 'RESOLVER',
        ),
      ),
    );
  }
}