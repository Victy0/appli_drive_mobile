import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/appli_drive_management_service.dart';
import 'package:flutter/material.dart';

class QuestionAppliDrive extends StatefulWidget {
  final Function(Map<String, String>) onQuestionAnswered;
  final int selectedOption;
  final AppliDriveManagementService appliDriveManagementService;

  const QuestionAppliDrive({
    super.key,
    required this.selectedOption,
    required this.onQuestionAnswered,
    required this.appliDriveManagementService,
  });

  @override
  State<QuestionAppliDrive> createState() => QuestionAppliDriveState();
}

class QuestionAppliDriveState extends State<QuestionAppliDrive> {
  final List<String> _questions = [
    "areYouAProtagonist",
    "doYouWantToMakeSomeoneSmile",
    "areYouFeelinIt",
    "areYouAlone",
    "doYouWantToConnect",
  ];

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
                final info = widget.appliDriveManagementService
                  .getAppmonBuddyInformation("${widget.selectedOption}.true");
                widget.onQuestionAnswered(info);
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
                final info = widget.appliDriveManagementService
                  .getAppmonBuddyInformation("${widget.selectedOption}.false");
                widget.onQuestionAnswered(info);
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
