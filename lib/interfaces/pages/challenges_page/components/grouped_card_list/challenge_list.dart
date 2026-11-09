import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/interfaces/pages/challenges_page/components/grouped_card_list/group_7code.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class ChallengeList extends StatefulWidget {
  final int actual7codeChallenge;

  const ChallengeList({
    super.key,
    required this.actual7codeChallenge,
  });

  @override
  State<ChallengeList> createState() => ChallengeListState();
}

class ChallengeListState extends State<ChallengeList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // 7 CODE
            Group7code(topic: "7code", actualChallenge: widget.actual7codeChallenge)
          ],
        ),
      ],
    );
  }
}

Widget topicName(BuildContext context, String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextWithWhiteShadow(
      text: AppLocalization.of(context).translate("pages.challengesPage.topic.$name.description"),
      fontSize: 22,
    ),
  );
}

Widget challengeButton(
  BuildContext context,
  String topicName,
  int number,
  int numberActualChallenge
) {
  bool isDisabled = numberActualChallenge < number;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Opacity(
      opacity: isDisabled ? 0.3 : 1.0,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          title: Text(
            AppLocalization.of(context).translate(
              "pages.challengesPage.topic.$topicName.challenge.$number"
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
          //onTap: isDisabled ? null : () => _openAppmonDialog(item['code']),
        ),
      ),
    ),
  );
}
