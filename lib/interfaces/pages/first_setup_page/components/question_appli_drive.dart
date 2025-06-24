import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class QuestionAppliDrive extends StatefulWidget {
  final Function(Map<String, String>) onQuestionAnswered;
  final int selectedOption;

  const QuestionAppliDrive({
    super.key,
    required this.selectedOption,
    required this.onQuestionAnswered,
  });

  @override
  State<QuestionAppliDrive> createState() => QuestionAppliDriveState();
}

class QuestionAppliDriveState extends State<QuestionAppliDrive> {
  final PreferencesService _preferencesService = PreferencesService();
  final List<String> _questions = [
    "areYouAProtagonist",
    "doYouWantToMakeSomeoneSmile",
    "areYouFeelinIt",
    "areYouAlone",
    "doYouWantToConnect",
  ];

  Map<String, String> _getAppmonInformation(String appmon) {
    String name = "";
    String primaryColor = "";
    String secondaryColor = "";
    Map<String, String> info = {};
    switch(appmon) {
      case "0.true":  // GATCHMON
        name = "gatchmon";
        info = {"id": "D1Y8", "code": "AAA"};
        primaryColor = "red";
        secondaryColor = "blue";
        break;
      case "0.false":  // KOSOMON
        name = "kosomon";
        info = {"id": "D8I0", "code": "ELA"};
        primaryColor = "blue";
        secondaryColor = "pink";
        break;
      case "1.true":  // DOKAMON
        name = "dokamon";
        info = {"id": "D5S7", "code": "CKA"};
        primaryColor = "blue";
        secondaryColor = "grey";
        break;
      case "1.false":  // DRESSMON
        name = "dressmon";
        info = {"id": "D5V7", "code": "BHA"};
        primaryColor = "grey";
        secondaryColor = "pink";
        break;
      case "2.true":  // MUSIMON
        name = "musimon";
        info = {"id": "D6R3", "code": "BEA"};
        primaryColor = "yellow";
        secondaryColor = "orange";
        break;
      case "2.false":  // GENGOMON
        name = "gengomon";
        info = {"id": "D0Z8", "code": "AFA"};
        primaryColor = "purple";
        secondaryColor = "yellow";
        break;
      case "3.true":  // AIDMON
        name = "aidmon";
        info = {"id": "D8B1", "code": "BRA"};
        primaryColor = "white";
        secondaryColor = "pink";
        break;
      case "3.false":  // HACKMON
        name = "hackmon";
        info = {"id": "D9B2", "code": "ATA"};
        primaryColor = "black";
        secondaryColor = "red";
        break;
      case "4.true":  // ONMON
        name = "onmon";
        info = {"id": "D1V2", "code": "EQB"};
        primaryColor = "white";
        secondaryColor = "cyan";
        break;
      case "4.false":  // OFFMON
        name = "offmon";
        info = {"id": "D2U8", "code": "ERA"};
        primaryColor = "grey";
        secondaryColor = "red";
        break;
    }
    _preferencesService.setString(AppPreferenceKey.appmonPairingName, name);
    _preferencesService.setAppmonPairingEvolutionInfo(info);
    _preferencesService.setString(AppPreferenceKey.primaryColor, primaryColor);
    _preferencesService.setString(AppPreferenceKey.secondaryColor, secondaryColor);
    info.addAll({"name": name, "color": primaryColor});
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalization.of(context).translate("pages.firstSetupPage.questions.${_questions[widget.selectedOption]}"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                widget.onQuestionAnswered(
                  _getAppmonInformation("${widget.selectedOption}.true"),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalization.of(context).translate("pages.firstSetupPage.yes"),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 80),
            ElevatedButton(
              onPressed: () {
                widget.onQuestionAnswered(
                  _getAppmonInformation("${widget.selectedOption}.false"),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalization.of(context).translate("pages.firstSetupPage.no"),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
